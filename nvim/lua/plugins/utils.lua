vim.pack.add({
    "https://www.github.com/tpope/vim-surround",
    "https://www.github.com/junegunn/vim-easy-align",
    "https://www.github.com/DrKJeff16/project.nvim",
    "https://www.github.com/Wansmer/treesj",
    "https://www.github.com/jpalardy/vim-slime",

    -- Gitsigns
    "https://www.github.com/lewis6991/gitsigns.nvim",
    "https://www.github.com/dlyongemallo/diffview.nvim",
    "https://www.github.com/nvim-tree/nvim-web-devicons",

    -- ZenMode
    "https://www.github.com/folke/zen-mode.nvim",
    "https://www.github.com/folke/twilight.nvim",

    -- Obsidian.nvim
    "https://www.github.com/obsidian-nvim/obsidian.nvim",
    "https://www.github.com/nvim-lua/plenary.nvim",
    "https://www.github.com/saghen/blink.cmp",
})

vim.keymap.set({ "n", "x" }, "ga", "<Plug>(EasyAlign)")

require("treesj").setup()
require("gitsigns").setup()

vim.g.slime_target = "tmux"
vim.g.slime_bracketed_paste = 1

require("zen-mode").setup({
    backdrop = 1,
    window = {
        width = 0.70,
        height = 0.90,
        options = {
            number = false,
            relativenumber = false,
        },
    },
    plugins = {
        twilight = { enabled = false },
    },
})

vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
    pattern = vim.fn.expand("~") .. "/Desktop/Obsidian/Eric/" .. "*.md",
    once = true,
    callback = function()
        require("obsidian").setup({
            workspaces = {
                {
                    name = "Eric",
                    path = "~/Desktop/Obsidian/Eric",
                },
            },
            completion = {
                blink = true,
            },
            legacy_commands = false,
            note_id_func = function(title)
                if title ~= nil then
                    return title:gsub(" ", "-"):gsub("[^%w%s-]", ""):lower()
                else
                    return tostring(os.time())
                end
            end,
        })

        vim.keymap.set("n", "gf", "<CMD>Obsidian follow_link<CR>", { noremap = true, silent = true })
    end,
})
