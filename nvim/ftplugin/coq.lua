vim.pack.add({ "https://www.github.com/whonore/Coqtail" })

vim.cmd([[
let g:coqtail_noimap = 1
nmap <buffer> <leader>cl <Plug>CoqToLine

imap <buffer> <S-Down> <Plug>CoqNext
imap <buffer> <S-Left> <Plug>CoqToLine
imap <buffer> <S-Up>  <Plug>CoqUndo

nmap <buffer> <S-Down> <Plug>CoqNext
nmap <buffer> <S-Left> <Plug>CoqToLine
nmap <buffer> <S-Up>  <Plug>CoqUndo
]])
