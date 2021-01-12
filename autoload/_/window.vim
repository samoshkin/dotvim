" Smart quit window logic
function _#window#QuitWindow()

  " If we're in merge mode, exit it
  if get(g:, 'mergetool_in_merge_mode', 0)
    call mergetool#stop()
    return
  endif

  " When running as 'vimdiff' or 'vim -d', close both files and exit Vim
  if get(g:, 'is_started_as_vim_diff', 0)
    windo quit
    return
  endif

  " If current window is in diff mode, close all diff windows
  let l:diff_windows = _#diff#GetDiffWindows()
  if &diff && len(l:diff_windows) >= 2

    diffoff!
    diffoff!

    call s:CloseEachWindow(l:diff_windows)
    return
  endif

  quit
endfunction

" Close list of windows
function s:CloseEachWindow(windows)
  " Reverse sort window numbers, start closing from the highest window number: 3,2,1
  " This is to ensure window numbers are not shifted while closing
  for _win in sort(copy(a:windows), {a, b -> b - a})
    exe _win . "wincmd c"
  endfor
endfunction
