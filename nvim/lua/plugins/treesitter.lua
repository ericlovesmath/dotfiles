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
    branch = "main",
    build = ":TSUpdate",
    config = function()
        local ts = require("nvim-treesitter")

        -- Install core parsers at startup
        ts.install({
            "bash",
            "comment",
            "css",
            "diff",
            "git_config",
            "git_rebase",
            "gitcommit",
            "gitignore",
            "haskell",
            "html",
            "javascript",
            "json",
            "latex",
            "lua",
            "luadoc",
            "make",
            "ocaml",
            "python",
            "scss",
            "svelte",
            "toml",
            "tsx",
            "typescript",
            "typst",
            "vim",
            "vimdoc",
            "vue",
            "xml",
        })

        local group = vim.api.nvim_create_augroup("TreesitterSetup", { clear = true })

        local ignore_filetypes = {
            "checkhealth",
            "lazy",
            "latex",
            "tex",
            "markdown",
        }

        -- Auto-install parsers and enable highlighting on FileType
        vim.api.nvim_create_autocmd("FileType", {
            group = group,
            desc = "Enable treesitter highlighting and indentation",
            callback = function(event)
                if vim.tbl_contains(ignore_filetypes, event.match) then
                    return
                end

                local lang = vim.treesitter.language.get_lang(event.match) or event.match
                local buf = event.buf

                -- Start highlighting immediately (works if parser exists)
                pcall(vim.treesitter.start, buf, lang)

                -- Enable treesitter indentation
                vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

                -- Install missing parsers (async, no-op if already installed)
                ts.install({ lang })
            end,
        })
        -- Vim doesn't recognize WGSL as a filetype yet
        vim.filetype.add({ extension = { wgsl = "wgsl" } })
    end,
}
