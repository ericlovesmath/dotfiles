return {
    "lewis6991/impatient.nvim",

    {
        "dstein64/vim-startuptime",
        cmd = "StartupTime",
    },

    {
        "numToStr/Comment.nvim",
        config = true,
    },

    "tpope/vim-surround",

    {
        "ahmedkhalf/project.nvim",
        name = "project_nvim",
        opts = {
            manual_mode = false,
            detection_methods = { "lsp", "pattern" },
            show_hidden = false,
        },
    },

    {
        "lewis6991/gitsigns.nvim",
        dependencies = {
            { "sindrets/diffview.nvim", cmd = "DiffviewOpen" },
        },
        config = true,
    },
}
