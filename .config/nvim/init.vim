"--------------------------------------------------------------------------
" Eric Lee's Neovim Configuration
" Email: ericlovesmath@gmail.com
" Github: https://github.com/ericlovesmath
"--------------------------------------------------------------------------

"--------------------------------------------------------------------------
" General settings
"--------------------------------------------------------------------------

set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set exrc
set relativenumber
set number
set hidden
set noerrorbells
set nowrap
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set autoindent
set termguicolors
set nohlsearch
set noshowmode
set incsearch
set scrolloff=4
set signcolumn=yes:2
set ruler
set wildmenu
set cmdheight=1
set updatetime=50
set shortmess+=c
set iskeyword+=-
set t_Co=256
set smarttab
set smartindent
set showtabline=2
set nobackup
set nowritebackup
set splitright
set timeoutlen=1000 ttimeoutlen=0
set showtabline=0
set laststatus=2

"--------------------------------------------------------------------------
" Key maps
"--------------------------------------------------------------------------

let mapleader = " "

nnoremap <leader>t :vsp<CR>:term<CR>
nnoremap <leader>w :w<CR>

" Navigate windows
nnoremap <silent> <C-h> :wincmd h<CR>
nnoremap <silent> <C-j> :wincmd j<CR>
nnoremap <silent> <C-k> :wincmd k<CR>
nnoremap <silent> <C-l> :wincmd l<CR>

tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l

" Copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y
nnoremap  <leader>yy  "+yy

" Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

nnoremap Y y$

