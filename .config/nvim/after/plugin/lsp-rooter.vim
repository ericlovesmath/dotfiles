
function LspRooterSetup()
lua << EOF
  require("lsp-rooter").setup {}
EOF
endfunction

augroup LspRooterSetup
    autocmd!
    autocmd User PlugLoaded call LspRooterSetup()
augroup END
