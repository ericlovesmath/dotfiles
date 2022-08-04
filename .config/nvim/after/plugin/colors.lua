local onedark = require("onedark")

onedark.setup({
	style = "dark",
	ending_tildes = true,
	transparent = false,
	toggle_style_key = "<Nop>",
	toggle_style_list = { "warm", "cool", "dark" },
    diagnostics = {
        darker = false,
        background = false,
    }
})

onedark.load()

vim.cmd([[
" Onedark Color Scheme
" hi Normal ctermfg=NONE ctermbg=NONE

" Gruvbox Color Scheme
" let g:gruvbox_sign_column='none'
" let g:gruvbox_color_column='none'
" let g:gruvbox_italic=1
" let g:gruvbox_termcolors=16
" colorscheme gruvbox

" hi SignColumn guibg=none
" hi CursorLineNR guibg=none
" hi Normal guibg=none
" hi TelescopeBorder guifg=#5eacd3

" Status Line
let g:currentmode={"n": "NORMAL", "no": "NORMAL·OPERATOR PENDING", "v": "VISUAL",
    \ "V": "V·LINE", "\<C-V>": "V·BLOCK", "s": "SELECT", "S": "S·LINE", "^S": "S·BLOCK",
    \ "i": "INSERT", "R": "REPLACE", "Rv": "V·REPLACE", "c": "COMMAND", "cv": "VIM EX",
    \ "ce": "Ex", "r": "PROMPT", "rm": "MORE", "r?": "CONFIRM", "!": "SHELL", "t": "TERMINAL"}

function! LspReport() abort
	if luaeval('not vim.tbl_isempty(vim.lsp.buf_get_clients(0))')
 	    let hints = luaeval("#vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })")
 	    let warnings = luaeval("#vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })")
 	    let errors = luaeval("#vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })")
        return '+' . hints . ' ~' . warnings . ' -' . errors
    else
        return ''
    endif
endfunction

function! WordCountOrRowCol() abort
    if &filetype != 'markdown'
        return '%3l:%2v'
    elseif has_key(wordcount(), 'visual_words')
        return wordcount().visual_words.':'.wordcount().words
    else
        return wordcount().cursor_words.':'.wordcount().words
    endif
endfunction

set statusline=
set statusline+=%0*\ %{g:currentmode[mode()]}\     " Current mode (Insert, Normal...)
set statusline+=%1*\ %<%t%m%r\                     " File name, modified, readonly
set statusline+=%2*\ %{LspReport()}%=\             " LSP Information
set statusline+=%Y\ \|\ %{&ff}\ \|\ %{&fenc}\    " File Type, File Format, Encoding
set statusline+=%1*\ %3p%%\                        " Percentage of document
set statusline+=%0*\ %{%WordCountOrRowCol()%}\     " Word Count for Markdown, Row/Col for all else

" Status Bar Colors
hi statusline guifg=black guibg=#8fbfdc ctermfg=black ctermbg=cyan
hi User1 guifg=#adadad guibg=#4e4e4e ctermfg=007 ctermbg=239 
hi User2 guifg=#adadad guibg=#303030 ctermfg=007 ctermbg=236 
au InsertEnter * hi statusline guifg=black guibg=#d7afff ctermfg=black ctermbg=magenta
au InsertLeave * hi statusline guifg=black guibg=#8fbfdc ctermfg=black ctermbg=cyan


" Tabline
function! Tabline()
    let s = ''
    for i in range(tabpagenr('$'))
        let tab = i + 1
        let buflist = tabpagebuflist(tab)
        let bufname = bufname(buflist[tabpagewinnr(tab) - 1])

        " Set tab state
        let s .= '%' . tab . 'T'
        let s .= (tab == tabpagenr() ? '%#TabLineSel#' : '%#TabLine#')

        " Set tab label
        let s .= ' ' . tab . ' '
        let s .= (bufname != '' ? fnamemodify(bufname, ':t') : '[No Name]') . ' '
    endfor

    " Finalize tabline
    let s .= '%#TabLineFill#' | return s
endfunction

set tabline=%!Tabline()
]])
