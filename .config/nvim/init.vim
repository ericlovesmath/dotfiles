let mapleader = " "
let g:python3_host_prog = "/usr/local/anaconda3/bin/python3"

runtime config.vim
runtime plugins.vim
runtime colors.vim
runtime lsp.vim

for f in split(glob('~/.config/nvim/plugin.d/*.vim'), '\n')
    exe 'source' f
endfor

autocmd TermOpen * startinsert
nnoremap <leader>t :vsp<CR>:term<CR>
