require("twilight").setup()

require("zen-mode").setup({
	backdrop = 1,
	window = {
		width = 0.70,
		height = 0.90,
		options = {
			number = false,
			relativenumber = false,
		},
	},
	plugins = {
		twilight = { enabled = false },
	},
})
