vim.pack.add({ "https://www.github.com/folke/lazydev.nvim" })

require("lazydev").setup({
    integrations = { cmp = false },
})
