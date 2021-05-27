let g:tex_flavor='latex'
let g:vimtex_compiler_progname = 'nvr'
let g:vimtex_view_method='skim'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'

"setlocal spell
"set spelllang=en

"nnoremap <C-f> :exec '.!~/Desktop/bash/vim_inkscape.py %:r "'.getline(".").'"'
autocmd FileType tex nmap <buffer> <C-T> :!latexmk -pvc -pdf %<CR>

let g:vimtex_view_general_viewer = '/Applications/Skim.app/Contents/SharedSupport/displayline'
let g:vimtex_view_general_options = '-r @line @pdf @tex'
let g:vimtex_view_general_options_latexmk = '-r 1'

nnoremap <leader>r :w<CR>

inoremap <C-f> <Esc>: silent exec "!inkscape-figures watch"<CR>: silent exec '.!inkscape-figures create "'.getline('.').'" "'.b:vimtex.root.'/figures/"'<CR><CR>
"nnoremap <C-f> : silent exec '!inkscape-figures edit "'.b:vimtex.root.'/figures/" > /dev/null 2>&1 &'<CR><CR>:redraw!<CR>
nnoremap <C-p> :call MarkdownClipboardImage()<CR>


function! MarkdownClipboardImage() abort
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
  autocmd User VimtexEventInitPost VimtexCompile
  set wrap
  au User VimtexEventQuit call vimtex#compiler#clean(1)
augroup END

set foldmethod=marker
set fmr=<<<,>>>
set fillchars=fold:\ 

let g:vimtex_quickfix_autojump = 1
let g:vimtex_quickfix_mode = 1
let g:vimtex_quickfix_warnings = {
	    \ 'Underfull' : 0,
	    \ 'Overfull' : 0,
	    \ 'specifier changed to' : 0,
	    \ }


