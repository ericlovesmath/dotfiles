nnoremap <leader>t :vsp<CR>:term<CR>

nnoremap <silent> <c-k> :wincmd k<CR>
nnoremap <silent> <c-j> :wincmd j<CR>
nnoremap <silent> <c-h> :wincmd h<CR>
nnoremap <silent> <c-l> :wincmd l<CR>

tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l

augroup TerminalInsert
    autocmd!
    autocmd TermOpen * startinsert
    autocmd BufWinEnter,WinEnter term://* startinsert
augroup END

au TextYankPost * silent! lua vim.highlight.on_yank()

" " Copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y
nnoremap  <leader>yy  "+yy

" " Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

nnoremap Y  y$

" Center n,N,J movements
nnoremap n nzz
nnoremap N Nzz
nnoremap J mzJ`z

" Undo Breakpoints
inoremap , ,<C-g>u
inoremap . .<C-g>u
inoremap ! !<C-g>u
inoremap ? ?<C-g>u

nnoremap H ^
nnoremap L $

nnoremap U <C-r>

map <Up>    <nop>
map <Down>  <nop>
map <Left>  <nop>
map <Right> <nop>

inoremap <Up>    <nop>
inoremap <Down>  <nop>
inoremap <Left>  <nop>
inoremap <Right> <nop>

"-----------------------------
" Increment and decrement mappings
"-----------------------------
nnoremap + <C-a>
nnoremap - <C-x>
