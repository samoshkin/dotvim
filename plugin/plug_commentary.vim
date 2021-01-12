if exists("g:__loaded_plug_vim_commentary")
  finish
endif
let g:__loaded_plug_vim_commentary = 1

" Mappings:
" - gc, comment action in different modes
" - <operator>gc, act upon commented lines
" - gcc, <localleader>c, comment line
" - gcu, uncomment current and adjacent lines
" - <leader> c, comment line

" Comment line
nmap <silent> <localleader>c <Plug>CommentaryLine
xmap <localleader>c <Plug>Commentary

