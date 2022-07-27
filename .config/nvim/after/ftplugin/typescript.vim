setlocal shiftwidth=2
setlocal tabstop=2
setlocal softtabstop=2
nnoremap <buffer> <leader>r :w<CR>:vsp<CR>:term tsc %:p && node %:r.js<CR><C-\><C-n>
