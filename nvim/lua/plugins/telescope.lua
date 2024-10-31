return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/popup.nvim",
        "nvim-lua/plenary.nvim",
    },
    cmd = "Telescope",
    init = function()
        vim.keymap.set("n", "<leader>fp", "<cmd>Telescope projects<CR>")
        vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>")
        vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<CR>")
        vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<CR>")
        vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<CR>")
    end,
    opts = {
        defaults = {
            vimgrep_arguments = {
                "rg",
                "--color=never",
                "--no-heading",
                "--with-filename",
                "--line-number",
                "--column",
                "--smart-case",
            },
            layout_config = {
                horizontal = {
                    preview_width = 0.5,
                    results_width = 0.8,
                },
                width = 0.87,
                height = 0.80,
                preview_cutoff = 50,
            },
            file_ignore_patterns = { "node_modules" },
        },
    },
}
