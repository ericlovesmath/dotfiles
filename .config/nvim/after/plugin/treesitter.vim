lua << EOF

require'nvim-treesitter.configs'.setup {
    ensure_installed = "maintained",
    highlight = {
        enable = true,
    },
    indent = {
        enable = true,
        disable = {"python"}
    }
}

-- local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
-- parser_config.md = {
  -- install_info = {
    -- url = "https://github.com/MDeiml/tree-sitter-markdown",
    -- branch = "main",
    -- files = { "src/parser.c", "src/scanner.cc" }
  -- },
  -- maintainers = { "@MDeiml" },
-- }
EOF
