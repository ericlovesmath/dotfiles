call plug#begin()

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
"Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

"Plug 'altercation/vim-colors-solarized'
"Plug 'junegunn/seoul256.vim'
"Plug 'phanviet/vim-monokai-pro'
"Plug 'lifepillar/vim-gruvbox8'
"Plug 'arcticicestudio/nord-vim'
Plug 'joshdick/onedark.vim'

Plug 'SirVer/ultisnips'
"| Plug 'honza/vim-snippets'

Plug 'lervag/vimtex', { 'for': 'tex' }
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }

Plug 'junegunn/goyo.vim'

Plug 'dstein64/vim-startuptime'

Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'
Plug 'kabouzeid/nvim-lspinstall'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'norcalli/nvim-colorizer.lua'

"Plug 'lukas-reineke/indent-blankline.nvim'

Plug 'kyazdani42/nvim-web-devicons'
Plug 'romgrk/barbar.nvim'
Plug 'kyazdani42/nvim-tree.lua'

"Plug 'jiangmiao/auto-pairs'

call plug#end()

