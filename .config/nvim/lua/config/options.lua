local o = vim.opt

vim.g.mapleader = " "
vim.g.maplocalleader = " "

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
o.spellsuggest = "5"
o.guitablabel = "%t"
o.pumheight = 10
o.completeopt = { "menu", "menuone", "noselect" }
-- o.cmdheight = 0

local ol = vim.opt_local
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

autocmd("Filetype", {
    group = augroup("TwoTabWidth", {}),
    pattern = { "c", "css", "html", "ocaml", "javascript*", "typescript*" },
    callback = function()
        ol.shiftwidth = 2
        ol.tabstop = 2
        ol.softtabstop = 2
    end,
})

autocmd("TermOpen", {
    group = augroup("CleanTerminal", {}),
    pattern = "term://*",
    callback = function()
        ol.number = false
        ol.relativenumber = false
        ol.spell = false
    end,
})

autocmd("TextYankPost", {
    group = augroup("YankHighlight", {}),
    callback = function()
        vim.highlight.on_yank({ higroup = "IncSearch", timeout = "150" })
    end,
})

autocmd("Filetype", {
    group = augroup("EnableFolding", {}),
    pattern = { "cpp" },
    callback = function()
        ol.foldmethod = "marker"
    end,
})

autocmd("Filetype", {
    group = augroup("PlaintextFormats", {}),
    pattern = { "tex", "text", "markdown" },
    callback = function()
        vim.keymap.set("n", "j", "gj", { silent = true, buffer = true })
        vim.keymap.set("n", "k", "gk", { silent = true, buffer = true })
        ol.formatlistpat = [[^\s*\d\+[\]:.)}\t ]\s*]]
        ol.breakindentopt = "shift:0,list:-1"
        ol.spell = true
        ol.wrap = true
        ol.linebreak = true
        ol.breakindent = true
    end,
})
