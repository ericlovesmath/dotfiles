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
set number
set relativenumber
set ignorecase
set smartcase
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
set laststatus=3
set completeopt=menu,menuone,noselect
set guitablabel=%t
set pumheight=10
" set cmdheight=0

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

tnoremap <Esc> <C-\><C-n>

vnoremap <leader>y  "+y
nnoremap <leader>Y  "+y$
nnoremap <leader>y  "+y
nnoremap <leader>yy  "+yy

nnoremap + <C-a>
nnoremap - <C-x>

vnoremap < <gv
vnoremap > >gv

nnoremap n nzz
nnoremap N Nzz
nnoremap J mzJ`z

inoremap , ,<C-g>u
inoremap . .<C-g>u
inoremap ! !<C-g>u
inoremap ? ?<C-g>u

nnoremap <leader><leader> <C-^>
nnoremap <silent> <Tab> :bn<CR>
nnoremap <silent> <S-Tab> :bp<CR>

"--------------------------------------------------------------------------
" Plugins
"--------------------------------------------------------------------------

" Automatically install vim-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
    silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
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
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'SirVer/ultisnips'
Plug 'quangnguyen30192/cmp-nvim-ultisnips' " | Plug 'honza/vim-snippets'

" Visual Enhancements
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'norcalli/nvim-colorizer.lua'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'
" Plug 'lukas-reineke/indent-blankline.nvim'

" Colors
" Plug 'ful1e5/onedark.nvim'
Plug 'navarasu/onedark.nvim'
Plug 'gruvbox-community/gruvbox'
" Plug 'sainnhe/sonokai'

" Misc / Specific Tools
Plug 'tpope/vim-surround'
Plug 'ahmedkhalf/project.nvim'
Plug 'dstein64/vim-startuptime'
Plug 'lervag/vimtex', { 'for': ['tex', 'markdown'] }
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
Plug 'junegunn/goyo.vim'
Plug 'numToStr/Comment.nvim'
Plug 'romgrk/barbar.nvim'
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'
Plug 'theHamsta/nvim-dap-virtual-text'
Plug 'mattn/emmet-vim'
Plug 'jose-elias-alvarez/null-ls.nvim'
" Plug 'nvim-lua/lsp_extensions.nvim'
" Plug 'rmagatti/auto-session'

Plug 'lewis6991/gitsigns.nvim'
Plug 'sindrets/diffview.nvim'
" Plug 'habamax/vim-godot'
" Plug 'puremourning/vimspector'
" Plug 'github/copilot.vim'

" Plug 'vim-pandoc/vim-pandoc-syntax'

call plug#end()

"--------------------------------------------------------------------------
" Native LSP + Ultisnips
"--------------------------------------------------------------------------

lua << EOF
local nvim_lsp = require("lspconfig")
local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    -- Mappings.
    local opts = { noremap = true, silent = true }
    buf_set_keymap('n', '<leader>vd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', '<leader>vh', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', '<leader>vi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<leader>vsh', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', '<leader>vrr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', '<leader>vrn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<leader>vca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_set_keymap('n', '<leader>vsd', '<cmd>lua vim.diagnostic.open_float(nil, {})<CR>', opts)
    buf_set_keymap('n', '<leader>vp', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', '<leader>vn', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', '<space>vf', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
    -- 0.8.0 buf_set_keymap('n', '<space>vf', '<cmd>lua vim.lsp.buf.format{ async = true }<CR>', opts)
end

-- Required for html/cssls because Microsoft :/
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.completion.completionItem.snippetSupport = true

local function config(_config)
	return vim.tbl_deep_extend("force", {
		capabilities = capabilities,
		on_attach = on_attach
	}, _config or {})
end

-- Mason.nvim config
require("mason").setup()
require("mason-lspconfig").setup()
require("mason-lspconfig").setup_handlers {
    function(server_name)
        nvim_lsp[server_name].setup(config())
    end,
    ["jsonls"] = function() -- Example non-default behavior
        nvim_lsp.jsonls.setup(config())
    end,
}

-- LSPs not installed with mason.nvim
nvim_lsp.gdscript.setup(config()) 

-- Prepare for Ultisnips config
vim.g.UltiSnipsExpandTrigger = '<Plug>(ultisnips_expand)'
vim.g.UltiSnipsJumpForwardTrigger = '<Plug>(ultisnips_jump_forward)'
vim.g.UltiSnipsJumpBackwardTrigger = '<Plug>(ultisnips_jump_backward)'

-- Setup nvim-cmp.
local cmp = require('cmp')
cmp.setup({
    performance = {
      debounce = 150,
    },
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
        { name = 'nvim_lsp'},
        { name = 'path' },
        -- { name = 'nvim_lsp', max_item_count = 10, keyword_length = 3 },
    },
})
EOF

"--------------------------------------------------------------------------
" Statusline / Colors
"--------------------------------------------------------------------------

" Onedark Color Scheme
" hi Normal ctermfg=NONE ctermbg=NONE
let g:onedark_config = {
  \ 'style': 'dark', 
  \ 'ending_tildes': v:true,
  \ 'transparent': v:true,
  \ 'toggle_style_key': '<leader>ts',
  \ 'toggle_style_list': ['warm', 'cool', 'dark'],
  \ 'diagnostics': {
    \ 'darker': v:false,
    \ 'background': v:false,
  \ },
\ }
colorscheme onedark

" Gruvbox Color Scheme
" let g:gruvbox_sign_column='none'
" let g:gruvbox_color_column='none'
" let g:gruvbox_italic=1
" let g:gruvbox_termcolors=16
" colorscheme gruvbox

" hi SignColumn guibg=none
" hi CursorLineNR guibg=none
" hi Normal guibg=none
" hi TelescopeBorder guifg=#5eacd3

" Status Line
let g:currentmode={"n": "NORMAL", "no": "NORMAL·OPERATOR PENDING", "v": "VISUAL",
    \ "V": "V·LINE", "\<C-V>": "V·BLOCK", "s": "SELECT", "S": "S·LINE", "^S": "S·BLOCK",
    \ "i": "INSERT", "R": "REPLACE", "Rv": "V·REPLACE", "c": "COMMAND", "cv": "VIM EX",
    \ "ce": "Ex", "r": "PROMPT", "rm": "MORE", "r?": "CONFIRM", "!": "SHELL", "t": "TERMINAL"}

function! LspReport() abort
	if luaeval('not vim.tbl_isempty(vim.lsp.buf_get_clients(0))')
 	    let hints = luaeval("#vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })")
 	    let warnings = luaeval("#vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })")
 	    let errors = luaeval("#vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })")
        return '+' . hints . ' ~' . warnings . ' -' . errors
    else
        return ''
    endif
endfunction

function! WordCountOrRowCol() abort
    if &filetype != 'markdown'
        return '%3l:%2v'
    elseif has_key(wordcount(), 'visual_words')
        return wordcount().visual_words.':'.wordcount().words
    else
        return wordcount().cursor_words.':'.wordcount().words
    endif
endfunction

set statusline=
set statusline+=%0*\ %{g:currentmode[mode()]}\     " Current mode (Insert, Normal...)
set statusline+=%1*\ %<%t%m%r\                     " File name, modified, readonly
set statusline+=%2*\ %{LspReport()}%=\             " LSP Information
set statusline+=%Y\ \|\ %{&ff}\ \|\ %{&fenc}\    " File Type, File Format, Encoding
set statusline+=%1*\ %3p%%\                        " Percentage of document
set statusline+=%0*\ %{%WordCountOrRowCol()%}\     " Word Count for Markdown, Row/Col for all else

" Status Bar Colors
hi statusline guifg=black guibg=#8fbfdc ctermfg=black ctermbg=cyan
hi User1 guifg=#adadad guibg=#4e4e4e ctermfg=007 ctermbg=239 
hi User2 guifg=#adadad guibg=#303030 ctermfg=007 ctermbg=236 
au InsertEnter * hi statusline guifg=black guibg=#d7afff ctermfg=black ctermbg=magenta
au InsertLeave * hi statusline guifg=black guibg=#8fbfdc ctermfg=black ctermbg=cyan

"--------------------------------------------------------------------------
" Miscellaneous
"--------------------------------------------------------------------------

au TermOpen term://* setlocal nonumber norelativenumber | setfiletype terminal
au TextYankPost * silent! lua vim.highlight.on_yank()
