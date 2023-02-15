return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"jose-elias-alvarez/null-ls.nvim",
			{ "mfussenegger/nvim-jdtls", ft = { "java" } },
		},
	},

	{
		"ahmedkhalf/project.nvim",
		name = "project_nvim",
		opts = {
			manual_mode = false,
			detection_methods = { "lsp", "pattern" },
			show_hidden = false,
		},
	},

	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",
		},
	},

	{
		"lewis6991/gitsigns.nvim",
		dependencies = {
			{ "sindrets/diffview.nvim", cmd = "DiffviewOpen" },
		},
		config = true,
	},

	{
		"numToStr/Comment.nvim",
		config = true,
	},

	"tpope/vim-surround",

	{
		"lervag/vimtex",
		dependencies = {
			"xuhdev/vim-latex-live-preview",
		},
		ft = { "tex" },
	},
}
