" Show NERDTree directory icons in yellow
hi! link NERDTreeFlags GruvboxYellow
hi! link NERDTreeOpenable GruvboxYellow
hi! link NERDTreeClosable GruvboxYellow

" Change highlight groups for diff mode
hi! clear DiffChange
hi! clear DiffText
hi! clear DiffAdd
hi! clear DiffDelete
" Do not highlight changed line, highlight only changed text within a line
hi! link DiffChange NONE
hi! DiffText ctermbg=208 guibg=#fe8019 ctermfg=233 guifg=#141617
hi! DiffAdd ctermfg=108 guifg=#8ec07c
hi! DiffDelete ctermfg=167 guifg=#fb4934 guibg=#141617 ctermbg=233

" Highlight +1 column when text exceeds 'max_line_length' (set by 'editorconfig/editorconfig-vim' plugin)
hi! link ColorColumn GruvboxRedSign

" Show fold column without background, to make it same color as a line number column
hi! FoldColumn ctermbg=NONE guibg=NONE
" Remove background for lines of folded text
hi! Folded ctermbg=NONE guibg=NONE

" Flag icons in lightline
hi! LightlineFlagBlue cterm=bold ctermfg=33 gui=bold guifg=#268bd2 ctermbg=236 guibg=#303030
hi! LightlineFlagBlueInverse cterm=bold ctermbg=33 gui=bold guibg=#268bd2 ctermfg=236 guifg=#303030
hi! LightlineFlagRed cterm=bold gui=bold ctermfg=167 guifg=#fb4934 ctermbg=236 guibg=#303030
hi! LightlineFlagOrange cterm=bold gui=bold ctermfg=208 guifg=#fe8019 ctermbg=236 guibg=#303030

" When same symbols are highlighted on hover
hi! link CocHighlightText MatchParen

" Diagnostic sign of level=info
hi! link CocInfoSign GruvboxBlueSign

" Highlight both search and incremental search identically
hi! link Search IncSearch

" todos, fixme and notes markers
hi! Todo cterm=bold gui=bold ctermfg=109 guifg=#458588
hi! Note term=standout cterm=bold ctermfg=223 ctermbg=234 gui=bold guifg=fg guibg=bg

" Just to declare background/foreground colors used by iTerm Argonaut color scheme
hi TerminalArgonaut ctermfg=214 ctermbg=237 guifg=#fffaf5 guibg=#101321

" Highlight trailing or mixed whitespaces
hi ExtraWhitespace ctermbg=darkred guibg=darkred

" COMMITMSG
hi! link gitcommitSummary Normal
hi! link gitcommitOverflow GruvboxRed

if has("terminal") && has("termguicolors") && &t_Co >= 256
  " Override terminal colorscheme by providing mapping for 16 basic ANSI colors
  " Theme: gruvbox
  let g:terminal_ansi_colors = [
        \ "#1d2021",
        \ "#cc241d",
        \ "#98971a",
        \ "#d79921",
        \ "#458588",
        \ "#b16286",
        \ "#689d6a",
        \ "#a89984",
        \ "#928374",
        \ "#fb4934",
        \ "#b8bb26",
        \ "#fabd2f",
        \ "#83a598",
        \ "#d3869b",
        \ "#8ec07c",
        \ "#ebdbb2"]

  " Theme: argonaut
  " let g:terminal_ansi_colors = [
  "       \ "#2e2e2e",
  "       \ "#ff260d",
  "       \ "#9ae204",
  "       \ "#ffc400",
  "       \ "#00a1f9",
  "       \ "#805bb5",
  "       \ "#00ddef",
  "       \ "#feffff",
  "       \ "#555555",
  "       \ "#ff4250",
  "       \ "#b8e36d",
  "       \ "#ffd852",
  "       \ "#00a5ff",
  "       \ "#ab7aef",
  "       \ "#74fcf3",
  "       \ "#feffff"]
endif

" Customize fzf colors to match your color scheme
" - fzf#wrap translates this to a set of `--color` options
let g:fzf_colors =
      \ { 'fg':      ['fg', 'Normal'],
      \ 'preview-bg': ['bg', 'TerminalArgonaut'],
      \ 'bg':      ['bg', 'Normal'],
      \ 'hl':      ['fg', 'Comment'],
      \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
      \ 'hl+':     ['fg', 'Statement'],
      \ 'info':    ['fg', 'PreProc'],
      \ 'border':  ['fg', 'Ignore'],
      \ 'prompt':  ['fg', 'Conditional'],
      \ 'pointer': ['fg', 'Exception'],
      \ 'marker':  ['fg', 'Keyword'],
      \ 'spinner': ['fg', 'Label'],
      \ 'header':  ['fg', 'Comment'] }
