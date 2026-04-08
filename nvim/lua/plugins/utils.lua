return {
    "tpope/vim-surround",
    {
        "junegunn/vim-easy-align",
        config = function()
            vim.keymap.set({ "n", "x" }, "ga", "<Plug>(EasyAlign)")
        end,
    },
    {
        "DrKJeff16/project.nvim",
        event = { "BufReadPre", "BufNewFile" },
        name = "project_nvim",
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
            { "nvim-tree/nvim-web-devicons", opts = {} },
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
    {
        "obsidian-nvim/obsidian.nvim",
        version = "*",
        lazy = true,
        -- ft = "markdown",
        event = {
            "BufReadPre " .. vim.fn.expand("~") .. "/Desktop/Obsidian/Eric/*.md",
            "BufNewFile " .. vim.fn.expand("~") .. "/Desktop/Obsidian/Eric/*.md",
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "saghen/blink.cmp",
        },
        opts = {
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
        },
        config = function(_, opts)
            require("obsidian").setup(opts)
            vim.keymap.set("n", "gf", "<CMD>Obsidian follow_link<CR>", { noremap = true, silent = true })
        end,
    },
}
