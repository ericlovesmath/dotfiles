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
        end,
    },
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        cmd = { "LspInfo", "LspStart", "LspRestart" },
        dependencies = {
            "stevearc/conform.nvim",
            { "folke/lazydev.nvim", ft = "lua" },
        },
        config = function()
            require("lazydev").setup()

            -- Used to be used for html and cssls?
            -- local capabilities = require("cmp_nvim_lsp").default_capabilities()
            -- capabilities.textDocument.completion.completionItem.snippetSupport = true

            vim.diagnostic.config({ virtual_text = false })

            vim.lsp.config("rust_analyzer", {
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

            vim.lsp.config("zls", {
                settings = {
                    zls = {
                        enable_build_on_save = true,
                        build_on_save_step = "check",
                    },
                },
            })

            vim.lsp.enable({
                "bashls",
                "clangd",
                "pyright",
                "ts_ls",
                "gdscript",
                "glsl_analyzer",
                "hls",
                "ocamllsp",
                "lua_ls",
                "html",
                "cssls",
                "zls",
                "uiua",
            })

            local function switch_impl_intf()
                local bufnr = vim.api.nvim_get_current_buf()
                local uri = vim.uri_from_bufnr(bufnr)

                vim.lsp.buf_request(bufnr, "ocamllsp/switchImplIntf", { uri }, function(err, result)
                    if err then
                        vim.notify("Failed to switch implementation/interface: " .. err.message, vim.log.levels.ERROR)
                        return
                    end
                    local target_path = vim.uri_to_fname(result[1])
                    target_path = vim.fn.resolve(vim.fn.fnameescape(target_path))
                    vim.api.nvim_command("edit " .. target_path)
                end)
            end

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
                    set_local("<leader>vp", function()
                        vim.diagnostic.jump({ count = -1, float = true })
                    end)
                    set_local("<leader>vn", function()
                        vim.diagnostic.jump({ count = 1, float = true })
                    end)

                    -- Use Treesitter instead of LSP
                    local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "invalid client")

                    if client.name == "ocamllsp" then
                        set_local("<leader>vsi", switch_impl_intf)
                    end

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
                    javascript = { "prettierd", "eslint_d" },
                    typescript = { "prettierd", "eslint_d" },
                    javascriptreact = { "prettierd", "eslint_d" },
                    typescriptreact = { "prettierd", "eslint_d" },
                    json = { "jq" },
                    zig = { "zls" },
                },
            })
            vim.keymap.set("n", "<leader>vf", function()
                conform.format({ lsp_fallback = true })
            end)
        end,
    },
}
