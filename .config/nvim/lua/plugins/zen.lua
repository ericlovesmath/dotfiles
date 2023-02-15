return {
	"folke/zen-mode.nvim",
	dependencies = {
		{ "folke/twilight.nvim", name = "twilight", config = true },
	},
	cmd = "ZenMode",
	opts = {
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
	},
}
