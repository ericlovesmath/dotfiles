"nnoremap <leader>r :w<CR>:vsp<CR>:term python3 "%:p"<CR><C-\><C-n>
" set makeprg=g++\ -o\ %<\ %
" nnoremap <leader>r :make<cr>
nnoremap <leader>r :w<CR>:vsp<CR>:term cd %:p:h && g++ -std=c++17 %:p -o a.out -Wall -Wextra -Wshadow && ./a.out<CR><C-\><C-n>

" nnoremap     <leader>rm    :!g++ -g --std=c++11 % -o %:r<CR>
" nnoremap   <leader>rm    :set makeprg=g++<CR>:make % -o %:r<CR>
" nnoremap     <leader>rr    :!./%:r<CR>
" nnoremap     <leader>rt    :!for f in %:r.*.test; do echo "TEST: $f"; ./%:r < $f; done<CR>

set foldmethod=marker
setlocal shiftwidth=4
setlocal tabstop=4
setlocal softtabstop=4
