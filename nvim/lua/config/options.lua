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
o.pumheight = 10
o.completeopt = { "menu", "menuone", "noselect" }
-- o.cmdheight = 0

local ol = vim.opt_local
local autocmd = vim.api.nvim_create_autocmd
local augroup = function(name)
    vim.api.nvim_create_augroup(name, { clear = true })
end

autocmd("Filetype", {
    group = augroup("TwoTabWidth"),
    pattern = { "c", "css", "cpp", "html", "ocaml", "javascript*", "typescript*", "coq" },
    callback = function()
        ol.shiftwidth = 2
        ol.tabstop = 2
        ol.softtabstop = 2
    end,
})

autocmd("TermOpen", {
    group = augroup("CleanTerminal"),
    pattern = "term://*",
    callback = function()
        ol.number = false
        ol.relativenumber = false
        ol.spell = false
        ol.buflisted = false
    end,
})

autocmd("Filetype", {
    group = augroup("DisableQuickfixFromBuflisted"),
    pattern = "qf",
    callback = function()
        ol.buflisted = false
    end,
})

autocmd("TextYankPost", {
    group = augroup("YankHighlight"),
    callback = function()
        vim.highlight.on_yank({ higroup = "IncSearch", timeout = "150" })
    end,
})

autocmd("Filetype", {
    group = augroup("EnableFolding"),
    pattern = { "cpp" },
    callback = function()
        ol.foldmethod = "marker"
    end,
})

autocmd("Filetype", {
    group = augroup("PlaintextFormats"),
    pattern = { "tex", "text", "markdown" },
    callback = function()
        vim.keymap.set({ "n", "v" }, "j", "gj", { silent = true, buffer = true })
        vim.keymap.set({ "n", "v" }, "k", "gk", { silent = true, buffer = true })
        ol.formatlistpat = [[^\s*\d\+[\]:.)}\t ]\s*]]
        ol.breakindentopt = "shift:0,list:-1"
        ol.spell = true
        ol.wrap = true
        ol.linebreak = true
        ol.breakindent = true
    end,
})

autocmd("FileType", {
    group = augroup("CommentstringAddSpace"),
    callback = function(event)
        local cs = vim.bo[event.buf].commentstring
        vim.bo[event.buf].commentstring = cs:gsub("(%S)%%s", "%1 %%s"):gsub("%%s(%S)", "%%s %1")
    end,
})

autocmd("BufEnter", {
    group = augroup("FiletypeUiua"),
    pattern = { "*.ua" },
    callback = function()
        ol.filetype = "uiua"
    end,
})
