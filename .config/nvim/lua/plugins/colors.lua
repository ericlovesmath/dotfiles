local function onedark_config()
	require("onedark").setup({
		style = "dark",
		ending_tildes = true,
		transparent = false,
		toggle_style_key = "<Nop>",
		toggle_style_list = { "warm", "cool", "dark" },
		diagnostics = {
			darker = false,
			background = false,
		},
	})

	require("onedark").load()
end

return {
	{
		"navarasu/onedark.nvim",
		priority = 1000,
		config = onedark_config,
	},
	{
		"gruvbox-community/gruvbox",
		init = function()
			vim.g.gruvbox_sign_column = "none"
			vim.g.gruvbox_color_column = "none"
			vim.g.gruvbox_italic = 1
			vim.g.gruvbox_termcolos = 16
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
