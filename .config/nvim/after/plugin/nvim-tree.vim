let g:nvim_tree_indent_markers = 1
let g:nvim_tree_highlight_opened_files = 1
let g:nvim_tree_show_icons = {'git': 0, 'folders': 1, 'files': 1, 'folder_arrows': 0}
let g:nvim_tree_respect_buf_cwd = 1

lua << EOF
require("nvim-tree").setup({
  update_cwd = true,
  update_focused_file = {
    enable = true,
    update_cwd = true
  },
})
EOF

nnoremap <leader>n :NvimTreeToggle<CR>
nnoremap <leader>m :NvimTreeRefresh<CR>:NvimTreeFindFile<CR>

" highlight NvimTreeFolderIcon guibg=blue 
au BufEnter,WinEnter NvimTree setlocal laststatus=0
au BufLeave,WinLeave NvimTree setlocal laststatus=2
