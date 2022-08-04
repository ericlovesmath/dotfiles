-- Install packer if not installed
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local is_bootstrap = false

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	is_bootstrap = true
	vim.fn.execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
	vim.cmd([[packadd packer.nvim]])
end

-- Packer installations
require("packer").startup(function(use)
	use("wbthomason/packer.nvim")

	use({
		"nvim-telescope/telescope.nvim",
		requires = {
			"nvim-lua/popup.nvim",
			"nvim-lua/plenary.nvim",
		},
	})

	use("neovim/nvim-lspconfig")

	use({
		"hrsh7th/nvim-cmp",
		requires = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
			"quangnguyen30192/cmp-nvim-ultisnips",
		},
	})

	use({
		"williamboman/mason.nvim",
		requires = {
			"williamboman/mason-lspconfig.nvim",
		},
	})

	use("SirVer/ultisnips")
	use("honza/vim-snippets")

	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	})

	use("norcalli/nvim-colorizer.lua")
	-- use("kyazdani42/nvim-tree.lua")
	-- use("kyazdani42/nvim-web-devicons")
	-- use 'lukas-reineke/indent-blankline.nvim'

	use("navarasu/onedark.nvim")
	use("gruvbox-community/gruvbox")
	-- use 'sainnhe/sonokai'

	use("tpope/vim-surround")
	use("ahmedkhalf/project.nvim")
	use("dstein64/vim-startuptime")

	use({
		"lervag/vimtex",
		ft = { "tex", "markdown" },
	})

	use({
		"xuhdev/vim-latex-live-preview",
		ft = { "tex" },
	})

	use("junegunn/goyo.vim")
	use("numToStr/Comment.nvim")

	use({
		"mfussenegger/nvim-dap",
		requires = {
			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",
		},
	})

	use("mattn/emmet-vim")
	use("jose-elias-alvarez/null-ls.nvim")
	-- use 'nvim-lua/lsp_extensions.nvim'
	-- use 'rmagatti/auto-session'

	use("lewis6991/gitsigns.nvim")
	use("sindrets/diffview.nvim")
	-- use 'habamax/vim-godot'
	-- use 'puremourning/vimspector'

	if is_bootstrap then
		require("packer").sync()
	end
end)
