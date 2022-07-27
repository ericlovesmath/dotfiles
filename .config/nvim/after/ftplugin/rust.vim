nnoremap <leader>r :w<CR>:vsp<CR>:term cargo run<CR><C-\><C-n>
nnoremap <leader>R :w<CR>:vsp<CR>:term cargo clippy<CR><C-\><C-n>
" au BufEnter,BufWinEnter,TabEnter *.rs :lua require'lsp_extensions'.inlay_hints{}
