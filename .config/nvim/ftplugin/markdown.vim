set wrap
set linebreak
set spell

map j gj
map k gk

au TermOpen * setlocal nospell

"nnoremap <leader>r :w<CR>:silent !open -a Skim.app %:r.pdf<CR>:!~/bin/buildnote.sh %:p<CR>
nnoremap <leader>r :w<CR>:!~/bin/buildnote.sh "%:p"<CR>
nnoremap <leader>o :silent exec "!open -a Skim.app %:r.pdf"<CR>

"autocmd BufWritePre !~/bin/buildnote.sh "%:p"<CR>

nnoremap <silent> <leader>i :call MarkdownClipboardImage()<CR>

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

fu! RedirStdoutNewTabSingle(cmd)
  let a:newt= expand('%:p') . ".out.tmp"
  tabnext
  if expand('%:p') != a:newt
    tabprevious
    exec "tabnew" . a:newt
  else
    exec "%d"
  endif
  exec 'silent r !' . a:cmd
  set nomodified
endfunc

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
