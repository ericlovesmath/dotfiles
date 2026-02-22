return {
    "saghen/blink.cmp",
    dependencies = {
        "L3MON4D3/LuaSnip",
        config = function()
            local luasnip = require("luasnip")

            luasnip.filetype_extend("markdown", { "tex" })

            luasnip.config.setup({
                history = true,
                enable_autosnippets = true,
                update_events = "TextChanged,TextChangedI",
                region_check_events = "InsertEnter",
                delete_check_events = "TextChanged,InsertLeave",
            })

            require("luasnip.loaders.from_lua").lazy_load()
        end,
    },
    version = "1.*",
    event = { "InsertEnter", "CmdlineEnter" },
    opts = {
        keymap = {
            preset = "super-tab",

            ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
            ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },

            ["<Right>"] = { "show_documentation", "hide_documentation", "fallback" },
            ["<Left>"] = { "hide_documentation", "fallback" },
        },

        sources = {
            default = { "lsp", "path", "snippets" },
        },
        completion = {
            menu = {
                draw = {
                    columns = {
                        { "label", "label_description", gap = 1 },
                        { "kind" },
                    },
                },
            },
        },
    },
}
