if exists("g:__loaded_ui")
  finish
endif
let g:__loaded_ui = 1

set encoding=utf-8

" Show absolute line numbers in a gutter
set number

" Do not warn abount unsaved changes when navigating to another buffer
set hidden

" Minimal number of screen lines to keep above and below the cursor, expect for bol and eol
" Sets padding to the screen boundaries when scrolling up and down
set scrolloff=2

" Recenter cursor during horizontal scroll
" Keep some characters visible during horizontal scroll
" Makes sense only for nowrap
set sidescroll=0
set sidescrolloff=3

" Every wrapped line will continue visually indented (same amount of
" space as the beginning of that line), thus preserving horizontal blocks
" of text.
set breakindent

" Show invisible characters
" "extends" and "precedes" is when long lines are not wrapped
set list
set listchars=tab:→\ ,space:⋅,extends:>,precedes:<,nbsp:+
set showbreak=↪
set linebreak

" Highlight the line with a cursor
set cursorline

augroup aug_ui
  au!

  " Disable cursor line highlighting in Insert mode
  au InsertEnter * setlocal nocursorline
  au InsertLeave * setlocal cursorline
augroup END

" Disable reading vim variables & options from special comments within file header or footer
set modelines=0

" Keep cursor at the same column after navigating within a file (e.g, gg, G)
set nostartofline

" Add @@@ marks on the last column of last line if there is more text below
set display=lastline

" Timeout of user inactivity. Used to save swap file, vim-gitgutter plugin, and others
set updatetime=1000

" Disable startup message, disable ins-completion messages
set shortmess+=Ic

" Conceal text and highlight with "Conceal" highlight group
set conceallevel=2

" Disable annoying beep sounds
set noerrorbells
set visualbell t_vb=

" Always show sign column, even when no signs
set signcolumn=yes

" Performance optimizations
" Indicate we have a fast terminal connection. Improves smooth redrawing
set ttyfast

" After given time, Vim will stop hihglighting further matches
" Syntax highlighting vs performance trade-off
set redrawtime=600

" Delay screen redraw for macros, uncompleted commands
" Redraw as fewer as possible
set lazyredraw

" Don't try to highlight lines longer than N characters.
set synmaxcol=300
