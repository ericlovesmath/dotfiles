let mapleader = " "
let g:python3_host_prog = "/usr/local/anaconda3/bin/python3"

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

