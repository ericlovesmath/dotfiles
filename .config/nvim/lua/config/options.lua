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
o.spellsuggest = "5"
o.guitablabel = "%t"
o.pumheight = 10
-- o.cmdheight = 0
o.completeopt = {
    "menu",
    "menuone",
    "noselect",
}

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

augroup("TwoTabWidth", { clear = true })
for _, ft in pairs({ "c", "css", "html", "javascript", "typescript" }) do
    autocmd("Filetype", {
        group = "TwoTabWidth",
        pattern = ft,
        command = "setlocal shiftwidth=2 tabstop=2 softtabstop=2",
    })
end

augroup("CleanTerminal", { clear = true })
autocmd("TermOpen", {
    group = "CleanTerminal",
    pattern = "term://*",
    command = "setlocal nonumber norelativenumber nospell | setfiletype terminal",
})

augroup("YankHighlight", { clear = true })
autocmd("TextYankPost", {
    group = "YankHighlight",
    callback = function()
        vim.highlight.on_yank({ higroup = "IncSearch", timeout = "150" })
    end,
})

augroup("EnableFolding", { clear = true })
for _, ft in pairs({ "cpp" }) do
    autocmd("Filetype", {
        group = "EnableFolding",
        pattern = ft,
        command = "setlocal foldmethod=marker",
    })
end
