" status bar colors
au InsertEnter * hi statusline guifg=black guibg=#d7afff ctermfg=black ctermbg=magenta
au InsertLeave * hi statusline guifg=black guibg=#8fbfdc ctermfg=black ctermbg=cyan
hi statusline guifg=black guibg=#8fbfdc ctermfg=black ctermbg=cyan

" Status line
" default: set statusline=%f\ %h%w%m%r\ %=%(%l,%c%V\ %=\ %P%)

" Status Line Custom
let g:currentmode={
    \ 'n'  : 'Normal',
    \ 'no' : 'Normal·Operator Pending',
    \ 'v'  : 'Visual',
    \ 'V'  : 'V·Line',
    \ '^V' : 'V·Block',
    \ 's'  : 'Select',
    \ 'S'  : 'S·Line',
    \ '^S' : 'S·Block',
    \ 'i'  : 'Insert',
    \ 'R'  : 'Replace',
    \ 'Rv' : 'V·Replace',
    \ 'c'  : 'Command',
    \ 'cv' : 'Vim Ex',
    \ 'ce' : 'Ex',
    \ 'r'  : 'Prompt',
    \ 'rm' : 'More',
    \ 'r?' : 'Confirm',
    \ '!'  : 'Shell',
    \ 't'  : 'Terminal'
    \}

function! LspReport() abort
    let sl = ''
	if luaeval('not vim.tbl_isempty(vim.lsp.buf_get_clients(0))')
	    let hints = luaeval("vim.lsp.diagnostic.get_count(0, [[Hint]])")
	    let warnings = luaeval("vim.lsp.diagnostic.get_count(0, [[Warning]])")
	    let errors = luaeval("vim.lsp.diagnostic.get_count(0, [[Error]])")
        let sl = ' +'.hints.' ~'.warnings.' -'.errors.' '
    endif
	return sl
endfunction

set laststatus=2
set noshowmode

set statusline=
set statusline+=%0*\ %{toupper(g:currentmode[mode()])}\   " The current mode
set statusline+=%1*\ %<%f%m%r%h%w\                        " File path, modified, readonly, helpfile, preview
set statusline+=%2*%{LspReport()}                       "   

set statusline+=%=                                        " Right Side

set statusline+=%2*\ %Y\                                  " FileType
set statusline+=\|                                        " Separator
set statusline+=\ %{&ff}\                                 " FileFormat (dos/unix..)
set statusline+=\|                                        " Separator
set statusline+=\ %{''.(&fenc!=''?&fenc:&enc).''}         " Encoding
set statusline+=\                                         " Separator
set statusline+=%1*\ %3p%%\                               " Percentage of document
set statusline+=%0*\ %3l:%2v\                             " Row/Col

hi User1 ctermfg=007 ctermbg=239 guibg=#4e4e4e guifg=#adadad
hi User2 ctermfg=007 ctermbg=236 guibg=#303030 guifg=#adadad
hi User3 ctermfg=236 ctermbg=236 guibg=#303030 guifg=#303030
hi User4 ctermfg=239 ctermbg=239 guibg=#4e4e4e guifg=#4e4e4e

au BufEnter NvimTree setlocal statusline=%0*\ %<%f
