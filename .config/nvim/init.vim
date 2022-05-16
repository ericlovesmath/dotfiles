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
set laststatus=2
set completeopt=menu,menuone,noselect
set guitablabel=%t
set pumheight=10

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
" nnoremap <silent> <Tab> :w<CR>:bn<CR>
" nnoremap <silent> <S-Tab> :w<CR>:bp<CR>
nnoremap <silent> <Tab> :bn<CR>
nnoremap <silent> <S-Tab> :bp<CR>

let s:comment_map = { 'c': '\/\/', 'cpp': '\/\/', 'go': '\/\/', 'java': '\/\/',
            \ 'javascript': '\/\/', 'rust': '\/\/', 'python': '#', 'ruby': '#',
            \ 'sh': '#', 'conf': '#', 'lua': '--', 'vim': '"', 'tex': '%'}

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
vnoremap <leader>/ :call ToggleComment()<cr>gv

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
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'norcalli/nvim-colorizer.lua'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'
" Plug 'romgrk/barbar.nvim'
" Plug 'lukas-reineke/indent-blankline.nvim'

" Colors
" Plug 'ful1e5/onedark.nvim'
Plug 'navarasu/onedark.nvim'
Plug 'gruvbox-community/gruvbox'
" Plug 'sainnhe/sonokai'

" Misc / Specific Tools
Plug 'tpope/vim-surround'
Plug 'nvim-lua/lsp_extensions.nvim'
Plug 'ahmedkhalf/project.nvim'
Plug 'dstein64/vim-startuptime'
Plug 'lervag/vimtex', { 'for': ['tex', 'markdown'] }
" Plug 'lervag/vimtex'
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
Plug 'junegunn/goyo.vim'
Plug 'numToStr/Comment.nvim'
Plug 'romgrk/barbar.nvim'
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'
Plug 'theHamsta/nvim-dap-virtual-text'
" Plug 'puremourning/vimspector'
" Plug 'github/copilot.vim'

" Plug 'vim-pandoc/vim-pandoc-syntax'

call plug#end()

"--------------------------------------------------------------------------
" Native LSP + Ultisnips
"--------------------------------------------------------------------------

let g:UltiSnipsExpandTrigger = '<Plug>(ultisnips_expand)'
let g:UltiSnipsJumpForwardTrigger = '<Plug>(ultisnips_jump_forward)'
let g:UltiSnipsJumpBackwardTrigger = '<Plug>(ultisnips_jump_backward)'

highlight! link CmpItemAbbr Pmenu
highlight! link CmpItemKind Pmenu
highlight! link CmpItemMenu Pmenu

lua << EOF
local nvim_lsp = require('lspconfig')
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
end

-- Required for html/cssls because Microsoft :/
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true


-- DEPRECATED, REFACTOR
-- https://www.reddit.com/r/neovim/comments/ue61qj/psa_changes_to_nvimlspinstaller/
require("nvim-lsp-installer").on_server_ready(
    function (server)
        local opts = { on_attach = on_attach }
        if server.name == "cssls" then
            opts = vim.tbl_deep_extend("force", opts, {
                capabilities = capabilities,
            })
        end
        --[[ if server.name == "emmet_ls" then
            opts = vim.tbl_deep_extend("force", opts, {
                filetypes = { "html", "css", "typescriptreact", "javascriptreact" },
            })
        end ]]
        server:setup(opts)
    end
)

require'lspconfig'.gdscript.setup{
    on_attach = on_attach,
    capabilities = capabilities
}

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
        -- { name = 'nvim_lsp', max_item_count = 10 },
        { name = 'nvim_lsp'},
        { name = 'path' },
    },
    flags = {
      debounce_text_changes = 150,
    },
})
EOF


"--------------------------------------------------------------------------
" Statusline / Colors
"--------------------------------------------------------------------------

" Onedark Color Scheme
" hi Normal ctermfg=NONE ctermbg=NONE
" hi Normal ctermfg=NONE ctermbg=NONE
let g:onedark_config = {
  \ 'style': 'dark', 
  \ 'ending_tildes': v:true,
  \ 'transparent': v:false,
  \ 'toggle_style_key': '<leader>ts',
  \ 'toggle_style_list': ['warm', 'cool', 'dark'],
  \ 'diagnostics': {
    \ 'darker': v:false,
    \ 'background': v:false,
  \ },
\ }
colorscheme onedark

" Gruvbox Color Scheme
let g:gruvbox_sign_column='none'
let g:gruvbox_color_column='none'
let g:gruvbox_italic=1
let g:gruvbox_termcolors=16
" colorscheme gruvbox

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
" au BufEnter,BufWinEnter,TabEnter *.rs :lua require'lsp_extensions'.inlay_hints{}

" Unity (Mono) Instructions:
" Edit omnisharp/run, 'mono_cmd=`command -v mono`

function! Tabline() abort
    let l:line = ''
    let l:current = tabpagenr()
    for l:i in range(1, tabpagenr('$'))
        if l:i == l:current
            let l:line .= '%#TabLineSel#'
        else
            let l:line .= '%#TabLine#'
        endif
        let l:label = fnamemodify(
            \ bufname(tabpagebuflist(l:i)[tabpagewinnr(l:i) - 1]),
            \ ':t'
        \ )
        let l:line .= '%' . i . 'T' " Starts mouse click target region.
        let l:line .= '  ' . l:label . '  '
    endfor
    let l:line .= '%#TabLineFill#'
    let l:line .= '%T' " Ends mouse click target region(s).
    return l:line
endfunction

set tabline=%!Tabline()
