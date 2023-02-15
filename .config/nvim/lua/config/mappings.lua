local Remap = require("keymap")
local nnoremap = Remap.nnoremap
local inoremap = Remap.inoremap
local vnoremap = Remap.vnoremap
local tnoremap = Remap.tnoremap
local silent = { silent = true }

vim.g.mapleader = " "

--- Ultisnips
vim.g.UltiSnipsExpandTrigger = "<Plug>(ultisnips_expand)"
vim.g.UltiSnipsJumpForwardTrigger = "<Plug>(ultisnips_jump_forward)"
vim.g.UltiSnipsJumpBackwardTrigger = "<Plug>(ultisnips_jump_backward)"

-- Fast terminal and save
nnoremap("<leader>t", ":vsp<CR>:term<CR>:startinsert<CR>", silent)
nnoremap("<leader>w", ":w<CR>", silent)

-- Using <C-hjkl> to navigate panes
nnoremap("<C-h>", ":wincmd h<CR>")
nnoremap("<C-j>", ":wincmd j<CR>")
nnoremap("<C-k>", ":wincmd k<CR>")
nnoremap("<C-l>", ":wincmd l<CR>")
tnoremap("<C-h>", "<C-\\><C-n><C-w>h")
tnoremap("<C-j>", "<C-\\><C-n><C-w>j")
tnoremap("<C-k>", "<C-\\><C-n><C-w>k")
tnoremap("<C-l>", "<C-\\><C-n><C-w>l")
tnoremap("<Esc>", "<C-\\><C-n>")

-- Yank to clipboard
vnoremap("<leader>y", '"+y')
nnoremap("<leader>y", '"+y')
nnoremap("<leader>Y", '"+y$')
nnoremap("<leader>yy", '"+yy')

-- Increment and Decrement mapping
nnoremap("+", "<C-a>")
nnoremap("-", "<C-x>")
vnoremap("+", "<C-a>")
vnoremap("-", "<C-x>")
vnoremap("g+", "g<C-a>")
vnoremap("g-", "g<C-x>")

-- Reselecting when indenting multiple times
vnoremap("<", "<gv")
vnoremap(">", ">gv")

-- Center screen when moving fast
nnoremap("n", "nzzzv")
nnoremap("N", "Nzzzv")
nnoremap("J", "mzJ`z")

-- Move Blocks of Code
vnoremap("J", ":m '>+1<CR>gv=gv")
vnoremap("K", ":m '<-2<CR>gv=gv")

-- Breaks undo chain on punctuation
inoremap(",", ",<C-g>u")
inoremap(".", ".<C-g>u")
inoremap("!", "!<C-g>u")
inoremap("?", "?<C-g>u")

-- Centers Scrolling
nnoremap("<C-d>", "<C-d>zz")
nnoremap("<C-u>", "<C-u>zz")

-- Quick buffer nav
nnoremap("<leader><leader>", "<C-^>", silent)
nnoremap("<Tab>", ":bn<CR>", silent)
nnoremap("<S-Tab>", ":bp<CR>", silent)
