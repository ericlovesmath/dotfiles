return {
    {
        "numToStr/Comment.nvim",
        config = true,
    },

    "tpope/vim-surround",

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
