" Directory storing session files
function! _#session#GetSessionDir()
  return g:session_dir . getcwd()
endfunction

" Create new session
function! _#session#SessionCreate()
  let l:sessiondir = _#session#GetSessionDir()
  if !isdirectory(l:sessiondir)
    call mkdir(l:sessiondir, "p", 0700)
  endif
  exe "Obsession " . _#session#GetSessionDir()
endfunction

" Loads a session if it exists, and if not already within a session
function! _#session#SessionLoad()
  let l:sessionfile = _#session#GetSessionDir() . '/Session.vim'
  if filereadable(l:sessionfile) && ObsessionStatus() != '[$]'
    %bdelete
    exe 'source ' . l:sessionfile
    norm zvzz
  else
    echom "No session loaded."
  endif
endfunction

" Unload current session, stop tracking.
" Do not remove underlying session file, so you can load session back later
function! _#session#SessionUnload(shouldRemove)
  if ObsessionStatus() == '[$]'
    exe (a:shouldRemove ? "Obsession!" : "Obsession")
    silent! %bdelete
  else
    echo "No session loaded."
  endif
endfunction
