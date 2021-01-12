if exists("g:__loaded_plug_sideways")
  finish
endif
let g:__loaded_plug_sideways = 1

" 'AndrewRadev/sideways.vim' A Vim plugin to move function arguments (and other delimited-by-something items) left and right.

" Alternative solutions:
" - https://github.com/AndrewRadev/sideways.vim
" - https://github.com/machakann/vim-swap
" - https://github.com/PeterRincker/vim-argumentative
" - https://github.com/tommcdo/vim-exchange (exchange anything, more general use case)

" Limit the time to search otherwise it takes too long on big files
let g:sideways_search_timeout = 20

" Move argument to the left/right
nnoremap <silent> <a :SidewaysLeft<cr>
nnoremap <silent> >a :SidewaysRight<cr>

" Navigate between arguments
nnoremap <silent> [a :SidewaysJumpLeft<cr>
nnoremap <silent> ]a :SidewaysJumpRight<cr>

" Insert before/append after a new argument
nmap <leader>ai <Plug>SidewaysArgumentInsertBefore
nmap <leader>aa <Plug>SidewaysArgumentAppendAfter
nmap <leader>aI <Plug>SidewaysArgumentInsertFirst
nmap <leader>aA <Plug>SidewaysArgumentAppendLast

" "argument" text objects. 'ia/aa' stands for (a)rguments
omap aa <Plug>SidewaysArgumentTextobjA
xmap aa <Plug>SidewaysArgumentTextobjA
omap ia <Plug>SidewaysArgumentTextobjI
xmap ia <Plug>SidewaysArgumentTextobjI

