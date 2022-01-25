lua << EOF
require("project_nvim").setup{
  manual_mode = false,
  detection_methods = { "lsp" },
  -- detection_methods = { "lsp", "pattern" },
  show_hidden = true,
}
EOF
