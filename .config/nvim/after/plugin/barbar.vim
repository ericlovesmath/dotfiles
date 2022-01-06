" Buffer Colored when edited
" hi BufferTabpageFill guibg=none
hi BufferInactive ctermfg=007 ctermbg=239 guibg=#4e4e4e guifg=#adadad
hi BufferInactiveSign ctermfg=007 ctermbg=239 guibg=#4e4e4e guifg=#adadad
hi BufferInactiveMod ctermfg=007 ctermbg=239 guibg=#4e4e4e
hi BufferInactiveIndex ctermfg=007 ctermbg=239 guibg=#4e4e4e guifg=#adadad

let bufferline = get(g:, 'bufferline', {})
let bufferline.animation = v:false
let bufferline.closable = v:false
let bufferline.maximum_padding = 2
let bufferline.maximum_length = 25

nnoremap <silent> <Tab> :w<CR>:BufferNext<CR>
nnoremap <silent> <S-Tab> :w<CR>:BufferPrevious<CR>
