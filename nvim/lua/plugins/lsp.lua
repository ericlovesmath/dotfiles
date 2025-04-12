return {
    {
        "mfussenegger/nvim-jdtls",
        ft = { "java" },
    },
    {
        "Julian/lean.nvim",
        event = { "BufReadPre *.lean", "BufNewFile *.lean" },
        dependencies = {
            "neovim/nvim-lspconfig",
            "nvim-lua/plenary.nvim",
        },
        config = true,
    },
    {
        "whonore/Coqtail",
        ft = { "coq" },
        config = function()
            vim.cmd([[
            let g:coqtail_noimap = 1
            nmap <buffer> <leader>cl <Plug>CoqToLine

            imap <buffer> <S-Down> <Plug>CoqNext
            imap <buffer> <S-Left> <Plug>CoqToLine
            imap <buffer> <S-Up>  <Plug>CoqUndo

            nmap <buffer> <S-Down> <Plug>CoqNext
            nmap <buffer> <S-Left> <Plug>CoqToLine
            nmap <buffer> <S-Up>  <Plug>CoqUndo
            ]])
        end
    },
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        cmd = { "LspInfo", "LspStart", "LspRestart", "Mason" },
        dependencies = {
            { "folke/lazydev.nvim", ft = "lua" },
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "stevearc/conform.nvim",
        },
        config = function()
            require("lazydev").setup()

            local nvim_lsp = require("lspconfig")

            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            capabilities.textDocument.completion.completionItem.snippetSupport = true

            -- vim.diagnostic.config({ virtual_text = false })

            -- Mason.nvim config
            require("mason").setup()
            require("mason-lspconfig").setup()
            require("mason-lspconfig").setup_handlers({
                function(server_name)
                    nvim_lsp[server_name].setup({})
                end,
                ["html"] = function()
                    nvim_lsp.html.setup({ capabilities = capabilities })
                end,
                ["cssls"] = function()
                    nvim_lsp.cssls.setup({ capabilities = capabilities })
                end,
                ["rust_analyzer"] = function()
                    nvim_lsp.rust_analyzer.setup({
                        settings = {
                            ["rust-analyzer"] = {
                                check = {
                                    overrideCommand = {
                                        "cargo",
                                        "clippy",
                                        "--all-features",
                                        "--all-targets",
                                        "--workspace",
                                        "--message-format=json",
                                        -- "--target=wasm32-unknown-unknown",
                                    },
                                },
                            },
                        },
                    })
                end,
                ["ts_ls"] = function()
                    nvim_lsp.ts_ls.setup({
                        settings = {
                            typescript = { format = { semicolons = "insert" } },
                            javascript = { format = { semicolons = "insert" } },
                        },
                    })
                end,
                ["jdtls"] = function() end, -- Use nvim-jdtls instead
            })

            -- LSPs not installed with mason.nvim
            nvim_lsp.coq_lsp.setup({})
            nvim_lsp.gdscript.setup({})
            nvim_lsp.hls.setup({})
            nvim_lsp.ocamllsp.setup({})
            nvim_lsp.roc_ls.setup({})

            -- Create Keybinds for LSP
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("LspKeybinds", {}),
                callback = function(args)
                    local function set_local(lhs, rhs)
                        vim.keymap.set("n", lhs, rhs, { silent = true, buffer = 0 })
                    end

                    set_local("<leader>vd", vim.lsp.buf.definition)
                    set_local("<leader>vh", vim.lsp.buf.hover)
                    set_local("<leader>vi", vim.lsp.buf.implementation)
                    set_local("<leader>vsh", vim.lsp.buf.signature_help)
                    set_local("<leader>vrr", vim.lsp.buf.references)
                    set_local("<leader>vrn", vim.lsp.buf.rename)
                    set_local("<leader>vca", vim.lsp.buf.code_action)
                    set_local("<leader>vsd", vim.diagnostic.open_float)
                    set_local("<leader>vp", vim.diagnostic.goto_prev)
                    set_local("<leader>vn", vim.diagnostic.goto_next)

                    -- Use Treesitter instead of LSP
                    local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "invalid client")
                    client.server_capabilities.semanticTokensProvider = nil
                end,
            })

            -- Use Semantic Tokens AFTER Treesitter (see above to disable semantic tokens)
            -- vim.highlight.priorities.semantic_tokens = 95

            -- Formatters and Linters with conform.nvim, replacing LSP
            local conform = require("conform")
            conform.setup({
                formatters_by_ft = {
                    asm = { "asmfmt" },
                    bash = { "shfmt" },
                    lua = { "stylua" },
                    ocaml = { "ocamlformat" },
                    haskell = { "fourmolu" },
                    python = { "isort", "flake8", "black" },
                    cpp = { "clang-format" },
                    javascript = { "prettierd",  "eslint_d" },
                    typescript = { "prettierd",  "eslint_d" },
                    javascriptreact = { "prettierd", "eslint_d" },
                    typescriptreact = { "prettierd", "eslint_d" },
                },
            })
            vim.keymap.set("n", "<leader>vf", function()
                conform.format({ lsp_fallback = true })
            end)
        end,
    },
}
