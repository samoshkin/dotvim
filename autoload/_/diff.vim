
" Get list of all windows running in diff mode
function! _#diff#GetDiffWindows()
  return filter(range(1, winnr('$')), { idx, val -> getwinvar(val, '&diff') })
endfunction

" In diff mode:
" - Disable syntax highlighting
" - Disable spell checking
function _#diff#DetectDiffMode(timer)
  " Finish earlier when inside terminal or popup, because changing windows is not allowed
  if index(['popup', 'terminal'], &buftype) != -1
    return
  endif

  " Find if there're any windows in a diff mode
  let diff_windows = filter(
        \  _#diff#GetDiffWindows(),
        \  { idx, win  -> getwinvar(win, '_diff_mode_already_checked') != 1 })

  " Iterate over diff windows and disable syntax
  " ownsyntax, disable syntax only for that partuclar window, rather than a buffer
  " also, it disables spellchecking
  if !empty(diff_windows)
    for _win in diff_windows
      call win_execute(win_getid(_win), "ownsyntax off")
      call win_execute(win_getid(_win), "let w:_diff_mode_already_checked = 1")
    endfor
  endif
endfunction
