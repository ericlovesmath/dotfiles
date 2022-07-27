lua << EOF
local null_ls = require("null-ls")
local b = null_ls.builtins

local sources = {
    b.formatting.prettierd,
    b.formatting.shfmt,
    b.formatting.black.with { extra_args = { "--fast", "--line-length", "79" } },
    b.formatting.isort,
    b.formatting.stylua,
    -- b.formatting.black.with { extra_args = { "--line-length 80" } },

    -- diagnostics
    b.diagnostics.eslint_d,
    -- b.diagnostics.flake8,

    -- hover
    b.hover.dictionary,
}

null_ls.setup({ sources = sources })
EOF
