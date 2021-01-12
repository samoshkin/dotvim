
" Capture command's output and show it in a new buffer
function! _#buffer#read_command_output_in_new_buffer(cmd)
  " Capture command output
  if a:cmd =~ '^!'
    let output = system(matchstr(a:cmd, '^!\zs.*'))
  else
    redir => output
    execute a:cmd
    redir END
  endif

  " Show in new scratch buffer
  call _#buffer#new_scratch_buffer(output, "Command: " . a:cmd)
endfunction

" Show text or list of lines in a new scratch buffer
function _#buffer#new_scratch_buffer(content, ...)
  let title = get(a:, "1", "[Scratch]")
  let new_command = get(a:, "2", "enew")

  exe new_command
  let w:scratch = 1
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile hidden
  silent! exe "file! " . title

  " Automatically kill buffer on WinLeave
  augroup aug_scratch_autohide
    autocmd!
    execute 'autocmd WinLeave <buffer=' . bufnr('%') . '> bdelete'
  augroup END

  if type(a:content) == type([])
    call setline(1, a:content)
  else
    call setline(1, split(a:content, "\n"))
  endif
endfunction
