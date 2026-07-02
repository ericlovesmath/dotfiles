vim.cmd([==[
runtime ftplugin/tex.lua

syntax match UrlNoSpell '\w\+:\/\/[^[:space:]]\+' contains=@NoSpell

nnoremap <silent> ]] /^#<CR>
nnoremap <silent> [[ ?^#<CR>
nnoremap gO :lvimgrep /^#/ %<CR>:lopen<CR>

function! GlowPreview() abort

    let file_name = expand('%:p')

    " Define the size of the floating window
    let width = nvim_get_option("columns")
    let height = nvim_get_option("lines")

    let win_width = float2nr(ceil(width * 0.8))
    let win_height = float2nr(ceil(height * 0.8 - 4))

    " Starting Position
    let row = (height - win_height) / 2 - 1
    let col = (width - win_width) / 2

    " Create the scratch buffer displayed in the floating window
    let buf = nvim_create_buf(v:false, v:true)
    let opts = {'relative': 'editor',
                \ 'width': win_width,
                \ 'height': win_height,
                \ 'row': row,
                \ 'col': col,
                \ 'anchor': 'NW',
                \ 'style': 'minimal',
                \ }

    let win = nvim_open_win(buf, 1, opts)
    call nvim_buf_set_option(buf, "bufhidden", "wipe")
    call nvim_win_set_option(win, "winblend", 0)
    call termopen("glow " . file_name)

endfunction

nnoremap <leader>p :call GlowPreview()<CR>

function! ToggleCheckbox()
  let line = getline('.')

  if line =~ '- \[ \]'
    call setline('.', substitute(line, '- \[ \]', '- \[x\]', ''))
  elseif line =~ '- \[x\]'
    call setline('.', substitute(line, '- \[x\]', '- \[ \]', ''))
  elseif line =~ '- '
    call setline('.', substitute(line, '- ', '- \[ \] ', ''))
  endif
endf

nnoremap <Leader>c :call ToggleCheckbox()<CR>
]==])

-- vim.treesitter.start() disables the Vim syntax engine (sets vim.bo.syntax = "").
-- Re-enable it after treesitter has started so VimTeX math conceal groups are active.
-- Capture buf now; by the time vim.schedule fires the current buffer may have changed.
local buf = vim.api.nvim_get_current_buf()
vim.schedule(function()
    if not vim.api.nvim_buf_is_valid(buf) then return end
    vim.bo[buf].syntax = "markdown"
    vim.api.nvim_buf_call(buf, function()
        vim.cmd("call vimtex#init()")
    end)
    vim.wo.conceallevel = 2
end)
