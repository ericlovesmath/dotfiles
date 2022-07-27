vim.cmd([[
let mapleader = " "

nnoremap <leader>t :vsp<CR>:term<CR>:startinsert<CR>
nnoremap <leader>w :w<CR>

nnoremap <silent> <C-h> :wincmd h<CR>
nnoremap <silent> <C-j> :wincmd j<CR>
nnoremap <silent> <C-k> :wincmd k<CR>
nnoremap <silent> <C-l> :wincmd l<CR>

tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l

tnoremap <Esc> <C-\><C-n>

vnoremap <leader>y  "+y
nnoremap <leader>Y  "+y$
nnoremap <leader>y  "+y
nnoremap <leader>yy  "+yy

nnoremap + <C-a>
nnoremap - <C-x>

vnoremap < <gv
vnoremap > >gv

nnoremap n nzz
nnoremap N Nzz
nnoremap J mzJ`z

inoremap , ,<C-g>u
inoremap . .<C-g>u
inoremap ! !<C-g>u
inoremap ? ?<C-g>u

nnoremap <leader><leader> <C-^>
nnoremap <silent> <Tab> :bn<CR>
nnoremap <silent> <S-Tab> :bp<CR>
]])
