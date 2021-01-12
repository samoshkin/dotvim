" Remember cursor position before running quickfix cmd
" Disable folding
function _#qfloc#on_enter(list_type)
  " Do nothing, when we're already in quickfix list
  if &filetype ==# 'qf'
    return
  endif

  exe "normal m" . (a:list_type ==# 'qf' ? 'Q' : 'L')

  " TODO (consider): do we need this
  " Disable folding temporarily
  " let curr_buffer = bufnr("%")
  " bufdo set nofoldenable
  " execute 'buffer ' . curr_buffer
endfunction

" Get back to cursor position before quickfix command was executed
function _#qfloc#quit(list_type)
  " First, remove focus from quickfix list
  if &filetype ==# 'qf'
    wincmd p
  endif

  " Restore folding back
  " bufdo set foldenable

  " Close quickfix or locationlist window if opened
  if a:list_type ==# 'qf'
    if qf#IsQfWindowOpen()
      call qf#toggle#ToggleQfWindow(0)

      " Get back to location before quick list was spawned
      exe "normal `Qzz"
    endif
  else
    if qf#IsLocWindowOpen(0)
      call qf#toggle#ToggleLocWindow(0)

      " Get back to location before quick list was spawned
      exe "normal `Lzz"
    endif
  endif

endfunction

" Navigate thru lists, open closed folds, and recenter screen
function _#qfloc#navigate(command)
  try
    exe a:command
  catch /E553/
    echohl WarningMsg
    echo "No more items in a list"
    echohl None
    return
  catch /\(E776\|E42\)/
    echohl WarningMsg
    echo "No location or quickfix list"
    echohl None
    return
  endtry
  if &foldopen =~ 'quickfix' && foldclosed(line('.')) != -1
    normal! zv
  endif
  normal zz
endfunction

" Removes item under the cursor from quickfix/location list and reloads it
function _#qfloc#remove_line()
  let list_type = qf#IsLocWindowOpen(0) ? 'loc' : 'qf'

  if list_type ==# 'qf'
    let current_line_nr = line(".")

    " List is empty, nothing to remove
    if current_line_nr == 0
      echohl WarningMsg
      echo "No more items in a list"
      echohl None
      return
    endif

    " Replace quickfix list with a new list without one item
    " filter v:key index is 0-based
    call setqflist(filter(getqflist(), 'v:key != ' . (current_line_nr - 1)), 'r')

    " Close and reopen quickfix list to fix highlighting
    cclose | cwindow

    " Display the next item, so we don't start at first one
    exe "cc " . current_line_nr
  else
    " Get index of current item in location list
    let current_line_nr = line(".")

    " List is empty, nothing to remove
    if current_line_nr == 0
      echohl WarningMsg
      echo "No more items in a list"
      echohl None
      return
    endif

    " Replace quickfix list with a new list without one item
    " filter v:key index is 0-based
    call setloclist(0, filter(getloclist(0), 'v:key != ' . (current_line_nr - 1)), 'r')

    " Close and reopen quickfix list to fix highlighting
    lclose | lwindow

    " Display the next item, so we don't start at first one
    exe "ll " . current_line_nr
  endif
endfunction

" Populate quickfix list with selected files
function! _#qfloc#build_quickfix_list(lines)
  " Remember location to get back to after we're done with quickfix list
  normal mQ

  call setqflist(map(copy(a:lines), '{ "filename": v:val, "lnum": 1, "col": 1 }'))
  botright copen
  cc
endfunction
