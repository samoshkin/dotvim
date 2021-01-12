" Ask before unsafe actions
set confirm

set shell=bash
" set shell=/usr/local/bin/zsh

" Do not print output of grep, make commands to the terminal.
" Default is "&2>1 | tee"
set shellpipe=&>


" Zsh like <Tab> completion in command mode set wildmenu
set wildmode=full
set wildmenu
" Files will be ignored when expanding globs.
" set wildignore+=.hg,.git,.svn,*.swp,*.bak,*.pyc,*.class
"
" Expand '%%' and '##' for current/alternate files in command line
cnoremap %% <C-R>=fnameescape(expand('%'))<cr>
cnoremap ## <C-R>=fnameescape(expand('#'))<cr>
