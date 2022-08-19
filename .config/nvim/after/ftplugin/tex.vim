setlocal wrap
setlocal linebreak
" setlocal spell
setlocal spellsuggest+=5
setlocal breakindent
" setlocal formatlistpat="^\s*\d\+[\]:.)}\t ]\s*"
setlocal breakindentopt=shift:0,list:-1

map j gj
map k gk

let maplocalleader = " "

let g:vimtex_compiler_progname = 'nvr'
let g:vimtex_view_method = 'skim'
let g:vimtex_imaps_enabled = 0           
let g:vimtex_complete_enabled = 0        

set conceallevel=1
let g:tex_conceal='abdmg'
" highlight Conceal ctermfg=<fg color> ctermbg=<bg color>
highlight Conceal guifg=#d19a66 guibg=NONE


" Default is 500 lines and gave me lags on missed key presses
" let g:vimtex_delim_stopline = 5


"nnoremap <C-f> :exec '.!~/Desktop/bash/vim_inkscape.py %:r "'.getline(".").'"'
autocmd FileType tex nmap <buffer> <C-T> :!latexmk -pvc -pdf %<CR>

inoremap <C-f> <Esc>: silent exec "!inkscape-figures watch"<CR>: silent exec '.!inkscape-figures create "'.getline('.').'" "'.b:vimtex.root.'/figures/"'<CR><CR>
"nnoremap <C-f> : silent exec '!inkscape-figures edit "'.b:vimtex.root.'/figures/" > /dev/null 2>&1 &'<CR><CR>:redraw!<CR>
nnoremap <leader>i :call ImageFromClipboard()<CR>

function! ImageFromClipboard() abort

  " Create `img` directory if it doesn't exist
  let img_dir = getcwd() . '/imgs'
  if !isdirectory(img_dir)
    silent call mkdir(img_dir)
  endif

  " First find out what filename to use
  let index = 1
  let file_path = img_dir . "/image" . index . ".png"
  while filereadable(file_path)
    let index = index + 1
    let file_path = img_dir . "/image" . index . ".png"
  endwhile

  let clip_command = 'osascript'
  let clip_command .= ' -e "set png_data to the clipboard as «class PNGf»"'
  let clip_command .= ' -e "set referenceNumber to open for access POSIX path of'
  let clip_command .= ' (POSIX file \"' . file_path . '\") with write permission"'
  let clip_command .= ' -e "write png_data to referenceNumber"'

  silent call system(clip_command)
  if v:shell_error == 1
    normal! p
    echoerr "Error: Missing Image in Clipboard"
  else
    let caption = getline('.')
    execute "normal! ddi\\begin{figure}[ht]\r" . 
    \"\\centering\r" . 
    \"\\includegraphics[width=200px]{./imgs/image" . index . ".png}\r" . 
    \"\\caption{" . caption . "}\r" . 
    \"\\label{fig:LABEL}\r" .
    \"\\end{figure}"
    execute "normal! 3k4w:w"
  endif
endfunction

augroup vimtex_config
    au!
    au User VimtexEventQuit call vimtex#compiler#clean(0)
augroup END

set foldmethod=marker
set fmr=<<<,>>>
set fillchars=fold:\ 

" Key maps for VimTex

" <localleader>lI Show Vimtex Info
" <localleader>lt Show Table of Contents
" <localleader>lv Show current line on pdf
" <localleader>ll Compiler Start
" <localleader>lk Compiler Stop
" <localleader>le Show Errors
" <localleader>lc Clean Compiler

" dse Delete Surrounding Environment
" dsc Delete Surrounding Command
" ds$ Delete Surrounding Math
" ]] [[ [] ][
" % ac ic ad id
