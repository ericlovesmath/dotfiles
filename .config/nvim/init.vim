"------------------------------------------------------------------------"-
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
set smartindent
set relativenumber
set number
set nowrap
set noswapfile
set undofile
set termguicolors
set nohlsearch
set noshowmode
set scrolloff=4
set signcolumn=yes:2
set updatetime=300
set splitright
set timeoutlen=1000 ttimeoutlen=0
set showtabline=0
set laststatus=2
set completeopt=menu,menuone,noselect

"--------------------------------------------------------------------------
" Key maps
"--------------------------------------------------------------------------

let mapleader = " "

nnoremap <leader>t :vsp<CR>:term<CR>:startinsert<CR>
nnoremap <leader>w :w<CR>

nnoremap <silent> <C-h> :wincmd h<CR>
nnoremap <silent> <C-j> :wincmd j<CR>
nnoremap <silent> <C-k> :wincmd k<CR>
nnoremap <silent> <C-l> :wincmd l<CR>

tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l

vnoremap <leader>y  "+y
nnoremap <leader>Y  "+y$
nnoremap <leader>y  "+y
nnoremap <leader>yy  "+yy

nnoremap + <C-a>
nnoremap - <C-x>

nnoremap H g^
nnoremap L g$

vnoremap < <gv
vnoremap > >gv

