set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent

set exrc
set relativenumber
set nu

set nohlsearch "Prevent remaining highlights after search
set hidden
set noerrorbells
set nowrap "Disable text wrapping, debatable
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set autoindent
set termguicolors
set noshowmode

set incsearch
set scrolloff=4 "Early scroll

set colorcolumn=80
set signcolumn=yes
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
set clipboard=unnamedplus

call plug#begin('~/.vim/plugged')

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

"Plug 'altercation/vim-colors-solarized'
"Plug 'junegunn/seoul256.vim'
"Plug 'phanviet/vim-monokai-pro'
"Plug 'lifepillar/vim-gruvbox8'
Plug 'joshdick/onedark.vim'

"" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'


Plug 'SirVer/ultisnips'
"| Plug 'honza/vim-snippets'

Plug 'lervag/vimtex', { 'for': 'tex' }
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }

Plug 'junegunn/goyo.vim'

Plug 'dstein64/vim-startuptime'

Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

call plug#end()

highlight Normal guibg=none
"syntax on
let g:lightline = {'colorscheme': 'onedark'}
let g:onedark_termcolors=16

colorscheme onedark

let mapleader = " "
"nnoremap <leader>ps
"Project Search -> 

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Deoplete -----------------------------

let g:python3_host_prog = "/usr/local/anaconda3/bin/python3"

" Airline ------------------------------

let g:airline_powerline_fonts = 0
let g:airline_theme = 'bubblegum'
let g:airline#extensions#whitespace#enabled = 0

" Fancy Symbols!!
let fancy_symbols_enabled = 0
if fancy_symbols_enabled
    let g:webdevicons_enable = 1

    " custom airline symbols
    if !exists('g:airline_symbols')
       let g:airline_symbols = {}
    endif
    let g:airline_left_sep = ''
    let g:airline_left_alt_sep = ''
    let g:airline_right_sep = ''
    let g:airline_right_alt_sep = ''
    let g:airline_symbols.branch = '⭠'
    let g:airline_symbols.readonly = '⭤'
    let g:airline_symbols.linenr = '⭡'
else
    let g:webdevicons_enable = 0
endif

set autochdir

set splitright
autocmd TermOpen * startinsert
autocmd FileType python nnoremap <leader>r :w<CR>:vsp<bar>vertical resize 48<bar>term python3 %:p<CR>
autocmd FileType java nnoremap <leader>r :w<CR>:vsp<bar>vertical resize 48<bar>term javac %:p;echo "[Compiled]\n";java %:p<CR>
nnoremap <leader>t :vsp<bar>vertical resize 48<bar>lcd %:p:h<bar>term<CR>

" Ale


" Trigger configuration. You need to change this to something other than <tab> if you use one of the following:
" - https://github.com/Valloric/YouCompleteMe
" - https://github.com/nvim-lua/completion-nvim
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<S+tab>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

let g:UltiSnipsSnippetsDir = '/Users/ericlee/.vim/UltiSnips'
let g:UltiSnipsSnippetDirectories=["/Users/ericlee/.vim/UltiSnips", "UltiSnips"]

" LATEX

let g:tex_flavor='latex'
let g:vimtex_compiler_progname = 'nvr'
let g:vimtex_view_method='skim'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'

"setlocal spell
"set spelllang=en
"inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

"nnoremap <C-f> :exec '.!~/Desktop/bash/vim_inkscape.py %:r "'.getline(".").'"'
autocmd FileType tex nmap <buffer> <C-T> :!latexmk -pvc -pdf %<CR>

let g:vimtex_view_general_viewer = '/Applications/Skim.app/Contents/SharedSupport/displayline'
let g:vimtex_view_general_options = '-r @line @pdf @tex'
let g:vimtex_view_general_options_latexmk = '-r 1'

autocmd FileType tex nmap <leader>r :w<CR>

inoremap <C-f> <Esc>: silent exec "!inkscape-figures watch"<CR>: silent exec '.!inkscape-figures create "'.getline('.').'" "'.b:vimtex.root.'/figures/"'<CR><CR>
"nnoremap <C-f> : silent exec '!inkscape-figures edit "'.b:vimtex.root.'/figures/" > /dev/null 2>&1 &'<CR><CR>:redraw!<CR>

nnoremap <C-p> :call MarkdownClipboardImage()<CR>

function! MarkdownClipboardImage() abort
  " Create `img` directory if it doesn't exist
  let img_dir = getcwd() . '/imgs'
  if !isdirectory(img_dir)
    silent call mkdir(img_dir)
  endif

  " First find out what filename to use
  let index = 1
  let file_path = img_dir . "/image" . index . ".png"
  while filereadable(file_path)
    let index = index + 1
    let file_path = img_dir . "/image" . index . ".png"
  endwhile

  let clip_command = 'osascript'
  let clip_command .= ' -e "set png_data to the clipboard as «class PNGf»"'
  let clip_command .= ' -e "set referenceNumber to open for access POSIX path of'
  let clip_command .= ' (POSIX file \"' . file_path . '\") with write permission"'
  let clip_command .= ' -e "write png_data to referenceNumber"'

  silent call system(clip_command)
  if v:shell_error == 1
    normal! p
    echoerr "Error: Missing Image in Clipboard"
  else
    let caption = getline('.')
    execute "normal! ddi\\begin{figure}[ht]\r" . 
    \"\\centering\r" . 
    \"\\includegraphics[width=200px]{./imgs/image" . index . ".png}\r" . 
    \"\\caption{" . caption . "}\r" . 
    \"\\label{fig:LABEL}\r" .
    \"\\end{figure}"
    execute "normal! 3k4w:w"
  endif
endfunction

augroup vimtex_config
  au!
  autocmd User VimtexEventInitPost VimtexCompile
  set wrap
  au User VimtexEventQuit call vimtex#compiler#clean(1)
augroup END

set foldmethod=marker
set fmr=<<<,>>>
set fillchars=fold:\ 

let g:vimtex_quickfix_autojump = 1
let g:vimtex_quickfix_mode = 1
let g:vimtex_quickfix_warnings = {
	    \ 'Underfull' : 0,
	    \ 'Overfull' : 0,
	    \ 'specifier changed to' : 0,
	    \ }


lua require'lspconfig'.pyls.setup{on_attach=require'completion'.on_attach}
autocmd BufEnter * lua require'completion'.on_attach()

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c
let g:completion_enable_snippet = 'UltiSnips'

augroup FastEscape
    autocmd!
    au InsertEnter * set timeoutlen=0
    au InsertLeave * set timeoutlen=1000
augroup END

set timeoutlen=1000 ttimeoutlen=0

lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    custom_captures = {
      -- Highlight the @foo.bar capture group with the "Identifier" highlight group.
      ["foo.bar"] = "Identifier",
    },
  },
}
require'nvim-treesitter.configs'.setup {
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
}
require'nvim-treesitter.configs'.setup {
  indent = {
    enable = true
  }
}
EOF
