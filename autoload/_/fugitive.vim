" Find fugitive status window and return it's number
function _#fugitive#GetStatusWindow()
  for winnr in range(1, winnr('$'))
    if getbufvar(winbufnr(winnr), 'fugitive_type') == 'index'
      return winnr
    endif
  endfor
  return -1
endfunction

" Collapse and expand status window whenever some action is taken in it,
" like viewing diff, or making a commit
function _#fugitive#OnStatusBufferEnterOrLeave(isEnter)
  let l:fug_status_window = _#fugitive#GetStatusWindow()
  if l:fug_status_window != -1
    if a:isEnter
      " When entering, resize status window to equal widht and height
      exe l:fug_status_window . " wincmd w"
      exe "wincmd ="
    elseif !a:isEnter && winnr('$') > 1
      " When leaving, collapse status window
      exe l:fug_status_window . " wincmd w"
      exe "resize 0"
      exe "wincmd p"
    endif
  endif
endfunction

" In a fugitive commit window, when cursor is over file diff
" open the file in a diff mode, comparing it to a previous revision
" e.g. Gdiff <commit~>:<file>
function! _#fugitive#OpenFileSnapshotInCommitBuffer()
  silent norm O
  wincmd o
  diffoff
  e!
endfunction
