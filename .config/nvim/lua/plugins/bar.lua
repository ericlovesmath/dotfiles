return {
    "rebelot/heirline.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local utils = require("heirline.utils")
        local conds = require("heirline.conditions")

        -- [[ STATUSLINE CONFIGURATION ]] --

        local ViMode = {
            static = {
                -- stylua: ignore
                mode_names = {
                    n = "NORMAL", i = "INSERT", c = "COMMAND", R = "REPLACE",
                    v = "VISUAL", V = "V·LINE", ["\22"] = "V·BLOCK",
                    s = "SELECT", S = "S·LINE", ["\19"] = "S·BLOCK",
                    t = "TERM",   r = "...",    ["!"]   = "!",
                },
            },
            provider = function(self)
                return " " .. self.mode_names[self.mode] .. " "
            end,
            hl = function(self)
                return { fg = "black", bg = self.mode_color(), bold = true }
            end,
            update = {
                "ModeChanged",
                pattern = "*:*",
                callback = vim.schedule_wrap(function()
                    vim.cmd("redrawstatus")
                end),
            },
        }

        local FileName = {
            -- Filename cut off, modified flag, readonly
            provider = " %<%t%m%r ",
            hl = "StatusLine"
        }

        local Diagnostics = {
            condition = conds.lsp_attached,
            update = { "DiagnosticChanged", "BufEnter" },
            init = function(self)
                self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
                self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
                self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
            end,
            provider = function(self)
                return " +" .. self.hints .. " ~" .. self.warnings .. " -" .. self.errors
            end,
        }

        local AlignRight = { provider = "%=" }

        local FileType = { provider = "%Y " }

        local Percentage = {
            provider = " %3p%% ",
            hl = "StatusLine"
        }

        local RulerOrWordCount = {
            provider = function()
                if vim.bo.filetype == "markdown" then
                    local wc = vim.fn.wordcount()
                    local count = wc.visual_words ~= nil and wc.visual_words or wc.cursor_words
                    return " " .. count .. ":" .. wc.words .. " "
                else
                    return " %3l:%2v "
                end
            end,
            hl = function(self)
                return { fg = "black", bg = self.mode_color() }
            end,
        }

        local StatusLine = {
            init = function(self)
                self.mode = vim.fn.mode(1):sub(1, 1)
                self.mode_color = function()
                    -- stylua: ignore
                    local to_color = {
                        n = "func",   i = "statement", c = "constant", R = "constant",
                        v = "string", V = "string",    ["\22"] = "string",
                        s = "white",  S = "white",     ["\19"] = "white",
                        t = "func",   r = "white",     ["!"] = "red",
                    }
                    return to_color[self.mode]
                end
            end,
            hl = { fg = "None" },
            { ViMode, FileName, Diagnostics, AlignRight, FileType, Percentage, RulerOrWordCount },
        }

        -- [[ BUFFERLINE CONFIGURATION ]] --

        -- Manual Buffer cache to hide bar with only one or zero buffers visible
        local buflist_cache = {}
        vim.api.nvim_create_autocmd({ "UIEnter", "BufAdd", "BufDelete" }, {
            group = vim.api.nvim_create_augroup("HeirlineUpdateBufCache", { clear = true }),
            callback = function()
                vim.schedule(function()
                    buflist_cache = vim.tbl_filter(function(bufnr)
                        return vim.api.nvim_get_option_value("buflisted", { buf = bufnr })
                    end, vim.api.nvim_list_bufs())

                    vim.o.showtabline = #buflist_cache > 1 and 2 or 0
                end)
            end,
        })

        local BuflineFileName = {
            provider = function(self)
                return " " .. self.fname .. " "
            end,
            hl = function(self)
                return { bold = self.is_active or self.is_visible, italic = true }
            end,
        }

        local BuflineFileFlags = {
            provider = "• ",
            condition = function(self)
                return vim.api.nvim_get_option_value("modified", { buf = self.bufnr })
            end,
        }

        local BuflineBlock = {
            init = function(self)
                local fname = vim.api.nvim_buf_get_name(self.bufnr)
                self.fname = fname == "" and "[No Name]" or vim.fn.fnamemodify(fname, ":t")
            end,
            hl = function(self)
                local c = { fg = "black", bg = "func" }
                return self.is_active and c or "TabLine"
            end,
            on_click = {
                callback = function(_, minwid, _, _)
                    vim.api.nvim_win_set_buf(0, minwid)
                end,
                minwid = function(self)
                    return self.bufnr
                end,
                name = "heirline_tabline_click",
            },
            { BuflineFileName, BuflineFileFlags },
        }

        -- Adds extra gap between buffers
        local BuflineBlockWrapped = {
            provider = function(self)
                return buflist_cache[1] ~= self.bufnr and " " or ""
            end,
            hl = "TabLine",
            { BuflineBlock },
        }

        local BufferLine = utils.make_buflist(
            BuflineBlockWrapped,
            { provider = "", hl = "TabLine" },
            { provider = " ", hl = "TabLine" },
            function()
                return buflist_cache
            end,
            false
        )

        -- [[ COLORSCHEME ]] --

        local function setup_colors()
            return {
                func = utils.get_highlight("Function").fg,
                statement = utils.get_highlight("Statement").fg,
                constant = utils.get_highlight("@constant").fg,
                string = utils.get_highlight("String").fg,
                comment = utils.get_highlight("@comment").fg,
            }
        end

        require("heirline").setup({
            statusline = StatusLine,
            tabline = BufferLine,
            opts = {
                colors = setup_colors,
            },
        })

        vim.api.nvim_create_autocmd("ColorScheme", {
            group = vim.api.nvim_create_augroup("HeirlineColorscheme", { clear = true }),
            callback = function()
                utils.on_colorscheme(setup_colors)
            end,
        })
    end,
}