" Center n,N,J movements
nnoremap n nzz
nnoremap N Nzz
nnoremap J mzJ`z

" Undo Breakpoints
inoremap , ,<C-g>u
inoremap . .<C-g>u
inoremap ! !<C-g>u
inoremap ? ?<C-g>u

nnoremap H g^
nnoremap L g$

nnoremap U <C-r>

" No arrow keys
map <Up>    <nop>
map <Down>  <nop>
map <Left>  <nop>
map <Right> <nop>

inoremap <Up>    <nop>
inoremap <Down>  <nop>
inoremap <Left>  <nop>
inoremap <Right> <nop>

" Increment and decrement mappings
nnoremap + <C-a>
nnoremap - <C-x>

" Reselect visual selection after indenting
vnoremap < <gv
vnoremap > >gv

"--------------------------------------------------------------------------
" Plugins
"--------------------------------------------------------------------------

" Automatically install vim-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin(data_dir . '/plugins')

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
"Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

Plug 'joshdick/onedark.vim'
"Plug 'altercation/vim-colors-solarized'
"Plug 'junegunn/seoul256.vim'
"Plug 'phanviet/vim-monokai-pro'
"Plug 'lifepillar/vim-gruvbox8'
"Plug 'arcticicestudio/nord-vim'

Plug 'SirVer/ultisnips'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'
"| Plug 'honza/vim-snippets'

Plug 'lervag/vimtex', { 'for': 'tex' }
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
Plug 'junegunn/goyo.vim'

Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'kabouzeid/nvim-lspinstall'

Plug 'nvim-treesitter/nvim-treesitter', { 'branch': '0.5-compat', 'do': ':TSUpdate' }
Plug 'norcalli/nvim-colorizer.lua'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'romgrk/barbar.nvim'
Plug 'kyazdani42/nvim-tree.lua'

Plug 'ahmedkhalf/lsp-rooter.nvim'
Plug 'dstein64/vim-startuptime'

Plug 'lukas-reineke/indent-blankline.nvim'

"Plug 'github/copilot.vim'
"Plug 'tom-doerr/vim_codex'

call plug#end()

"--------------------------------------------------------------------------
" Native LSP
"--------------------------------------------------------------------------

set completeopt=menu,menuone,noselect

lua <<EOF

-- Setup nvim-cmp.
local cmp = require('cmp')

cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn["UltiSnips#Anon"](args.body)
        end,
    },
    mapping = {
        ["<S-Tab>"] = cmp.mapping.select_prev_item(),
        ["<Tab>"] = cmp.mapping.select_next_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = {
        { name = 'ultisnips' },
        { name = 'nvim_lsp' },
--      { name = 'buffer', keyword_length = 5 },
    },
--  formatting = {
--      format = function(entry, vim_item)
--          vim_item.menu = 'menu'
--          vim_item.menu = ({
--              nvim_lsp = "[LSP]",
--              ultisnips = "[UltiSnips]",
--              buffer = "[Buffer]",
--          })[entry.source.name]
--          return vim_item
--      end
--  },
})

local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys 
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', '<leader>vd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', '<leader>vh', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<leader>vi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<leader>vsh', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>vrr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<leader>vrn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<leader>vca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '<leader>vsd', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '<leader>vp', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', '<leader>vn', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap("n", "<space>vf", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

end

require'lspinstall'.setup()

local servers = require'lspinstall'.installed_servers()
for _, server in pairs(servers) do
    require'lspconfig'[server].setup{
        on_attach = on_attach,
        capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
    }
end

EOF

highlight! link CmpItemAbbrDefault Pmenu
highlight! link CmpItemMenuDefault Pmenu

"--------------------------------------------------------------------------
" Statusline / Colors
"--------------------------------------------------------------------------

" Onedark Color Scheme
let g:onedark_termcolors=16
let g:onedark_terminal_italics=1
let g:onedark_hide_endofbuffer=1
colorscheme onedark

highlight Normal ctermbg=none guibg=none

" Status Line
let g:currentmode={
    \ 'n'  : 'Normal',
    \ 'no' : 'Normal·Operator Pending',
    \ 'v'  : 'Visual',
    \ 'V'  : 'V·Line',
    \ '^V' : 'V·Block',
    \ 's'  : 'Select',
    \ 'S'  : 'S·Line',
    \ '^S' : 'S·Block',
    \ 'i'  : 'Insert',
    \ 'R'  : 'Replace',
    \ 'Rv' : 'V·Replace',
    \ 'c'  : 'Command',
    \ 'cv' : 'Vim Ex',
    \ 'ce' : 'Ex',
    \ 'r'  : 'Prompt',
    \ 'rm' : 'More',
    \ 'r?' : 'Confirm',
    \ '!'  : 'Shell',
    \ 't'  : 'Terminal'
    \}

function! LspReport() abort
	if luaeval('not vim.tbl_isempty(vim.lsp.buf_get_clients(0))')
	    let hints = luaeval("vim.lsp.diagnostic.get_count(0, [[Hint]])")
	    let warnings = luaeval("vim.lsp.diagnostic.get_count(0, [[Warning]])")
	    let errors = luaeval("vim.lsp.diagnostic.get_count(0, [[Error]])")
        return ' +'.hints.' ~'.warnings.' -'.errors.' '
    else
        return ''
    endif
endfunction

set statusline=
set statusline+=%0*\ %{toupper(g:currentmode[mode()])}\   " The current mode
set statusline+=%1*\ %<%f%m%r%h%w\                        " File path, modified, readonly, helpfile, preview
set statusline+=%2*%{LspReport()}                         " LSP Information
set statusline+=%=                                        " Right Side
set statusline+=%2*\ %Y\                                  " FileType
set statusline+=\|                                        " Separator
set statusline+=\ %{&ff}\                                 " FileFormat (dos/unix..)
set statusline+=\|                                        " Separator
set statusline+=\ %{''.(&fenc!=''?&fenc:&enc).''}         " Encoding
set statusline+=\                                         " Separator
set statusline+=%1*\ %3p%%\                               " Percentage of document
set statusline+=%0*\ %3l:%2v\                             " Row/Col

" Status Bar Colors
au InsertEnter * hi statusline guifg=black guibg=#d7afff ctermfg=black ctermbg=magenta
au InsertLeave * hi statusline guifg=black guibg=#8fbfdc ctermfg=black ctermbg=cyan

hi statusline guifg=black guibg=#8fbfdc ctermfg=black ctermbg=cyan
hi User1 ctermfg=007 ctermbg=239 guibg=#4e4e4e guifg=#adadad
hi User2 ctermfg=007 ctermbg=236 guibg=#303030 guifg=#adadad
hi User3 ctermfg=236 ctermbg=236 guibg=#303030 guifg=#303030
hi User4 ctermfg=239 ctermbg=239 guibg=#4e4e4e guifg=#4e4e4e

au TermOpen term://* setlocal nonumber norelativenumber | setfiletype terminal

"augroup TerminalInsert
"    autocmd!
"    autocmd TermOpen * startinsert
"    autocmd BufWinEnter,WinEnter term://* startinsert
"augroup END

" Highlight on Yank
au TextYankPost * silent! lua vim.highlight.on_yank()


" Unity (Mono) Instructions:
" Edit omnisharp/run, 'mono_cmd=`command -v mono`'
