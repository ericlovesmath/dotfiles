setlocal wrap
setlocal linebreak
" setlocal spell
setlocal spellsuggest+=5
setlocal breakindent
setlocal formatlistpat="^\s*\d\+[\]:.)}\t ]\s*"
setlocal breakindentopt=shift:0,list:-1

syntax match UrlNoSpell '\w\+:\/\/[^[:space:]]\+' contains=@NoSpell

map j gj
map k gk