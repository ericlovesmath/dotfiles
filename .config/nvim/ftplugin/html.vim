if &ft=="markdown"
  finish
endif
setlocal shiftwidth=2
setlocal tabstop=2
setlocal softtabstop=2
nnoremap <buffer> <leader>r :w<CR>:exe ':silent !open -a /Applications/Firefox.app %'<CR>
