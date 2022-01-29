lua << EOF
require('telescope').setup{
    defaults = {
        vimgrep_arguments = {
              'rg',
              '--color=never',
              '--no-heading',
              '--with-filename',
              '--line-number',
              '--column',
              '--smart-case',
        },
        layout_config = {
             horizontal = {
                preview_width = 0.5,
                results_width = 0.8,
             },
             width = 0.87,
             height = 0.80,
             preview_cutoff = 50,
      },
          file_ignore_patterns = { "node_modules" },
    }
}
EOF

nnoremap <leader>fp <cmd>Telescope projects<cr>
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
