let mapleader = " "
let g:python3_host_prog = "/usr/local/anaconda3/bin/python3"
"let g:python3_host_prog = "/usr/local/bin/python3"

runtime config.vim
runtime plugins.vim
runtime colors.vim
runtime lsp.vim
runtime statusline.vim

augroup TermShortcut
    autocmd!
    autocmd TermOpen * startinsert
augroup END

nnoremap <leader>t :vsp<CR>:term<CR>

nnoremap <silent> <c-k> :wincmd k<CR>
nnoremap <silent> <c-j> :wincmd j<CR>
nnoremap <silent> <c-h> :wincmd h<CR>
nnoremap <silent> <c-l> :wincmd l<CR>

"nnoremap <silent> <Tab> :bnext<CR>
"nnoremap <silent> <S-Tab> :bprevious<CR>
