local o = vim.opt

o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4
o.expandtab = true
o.number = true
o.relativenumber = true
o.ignorecase = true
o.smartcase = true
o.wrap = false
o.swapfile = false
o.undofile = true
o.termguicolors = true
o.hlsearch = false
o.showmode = false
o.scrolloff = 4
o.signcolumn = "yes:2"
o.updatetime = 50
o.splitright = true
o.laststatus = 3
o.lazyredraw = true
o.completeopt = {
	"menu",
	"menuone",
	"noselect",
}

o.guitablabel = "%t"
o.pumheight = 10
-- o.cmdheight = 0

vim.cmd([[
au TermOpen term://* setlocal nonumber norelativenumber | setfiletype terminal
au TextYankPost * silent! lua vim.highlight.on_yank()
]])
