let g:nvim_tree_indent_markers = 1
let g:nvim_tree_highlight_opened_files = 1
let g:nvim_tree_show_icons = {'git': 0, 'folders': 1, 'files': 1, 'folder_arrows': 0}

lua require'nvim-tree'.setup{}

nnoremap <leader>n :NvimTreeToggle<CR>
nnoremap <leader>m :NvimTreeFindFile<CR>
nnoremap <leader>m :NvimTreeRefresh<CR>

highlight NvimTreeFolderIcon guibg=blue 

au BufEnter NvimTree setlocal statusline=%0*\ %<%f
