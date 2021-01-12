if exists("g:__loaded_plug_vim_rooter")
  finish
endif
let g:__loaded_plug_vim_rooter = 1

" vim-rooter changes the working directory to the project root when you open a file or directory.

" Apply 'change dir to project root' behavior for all files
let g:rooter_targets = '*'

" Project root is indicated by .git repo root
let g:rooter_patterns = ['.git']

" Change directory for all windows/buffers, rather than a single window
let g:rooter_cd_cmd = 'cd'

" Do not echo when directory is changed
let g:rooter_silent_chdir = 1
