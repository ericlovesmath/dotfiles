vim.pack.add({ "https://www.github.com/norcalli/nvim-colorizer.lua" })

require("colorizer").setup({
    css = { css = true },
    "javascript",
    "typescript",
    "html",
})

local function lazy_colorscheme(pattern, repo, setup)
    vim.api.nvim_create_autocmd("ColorSchemePre", {
        pattern = pattern,
        once = true,
        callback = function()
            vim.pack.add({ "https://www.github.com/" .. repo })
            setup()
        end,
    })
end

lazy_colorscheme("onedark", "navarasu/onedark.nvim", function()
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
end)

lazy_colorscheme("catppuccin*", "catppuccin/nvim", function()
    require("catppuccin").setup({
        flavour = "frappe",
        transparent_background = true,
        integrations = {
            cmp = true,
            gitsigns = true,
            treesitter = true,
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
end)

lazy_colorscheme("gruvbox*", "sainnhe/gruvbox-material", function()
    vim.g.gruvbox_material_foreground = "material"
    vim.g.gruvbox_material_background = "medium"
    vim.g.gruvbox_material_better_performance = 1
    vim.g.gruvbox_material_transparent_background = 1
end)

lazy_colorscheme("sonokai", "sainnhe/sonokai", function() end)

vim.cmd.colorscheme("gruvbox-material")
