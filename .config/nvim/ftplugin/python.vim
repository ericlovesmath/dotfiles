"let g:python3_host_prog = "/usr/local/anaconda3/bin/python3"
let g:python3_host_prog = "/usr/local/bin/python3"

nnoremap <leader>r :w<CR>:vsp<CR>:term python3 "%:p"<CR><C-\><C-n>

