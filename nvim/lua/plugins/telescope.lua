vim.pack.add({
    -- Telescope
    "https://www.github.com/nvim-telescope/telescope.nvim",
    "https://www.github.com/nvim-lua/popup.nvim",
    "https://www.github.com/nvim-lua/plenary.nvim",
})

vim.keymap.set("n", "<leader>fp", "<cmd>Telescope projects<CR>")
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>")
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<CR>")
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<CR>")
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<CR>")

require("telescope").setup({
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
})
