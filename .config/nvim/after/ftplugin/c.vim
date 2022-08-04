nnoremap <leader>r :w<CR>:vsp<CR>:term cd %:p:h && gcc %:p -o %:t:r.out && ./%:t:r.out<CR><C-\><C-n>
" nnoremap <leader>r :w<CR>:vsp<CR>:term cd %:p:h && gcc -g %:p -o %:t:r.out && ./%:t:r.out<CR><C-\><C-n>
setlocal shiftwidth=2
setlocal tabstop=2
setlocal softtabstop=2
