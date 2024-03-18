return {
    "Julian/lean.nvim",
    event = { "BufReadPre *.lean", "BufNewFile *.lean" },

    dependencies = {
        "neovim/nvim-lspconfig",
        "nvim-lua/plenary.nvim",
    },
    -- see details below for full configuration options
    opts = {
        lsp = {
            on_attach = function(client, bufnr)
                -- Mappings
                local opts = { noremap = true, silent = true }
                local function buf_set_keymap(lhs, rhs)
                    vim.api.nvim_buf_set_keymap(bufnr, "n", lhs, rhs, opts)
                end

                buf_set_keymap("<leader>vd", "<cmd>lua vim.lsp.buf.definition()<CR>")
                buf_set_keymap("<leader>vh", "<cmd>lua vim.lsp.buf.hover()<CR>")
                buf_set_keymap("<leader>vi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
                buf_set_keymap("<leader>vsh", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
                buf_set_keymap("<leader>vrr", "<cmd>lua vim.lsp.buf.references()<CR>")
                buf_set_keymap("<leader>vrn", "<cmd>lua vim.lsp.buf.rename()<CR>")
                buf_set_keymap("<leader>vca", "<cmd>lua vim.lsp.buf.code_action()<CR>")
                buf_set_keymap("<leader>vsd", "<cmd>lua vim.diagnostic.open_float(nil, {})<CR>")
                buf_set_keymap("<leader>vp", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>")
                buf_set_keymap("<leader>vn", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>")
                buf_set_keymap(
                    "<leader>vf",
                    '<cmd>lua vim.lsp.buf.format{ filter = function(client) return client.name ~= "hls" end }<CR>'
                )
            end,
        },
        mappings = true,
    },
}
