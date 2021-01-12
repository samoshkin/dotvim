if exists("g:__loaded_motion")
  finish
endif
let g:__loaded_motion = 1

" Let movements work with display lines instead of real lines
" For hjkl mappings take 'wrap' into account to move through display lines only
" See https://vim.fandom.com/wiki/Move_cursor_by_display_lines_when_wrapping
noremap <silent> k gk
noremap <silent> j gj
noremap <silent> $ g$
noremap <silent> 0 g0
noremap <silent> ^ g^
noremap <silent> <Home> g<Home>
noremap <silent> <End> g<End>

" Provide original functionality on the g-keys
nnoremap <silent> gk k
nnoremap <silent> gj j
noremap <silent> g$ $
noremap <silent> g0 0
noremap <silent> g^ ^

" Use 'vim-smoothscroll' plugin to animate page movements
noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 10, 2)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 10, 2)<CR>
noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 5, 4)<CR>
noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 5, 4)<CR>

" When navigating to the EOF, center the screen
nnoremap G Gzz

" Use 'H' and 'L' keys to move to start/end of the line
noremap H g^
noremap L g$

" Recenter when jump back
nnoremap <C-o> <C-o>zz

" z+, moves next line below the window
" z-, moves next line above the window
nnoremap z- z^

" Center screen and open fold after navigation shortcuts
nnoremap } }zvzz
nnoremap { {zvzz
nnoremap ) )zvzz
nnoremap ( (zvzz

" Navigate between sections (Nroff sections by default)
" Section movement commands also look for one more thing: an opening or closing curly brace ({ or }) as the first character on a line.
" This allows you to move between sections of C-like languages easily
" Center screen and open folds after movement
nnoremap ]] ]]zvzz
nnoremap [[ [[zvzz
nnoremap [] []zvzz
nnoremap ][ ][zvzz

" Reselect text this was last changed or yanked
" https://vim.fandom.com/wiki/Selecting_your_pasted_text
nnoremap <expr> g[] '`[' . getregtype()[0] . '`]'
onoremap [] :exec "normal g[]"<CR>

" Some aliases for operator pending mode:
" q - operate inside quotes (' " `)
xmap q iq
omap q iq

" 'rhysd/vim-textobj-anyblock' configuration
" let 'ib/ab' text object to match only various braces, but not quotes
" we have separate 'iq/aq' text object
let g:textobj#anyblock#blocks = [ '(', '{', '[', '<' ]

