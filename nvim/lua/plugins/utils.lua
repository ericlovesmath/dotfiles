return {
    "tpope/vim-surround",
    {
        "junegunn/vim-easy-align",
        config = function()
            vim.keymap.set({ "n", "x" }, "ga", "<Plug>(EasyAlign)")
        end,
    },
    {
        "ahmedkhalf/project.nvim",
        event = { "BufReadPre", "BufNewFile" },
        name = "project_nvim",
        opts = {
            manual_mode = false,
            detection_methods = { "lsp" },
            -- detection_methods = { "lsp", "pattern" },
            show_hidden = false,
        },
    },
    {
        "Wansmer/treesj",
        keys = { "<space>m", "<space>j", "<space>s" },
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        config = function()
            require("treesj").setup()
        end,
    },

    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            { "sindrets/diffview.nvim", cmd = "DiffviewOpen" },
        },
        config = true,
    },

    {
        "jpalardy/vim-slime",
        event = "VeryLazy",
        config = function()
            vim.g.slime_target = "tmux"
            vim.g.slime_bracketed_paste = 1
            -- vim.g.slime_default_config = { socket_name = "default", target_pane = "{last}" }
            -- vim.g.slime_dont_ask_default = 1
        end,
    },
}
