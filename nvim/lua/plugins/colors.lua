return {
    {
        "navarasu/onedark.nvim",
        priority = 1000,
        config = function()
            require("onedark").setup({
                style = "dark",
                ending_tildes = true,
                transparent = true,
                toggle_style_key = "<Nop>",
                toggle_style_list = { "warm", "cool", "dark" },
                diagnostics = {
                    darker = false,
                    background = false,
                },
            })
            -- require("onedark").load()
        end,
    },
    {
        "catppuccin/nvim",
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                flavour = "frappe",
                transparent_background = true,
                integrations = {
                    cmp = true,
                    gitsigns = true,
                    treesitter = true,
                    mason = true,
                },
                color_overrides = {
                    all = { text = "#bec6d4" },
                },
                custom_highlights = function(colors)
                    return {
                        SpellBad = { fg = colors.red }, -- spelling errors
                        SpellCap = { fg = colors.red }, -- capitalization errors
                        Conceal = { fg = colors.pink }, -- VimTeX conceal
                    }
                end,
            })
            -- vim.cmd.colorscheme("catppuccin")
        end,
    },
    {
        "sainnhe/gruvbox-material",
        priority = 1000,
        config = function()
            -- vim.g.gruvbox_material_foreground = "mix"
            vim.g.gruvbox_material_foreground = "material"
            vim.g.gruvbox_material_background = "medium"
            vim.g.gruvbox_material_better_performance = 1
            vim.g.gruvbox_material_transparent_background = 1
            vim.cmd.colorscheme("gruvbox-material")
        end,
    },
    "sainnhe/sonokai",
    {
        "norcalli/nvim-colorizer.lua",
        opts = {
            css = { css = true },
            "javascript",
            "typescript",
            "html",
        },
    },
}
