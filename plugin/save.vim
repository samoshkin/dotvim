if exists("g:__loaded_autosave")
  finish
endif
let g:__loaded_autosave = 1

" Disable swap file, disable backup
" But keep persistent undo history that survives Vim process
set noswapfile
set nobackup
set undofile

" Directories for backup, undo and swap files
set undodir=~/.vim/tmp/undo//

" Create directories automatically if they don't already exist.
if !isdirectory(expand(&undodir))
  call mkdir(expand(&undodir), "p", 0700)
endif

" Do not use built-in "autosave" behavior, because it triggers for a limited set of events (buf change, quit)
" Use '907th/vim-auto-save', that saves file on a wider set of events (TextChanged, InsertLeave, CursorHold)
set noautowrite

" Automatically read files which are changed outside vim
" Caveat: works only when some external command is run
"
" Use 'tmux-plugins/vim-tmux-focus-events' plugin to fix 'autoread' facility:
" - it normalizes FocusGained|FocusLost events under iTerm2+tmux
" - on FocusGained it runs ':checktime' to detect outside file changes
set autoread

" '907th/vim-auto-save' settings
" Can be overridden per buffer
let g:auto_save=0
let g:auto_save_events = ["InsertLeave", "TextChanged", "CursorHold"]
let g:auto_save_silent = 1
let g:auto_save_presave_hook = 'call OnAutoSaveHook()'

function OnAutoSaveHook()
  " Disable auto-saving in diff mode
  if &diff
    let g:auto_save_abort = 1
  endif
endfunction

" Toggle autosave ON/OFF per buffer
command -nargs=0 ToggleAutoSave let b:auto_save = !_#util#get_var('auto_save', 0)