nnoremap n nzz
nnoremap N Nzz
nnoremap J mzJ`z

inoremap , ,<C-g>u
inoremap . .<C-g>u
inoremap ! !<C-g>u
inoremap ? ?<C-g>u

let s:comment_map = { 'c': '\/\/', 'cpp': '\/\/', 'go': '\/\/', 'java': '\/\/',
            \ 'javascript': '\/\/', 'rust': '\/\/', 'python': '#', 'ruby': '#',
            \ 'sh': '#', 'conf': '#', 'lua': '--', 'vim': "'", 'tex': '%'}

function! ToggleComment()
    if has_key(s:comment_map, &filetype)
        let comment_leader = s:comment_map[&filetype]
        if getline('.') =~ '\v^\s*' . comment_leader
            " Uncomment the line if it's a comment
            execute 'silent s/\v^(\s*)' . comment_leader . '(\s?)/\1'
        elseif getline('.') !~ '\v^\s*$'
            " Comment the line if not empty
            execute 'silent s/\v^(\s*)/\1' . comment_leader . ' '
        end
    else
        echo 'No comment leader found for filetype'
    end
endfunction

nnoremap <leader>/ :call ToggleComment()<cr>
vnoremap <leader>/ :call ToggleComment()<cr>

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

" Telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" LSP and Snippets
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-path'
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
Plug 'SirVer/ultisnips'
Plug 'quangnguyen30192/cmp-nvim-ultisnips' " | Plug 'honza/vim-snippets'

" Visual Enhancements
Plug 'nvim-treesitter/nvim-treesitter', { 'branch': '0.5-compat', 'do': ':TSUpdate' }
Plug 'norcalli/nvim-colorizer.lua'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'romgrk/barbar.nvim'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'lukas-reineke/indent-blankline.nvim'

" Misc / Specific Tools
Plug 'joshdick/onedark.vim'
Plug 'ahmedkhalf/project.nvim'
Plug 'dstein64/vim-startuptime'
Plug 'lervag/vimtex', { 'for': 'tex' }
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
Plug 'junegunn/goyo.vim'
"Plug 'github/copilot.vim'
"Plug 'tom-doerr/vim_codex'

call plug#end()

"--------------------------------------------------------------------------
" Native LSP + Ultisnips
"--------------------------------------------------------------------------

let g:UltiSnipsExpandTrigger = '<Plug>(ultisnips_expand)'
let g:UltiSnipsJumpForwardTrigger = '<Plug>(ultisnips_jump_forward)'
let g:UltiSnipsJumpBackwardTrigger = '<Plug>(ultisnips_jump_backward)'

highlight! link CmpItemAbbrDefault Pmenu
highlight! link CmpItemMenuDefault Pmenu

lua << EOF
local nvim_lsp = require('lspconfig')
local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    -- Mappings.
    local opts = { noremap = true, silent = true }
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
    buf_set_keymap('n', '<space>vf', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

require("nvim-lsp-installer").on_server_ready(
    function (server)
        server:setup{on_attach = on_attach}
    end
)

-- Setup nvim-cmp.
local cmp = require('cmp')
cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn["UltiSnips#Anon"](args.body)
        end,
    },
    mapping = {
        ["<Tab>"] = function(fallback)
            if cmp.visible() then
                cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
            elseif vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
                vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Plug>(ultisnips_jump_forward)", true, true, true), 'm', true)
            else
                fallback()
            end
        end,
        ["<S-Tab>"] = function(fallback)
            if cmp.visible() then
                cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
            elseif vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
                vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Plug>(ultisnips_jump_backward)", true, true, true), 'm', true)
            else
                fallback()
            end
        end,
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = {
        { name = 'ultisnips' },
        { name = 'nvim_lsp' },
        { name = 'path' },
    }
})
EOF

"--------------------------------------------------------------------------
" Statusline / Colors
"--------------------------------------------------------------------------

" Onedark Color Scheme
let g:onedark_termcolors=16
let g:onedark_terminal_italics=1
colorscheme onedark
" highlight Normal ctermbg=none guibg=none

" Status Line
let g:currentmode={"n": "NORMAL", "no": "NORMAL·OPERATOR PENDING", "v": "VISUAL",
    \ "V": "V·LINE", "\<C-V>": "V·BLOCK", "s": "SELECT", "S": "S·LINE", "^S": "S·BLOCK",
    \ "i": "INSERT", "R": "REPLACE", "Rv": "V·REPLACE", "c": "COMMAND", "cv": "VIM EX",
    \ "ce": "Ex", "r": "PROMPT", "rm": "MORE", "r?": "CONFIRM", "!": "SHELL", "t": "TERMINAL"}

function! LspReport() abort
	if luaeval('not vim.tbl_isempty(vim.lsp.buf_get_clients(0))')
	    let hints = luaeval("vim.lsp.diagnostic.get_count(0, [[Hint]])")
	    let warnings = luaeval("vim.lsp.diagnostic.get_count(0, [[Warning]])")
	    let errors = luaeval("vim.lsp.diagnostic.get_count(0, [[Error]])")
        return ' +'.hints.' ~'.warnings.' -'.errors
    else
        return ''
    endif
endfunction

function! WordCountOrRowCol()
    if &filetype != 'markdown'
        return '%3l:%2v'
    elseif has_key(wordcount(),'visual_words')
        return wordcount().visual_words.':'.wordcount().words
    else
        return wordcount().cursor_words.':'.wordcount().words
    endif
endfunction

set statusline=
set statusline+=%0*\ %{g:currentmode[mode()]}\         " The current mode
set statusline+=%1*\ %<%f%m%r%h%w\                     " File path, modified, readonly, helpfile, preview
set statusline+=%2*%{LspReport()}%=                    " LSP Information
set statusline+=\ %Y                                   " FileType
"set statusline+=\ \|\ %{&ff}\ \|                      " FileFormat (dos/unix..)
"set statusline+=\ %{''.(&fenc!=''?&fenc:&enc).''}     " Encoding
set statusline+=\ %1*\ %3p%%\                          " Percentage of document
set statusline+=%0*\ %{%WordCountOrRowCol()%}\         " WordCount for Markdown, Row/Col for else

" Status Bar Colors
hi statusline guifg=black guibg=#8fbfdc ctermfg=black ctermbg=cyan
hi User1 ctermfg=007 ctermbg=239 guibg=#4e4e4e guifg=#adadad
hi User2 ctermfg=007 ctermbg=236 guibg=#303030 guifg=#adadad
au InsertEnter * hi statusline guifg=black guibg=#d7afff ctermfg=black ctermbg=magenta
au InsertLeave * hi statusline guifg=black guibg=#8fbfdc ctermfg=black ctermbg=cyan

"--------------------------------------------------------------------------
" Miscellaneous
"--------------------------------------------------------------------------

au TermOpen term://* setlocal nonumber norelativenumber | setfiletype terminal
au TextYankPost * silent! lua vim.highlight.on_yank()

" Unity (Mono) Instructions:
" Edit omnisharp/run, 'mono_cmd=`command -v mono`'
