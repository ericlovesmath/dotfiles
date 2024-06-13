return {
    "rebelot/heirline.nvim",
    event = "VimEnter",
    config = function()
        local utils = require("heirline.utils")

        local TablineFileName = {
            provider = function(self)
                return " " .. self.fname .. " "
            end,
            hl = function(self)
                return { bold = self.is_active or self.is_visible, italic = true }
            end,
        }

        local TablineFileFlags = {
            condition = function(self)
                return vim.api.nvim_get_option_value("modified", { buf = self.bufnr })
            end,
            provider = "• ",
        }

        local TablineBlock = {
            init = function(self)
                local fname = vim.api.nvim_buf_get_name(self.bufnr)
                self.fname = fname == "" and "[No Name]" or vim.fn.fnamemodify(fname, ":t")
            end,
            hl = function(self)
                return self.is_active and "TabLineSel" or "TabLine"
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
            { TablineFileName, TablineFileFlags },
        }

        local buflist_cache = {}

        vim.api.nvim_create_autocmd({ "UIEnter", "BufAdd", "BufDelete" }, {
            group = vim.api.nvim_create_augroup("HeirlineUpdateBufCache", { clear = true }),
            callback = function()
                vim.schedule(function()
                    buflist_cache = vim.tbl_filter(function(bufnr)
                        return vim.api.nvim_get_option_value("buflisted", { buf = bufnr })
                    end, vim.api.nvim_list_bufs())

                    if #buflist_cache > 1 then
                        vim.o.showtabline = 2
                    elseif vim.o.showtabline ~= 1 then
                        vim.o.showtabline = 1
                    end
                end)
            end,
        })

        local BufferLine = utils.make_buflist(
            TablineBlock,
            { provider = " ", hl = { fg = "gray" } },
            { provider = " ", hl = { fg = "gray" } },
            function()
                return buflist_cache
            end,
            false
        )

        require("heirline").setup({ tabline = BufferLine })
    end,
}
