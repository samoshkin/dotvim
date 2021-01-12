if exists("g:__loaded_plug_vim_matchup")
  finish
endif
let g:__loaded_plug_vim_matchup = 1

" 'andymass/vim-matchup', even better % navigate and highlight matching words
" Modern matchit and matchparen replacement

" Do not show matching paren in a popup window or status line
let g:matchup_matchparen_offscreen = {}

" NOTE: disabled this, because cannot get it work
let g:matchup_transmute_enabled = 0

" Do not go beyond +-200 lines around when search for a match to highlight it
let g:matchup_matchparen_stopline = 200

" Use deferred highlighting to avoid flickering in Insert mode
" Set low timeout. Stop highlighting if timeout is elapsed
let g:matchup_matchparen_deferred = 1
let g:matchup_matchparen_timeout = 100

" Disable highlighting matches when popup menu is ON
let g:matchup_matchparen_pumvisible = 0

" Enable 'cs%', 'ds%' mappings similar to 'vim-surround' plugin
" Change detected match pair to another type of parens/braces.
let g:matchup_surround_enabled=1

" When disabled, do not fallback to Vim's native matchit plugin
let b:matchup_matchparen_fallback = 0

" In HTML, highlight only tagname itself except attributes
let g:matchup_matchpref = {
      \ 'html': { 'tagnameonly': 1 }
      \ }

" Jump into mathcit nearest block (use g% instead of z%)
" This follows the spirit of using 'g{X}' mappings to jump somewhere
nmap g% <Plug>(matchup-z%)
xmap g% <Plug>(matchip-z%)

" Text objects. Use im/am instead of i%/a% ('m' stands for [m]atchit)
xmap am a%
omap am a%
xmap im i%
omap im i%

" Toggle highlighting matching parens
nnoremap <leader>tm :<C-u>call <SID>ToggleMatchParens()<CR>

function s:ToggleMatchParens()
  if g:matchup_matchparen_enabled
    NoMatchParen
    echo "[vim-matchup]: Highlight Disabled"
  else
    DoMatchParen
    echo "[vim-matchup]: Highlight Enabled"
  endif
endfunction
