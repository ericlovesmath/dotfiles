local nnoremap = require("keymap").nnoremap

require("nvim-tree").setup({
  update_cwd = true,
  respect_buf_cwd = true,
  update_focused_file = {
    enable = true,
    update_cwd = true
  },
  renderer = {
    highlight_opened_files = "all",
    indent_markers = {
      enable = true
    },
    icons = {
      show = {
        file = true,
        folder = true,
        folder_arrow = false,
        git = false,
      }
    }
  }
})

nnoremap("<leader>n", ":NvimTreeToggle<CR>")
-- nnoremap("<leader>m", ":NvimTreeRefresh<CR>:NvimTreeFindFile<CR>")
