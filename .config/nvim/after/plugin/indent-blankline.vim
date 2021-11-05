lua << EOF
require("indent_blankline").setup {
    char = "▏",
    buftype_exclude = {"terminal"},
    filetype_exclude = {"help", "TelescopePrompt"}
}
EOF
