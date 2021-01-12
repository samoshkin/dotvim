" Colorize devicons
let g:devicons_colors = {
      \ 'brown': ['', '', ''],
      \ 'aqua': [''],
      \ 'blue': ['', '', '', '', '', '', '', '', '', '', '', '', '', '', ''],
      \ 'purple': ['', '', '', '', '', '', ''],
      \ 'red': ['', '', '', '', '', ''],
      \ 'beige': ['', '', '', ''],
      \ 'yellow': ['', '', 'λ', ''],
      \ 'orange': ['', '', ''],
      \ 'darkOrange': ['', '', '', ''],
      \ 'pink': ['', ''],
      \ 'green': ['', '', '', '', '', '', '', ''],
      \ 'white': ['', '', '', '', ''],
      \ }

" Borrowed from https://github.com/tiagofumo/vim-nerdtree-syntax-highlight
" Fits well for dark schemes
let g:colors = {
      \ 'brown': ["#905532", 95],
      \ 'aqua': ["#3AFFDB", 86],
      \ 'blue': ["#689FB6", 73],
      \ 'darkBlue': ["#44788E", 66],
      \ 'purple': ["#834F79", 93],
      \ 'red': ["#AE403F", 131],
      \ 'darkRed': ["#97050C", 88],
      \ 'beige': ["#F5C06F", 215],
      \ 'yellow': ["#F09F17", 214],
      \ 'orange': ["#D4843E", 172],
      \ 'orange2': ["#DD5E1C", 166],
      \ 'darkOrange': ["#F16529", 202],
      \ 'pink': ["#CB6F6F", 167],
      \ 'lightGreen': ["#8FAA54", 107],
      \ 'green': ["#31B53E", 71],
      \ 'white': ["#FFFFFF", 231],
      \}

" Apply devicons coloring only for NERDtree buffer
for color in keys(g:devicons_colors)
  exec 'syntax match devicons_' . color . ' /\v' . join(g:devicons_colors[color], '.|') . './ containedin=ALL'
  exec 'highlight devicons_' . color . ' guifg=' .g:colors[color][0] . ' ctermfg=' . g:colors[color][1]
endfor
