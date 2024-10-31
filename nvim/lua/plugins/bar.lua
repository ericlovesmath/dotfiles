return {
    "rebelot/heirline.nvim",
    config = function()
        local utils = require("heirline.utils")
        local conds = require("heirline.conditions")

        local right_sep = ""
        local left_sep = ""
        local right_sep_thin = ""

        -- [[ COLORSCHEME ]] --

        local function setup_colors()
            return {
                func = utils.get_highlight("Function").fg,
                statement = utils.get_highlight("Statement").fg,
                constant = utils.get_highlight("@constant").fg,
                string = utils.get_highlight("String").fg,
                comment = utils.get_highlight("@comment").fg,
                visual = utils.get_highlight("Visual").bg,
            }
        end

        vim.api.nvim_set_hl(0, "TablineFill", { link = "Visual" })
        vim.api.nvim_create_autocmd("ColorScheme", {
            group = vim.api.nvim_create_augroup("HeirlineColorscheme", { clear = true }),
            callback = function()
                utils.on_colorscheme(setup_colors)
            end,
        })

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
            {
                provider = right_sep,
                hl = function(self)
                    return { fg = self.mode_color(), bg = "visual" }
                end,
            },
        }

        local FileName = {
            -- Filename cut off, modified flag, readonly
            provider = " %<%t%m%r ",
            hl = "Visual",
            {
                provider = right_sep,
                hl = { fg = "visual", bg = "None" },
            },
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

        local FileType = {
            provider = "%Y ",
            {
                provider = left_sep,
                hl = { fg = "visual", bg = "None" },
            },
        }

        local Percentage = {
            provider = " %3p%% ",
            hl = "Visual",
            {
                provider = left_sep,
                hl = function(self)
                    return { fg = self.mode_color(), bg = "visual" }
                end,
            },
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

        -- local MacroRecording = {
        --     init = function(self)
        --         self.reg_recording = vim.fn.reg_recording()
        --     end,
        --     {
        --         condition = function(self)
        --             return self.reg_recording ~= ""
        --         end,
        --         provider = function(self)
        --             return "rec @" .. self.reg_recording .. " "
        --         end,
        --     },
        --     hl = { bold = true },
        --     update = { "RecordingEnter", "RecordingLeave" },
        -- }
        --
        -- local SearchCount = {
        --     init = function(self)
        --         local ok, search = pcall(vim.fn.searchcount)
        --         if ok and search.total > 0 then
        --             self.search = search
        --         end
        --     end,
        --     condition = function()
        --         local cmd = vim.fn.getcmdtype()
        --         return cmd == "?" or cmd == "/"
        --     end,
        --     provider = function(self)
        --         local total = math.min(self.search.total, self.search.maxcount)
        --         return string.format("[%d/%d]", self.search.current, total)
        --     end,
        --     hl = { bold = true },
        -- }

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
            {
                ViMode,
                FileName,
                Diagnostics,
                AlignRight,
                FileType,
                Percentage,
                RulerOrWordCount,
            },
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

        local BuflineLeftSep = {
            condition = function(self)
                return self.is_active and buflist_cache[1] ~= self.bufnr
            end,
            provider = right_sep,
            hl = function(self)
                local c = { fg = "visual", bg = "func" }
                return self.is_active and c or "Visual"
            end,
        }

        local BuflineRightSep = {
            condition = function(self)
                return self.is_active or buflist_cache[self.active_id - 1] ~= self.bufnr
            end,
            provider = function(self)
                return self.is_active and right_sep or right_sep_thin
            end,
            hl = function(self)
                local c = { fg = "func", bg = "visual" }
                return self.is_active and c or "Visual"
            end,
        }

        local BuflineBlock = {
            init = function(self)
                local fname = vim.api.nvim_buf_get_name(self.bufnr)
                self.fname = fname == "" and "[No Name]" or vim.fn.fnamemodify(fname, ":t")

                self.active_id = 0
                local curr_buf = vim.api.nvim_get_current_buf()
                for i, v in ipairs(buflist_cache) do
                    if v == curr_buf then
                        self.active_id = i
                        return
                    end
                end
            end,
            hl = function(self)
                local c = { fg = "black", bg = "func" }
                return self.is_active and c or "Visual"
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
            { BuflineLeftSep, BuflineFileName, BuflineFileFlags, BuflineRightSep },
        }

        local BufferLine = utils.make_buflist(
            BuflineBlock,
            { provider = "", hl = "Visual" },
            { provider = " ", hl = "Visual" },
            function()
                return buflist_cache
            end,
            false
        )

        require("heirline").setup({
            statusline = StatusLine,
            tabline = BufferLine,
            opts = {
                colors = setup_colors,
            },
        })
    end,
}
