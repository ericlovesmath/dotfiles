vim.pack.add({
    -- Treesitter
    "https://www.github.com/nvim-treesitter/nvim-treesitter",
})

local ts = require("nvim-treesitter")

-- Install core parsers at startup
-- stylua: ignore
ts.install({
    "bash", "comment", "css", "diff", "git_config", "git_rebase", "gitcommit",
    "gitignore", "haskell", "html", "javascript", "json", "latex", "lua",
    "luadoc", "make", "markdown", "markdown_inline", "ocaml", "python", "scss", "svelte", "toml", "tsx",
    "typescript", "typst", "vim", "vimdoc", "vue", "xml",
})

local group = vim.api.nvim_create_augroup("TreesitterSetup", { clear = true })

local ignore_filetypes = {
    "checkhealth",
    "latex",
    "tex",
}

-- Auto-install parsers and enable highlighting on FileType
vim.api.nvim_create_autocmd("FileType", {
    group = group,
    desc = "Enable treesitter highlighting and indentation",
    callback = function(event)
        if vim.tbl_contains(ignore_filetypes, event.match) then
            vim.treesitter.stop(event.buf)
            return
        end

        local lang = vim.treesitter.language.get_lang(event.match) or event.match
        local buf = event.buf

        -- Start highlighting immediately (works if parser exists)
        local ok = pcall(vim.treesitter.start, buf, lang)

        if ok then
            -- Disable legacy regex syntax if Treesitter started successfully
            vim.bo[buf].syntax = "off"
            vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end

        -- Install missing parsers (async, no-op if already installed)
        -- ts.install({ lang })
    end,
})
-- Vim doesn't recognize WGSL as a filetype yet
vim.filetype.add({ extension = { wgsl = "wgsl" } })
