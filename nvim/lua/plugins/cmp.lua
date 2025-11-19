return {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-path",
        "SirVer/ultisnips",
        "quangnguyen30192/cmp-nvim-ultisnips",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
    },
    config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")

        cmp.setup({
            snippet = {
                expand = function(args)
                    vim.fn["UltiSnips#Anon"](args.body)
                    luasnip.lsp_expand(args.body)
                end,
            },
            mapping = {
                ["<Tab>"] = function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
                    elseif vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
                        vim.api.nvim_feedkeys(
                            vim.api.nvim_replace_termcodes("<Plug>(ultisnips_jump_forward)", true, true, true),
                            "m",
                            true
                        )
                    elseif luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    else
                        fallback()
                    end
                end,
                ["<S-Tab>"] = function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
                    elseif vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
                        vim.api.nvim_feedkeys(
                            vim.api.nvim_replace_termcodes("<Plug>(ultisnips_jump_backward)", true, true, true),
                            "m",
                            true
                        )
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end,
                ["<C-d>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.close(),
                ["<CR>"] = cmp.mapping.confirm({ select = false }),
            },
            sources = {
                { name = "ultisnips" },
                { name = "luasnip" },
                { name = "nvim_lsp" },
                { name = "path" },
            },
        })

        luasnip.config.setup({
            history = true,
            enable_autosnippets = true,
            update_events = "TextChanged,TextChangedI",
        })

        require("luasnip.loaders.from_lua").lazy_load()
    end,
}
