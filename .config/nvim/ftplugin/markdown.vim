set wrap
set linebreak
set spell

map j gj
map k gk

"nnoremap <leader>r :w<CR>:silent !open -a Skim.app %:r.pdf<CR>:!~/bin/buildnote.sh %:p<CR>
nnoremap <leader>r :w<CR>:!~/bin/buildnote.sh "%:p"<CR>
nnoremap <leader>o :w<CR>:!~/bin/buildnote.sh "%:p"<CR>:!open -a Skim.app %:r.pdf<CR>

"autocmd BufWritePre !~/bin/buildnote.sh "%:p"<CR>

nnoremap <silent> <leader>p :call MarkdownClipboardImage()<CR>

function! MarkdownClipboardImage() abort

  " Create `img` directory if it doesn't exist
  let img_dir = getcwd() . '/img'
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
  else
      call inputsave()
      let img_name = input('Enter Image Name: ')
      call inputrestore()
      execute "normal! i![" . img_name . "](./img/image" . index . ".png){ width=250px }"
      execute "normal! F]"
  endif
endfunction

command! -range Tablify <line1>,<line2>s/\s*|/§|/g | <line1>,<line2>!column -s § -t
"inoremap <bar> <bar><esc>:call <SID>Tablify()<cr>a
function! s:Tablify()
  let p = '^\s*|\s.*\s|\s*$'
  if getline('.') =~ '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let lnum = line('.')
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    execute "normal! vip:Tablify\<cr>"
    execute 'normal! ' . lnum . 'G'
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction

" command! -range Tablify <line1>,<line2>s /|/§|/g | <line1>,<line2>!column -s § -t

" Auto lists: Automatically continue/end lists by adding markers if the
" previous line is a list item, or removing them when they are empty
function! s:auto_list()
  let l:preceding_line = getline(line(".") - 1)
  if l:preceding_line =~ '\v^\d+\.\s.'
    " The previous line matches any number of digits followed by a full-stop
    " followed by one character of whitespace followed by one more character
    " i.e. it is an ordered list item

    " Continue the list
    let l:list_index = matchstr(l:preceding_line, '\v^\d*')
    call setline(".", l:list_index + 1. ". ")
  elseif l:preceding_line =~ '\v^\d+\.\s$'
    " The previous line matches any number of digits followed by a full-stop
    " followed by one character of whitespace followed by nothing
    " i.e. it is an empty ordered list item

    " End the list and clear the empty item
    call setline(line(".") - 1, "")
  elseif l:preceding_line[0] == "-" && l:preceding_line[1] == " "
    " The previous line is an unordered list item
    if strlen(l:preceding_line) == 2
      " ...which is empty: end the list and clear the empty item
      call setline(line(".") - 1, "")
    else
      " ...which is not empty: continue the list
      call setline(".", "- ")
    endif
  endif
endfunction

" N.B. Currently only enabled for return key in insert mode, not for normal
" mode 'o' or 'O'
"inoremap <buffer> <CR> <CR><Esc>:call <SID>auto_list()<CR>A
