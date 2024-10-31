return {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        {
            "nvim-treesitter/nvim-treesitter-context",
            name = "treesitter-context",
            config = true,
            enabled = false,
        },
    },
    build = ":TSUpdate",
    config = function()
        -- Vim doesn't recognize WGSL as a filetype yet
        vim.filetype.add({ extension = { wgsl = "wgsl" } })

        require("nvim-treesitter.configs").setup({
            highlight = {
                enable = true,
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<CR>",
                    node_incremental = "<CR>",
                    scope_incremental = "<S-CR>",
                    node_decremental = "<BS>",
                },
            },
        })
    end,
}
