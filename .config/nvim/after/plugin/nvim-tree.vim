lua << EOF
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
EOF

nnoremap <leader>n :NvimTreeToggle<CR>
" nnoremap <leader>m :NvimTreeRefresh<CR>:NvimTreeFindFile<CR>

" au BufEnter,WinEnter NvimTree_1 setlocal laststatus=0
" au BufLeave,WinLeave NvimTree_1 setlocal laststatus=2
