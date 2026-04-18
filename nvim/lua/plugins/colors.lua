vim.pack.add({
    -- Colorschemes
    "https://www.github.com/navarasu/onedark.nvim",
    "https://www.github.com/catppuccin/nvim",
    "https://www.github.com/sainnhe/gruvbox-material",
    "https://www.github.com/sainnhe/sonokai",

    -- Colorizer
    "https://www.github.com/norcalli/nvim-colorizer.lua",
})

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

vim.g.gruvbox_material_foreground = "material"
vim.g.gruvbox_material_background = "medium"
vim.g.gruvbox_material_better_performance = 1
vim.g.gruvbox_material_transparent_background = 1

require("colorizer").setup({
    css = { css = true },
    "javascript",
    "typescript",
    "html",
})

vim.cmd.colorscheme("gruvbox-material")
