call plug#begin()

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

"Plug 'altercation/vim-colors-solarized'
"Plug 'junegunn/seoul256.vim'
"Plug 'phanviet/vim-monokai-pro'
"Plug 'lifepillar/vim-gruvbox8'
Plug 'joshdick/onedark.vim'
"Plug 'rakr/vim-one'
"Plug 'arcticicestudio/nord-vim'

Plug 'SirVer/ultisnips'
"| Plug 'honza/vim-snippets'

"Plug 'lervag/vimtex', { 'for': 'tex' }
"Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }

Plug 'junegunn/goyo.vim'

Plug 'dstein64/vim-startuptime'

Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'nvim-lua/lsp-status.nvim'

"Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

"Plug 'norcalli/nvim-colorizer.lua'

call plug#end()

for f in split(glob('~/.config/nvim/plugin.d/*.vim'), '\n')
    exe 'source' f
endfor

"lua require'colorizer'.setup()
