local set = vim.keymap.set
local silent = { silent = true }

-- Fast terminal
set("n", "<leader>t", ":vsp<CR>:term<CR>:startinsert<CR>", silent)

-- Using <C-hjkl> to navigate panes
set("n", "<C-h>", ":wincmd h<CR>")
set("n", "<C-j>", ":wincmd j<CR>")
set("n", "<C-k>", ":wincmd k<CR>")
set("n", "<C-l>", ":wincmd l<CR>")
set("t", "<C-h>", "<C-\\><C-n><C-w>h")
set("t", "<C-j>", "<C-\\><C-n><C-w>j")
set("t", "<C-k>", "<C-\\><C-n><C-w>k")
set("t", "<C-l>", "<C-\\><C-n><C-w>l")
set("t", "<Esc>", "<C-\\><C-n>")

-- Yank to clipboard
set("v", "<leader>y", '"+y')
set("n", "<leader>y", '"+y')
set("n", "<leader>Y", '"+y$')
set("n", "<leader>yy", '"+yy')

-- Increment and Decrement mapping
set({ "n", "v" }, "+", "<C-a>")
set({ "n", "v" }, "-", "<C-x>")
set("v", "g+", "g<C-a>")
set("v", "g-", "g<C-x>")

-- Reselecting when indenting multiple times
set("v", "<", "<gv")
set("v", ">", ">gv")

-- Center screen when moving fast
set("n", "n", "nzzzv")
set("n", "N", "Nzzzv")
set("n", "J", "mzJ`z")

-- Move Blocks of Code
set("v", "J", ":m '>+1<CR>gv=gv")
set("v", "K", ":m '<-2<CR>gv=gv")

-- Breaks undo chain on punctuation
set("i", ",", ",<C-g>u")
set("i", ".", ".<C-g>u")
set("i", "!", "!<C-g>u")
set("i", "?", "?<C-g>u")

-- Centers Scrolling
set("n", "<C-d>", "<C-d>zz")
set("n", "<C-u>", "<C-u>zz")

-- Quick buffer nav
set("n", "<leader><leader>", "<C-^>", silent)
set("n", "<Tab>", ":bn<CR>", silent)
set("n", "<S-Tab>", ":bp<CR>", silent)
for i = 1, 9 do
    set("n", "<leader>" .. i, ":buffer " .. i .. "<CR>", silent)
end
