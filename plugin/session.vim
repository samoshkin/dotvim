if exists("g:__loaded_session")
  finish
endif
let g:__loaded_session = 1

" Session is created manually and bounded to project cwd
" If given dir has session associated, it gets loaded automatically

" Use "https://github.com/tpope/vim-obsession" to automatically save session using :mksession on various events
" when new buffer is added, when Vim is exited, when layout changes
"
" What is going to be save in session
" + buffers,curdir,tabpages,winsize,terminal,winpos:set sessionoptions-=folds
set sessionoptions-=options
set sessionoptions-=help
set sessionoptions-=blank
set sessionoptions-=terminal

" What's get saved by :mkview command (save and restor contents of a window)
set viewoptions-=options

" All sessions are stored in "~/.vim/tmp/sessions" directory
let g:session_dir = expand("~/.vim/tmp/sessions")

" Automatically try loading session for current directory,
" unless arguments are passed to vim and input is not read from stdin
augroup aug_session_management
  au!

  autocmd StdinReadPre * let g:__is_stdin = g:this_obsession
  autocmd VimEnter * nested if argc() == 0 && !exists("g:__is_stdin")
        \ | call _#session#SessionLoad()
        \ | endif
augroup END

" Set of commands to manage session
command! -nargs=0 SessionCreate call _#session#SessionCreate()
command! -nargs=0 SessionLoad call _#session#SessionLoad()
command! -nargs=0 SessionUnload call _#session#SessionUnload(0)
command! -nargs=0 SessionRemove call _#session#SessionUnload(1)
