
" Get visually selected text based on given visualMode
function! _#util#get_selected_text(visualmode)
  let saved_unnamed_register = @@
  if a:visualmode ==# 'v' || a:visualmode ==# 'V'
    normal! `<v`>y
  elseif a:visualmode ==# 'char'
    normal! `[v`]y
  else
    return
  endif
  let selection = @@
  let @@ = saved_unnamed_register

  return selection
endfunction

" Trim each path segment down to 3 characters except the last one
" /this/is/very/loooooong/directory/index.js -> /thi~/is/ver~/loo~/dir~/index.js
function! _#util#shorten_file_path(path)
  let subs = split(a:path, "/")
  let result = ''
  let i = 1
  for s in subs
    if i != 1
      let result .= '/'
    endif

    let result .= (i == len(subs)) ? s : (strpart(s, 0, 3) . '~')
    let i += 1
  endfor

  return result
endfunction

" Echo warning message with highlighting enabled
function _#util#echo_warning(message)
  echohl WarningMsg
  echo a:message
  echohl None
endfunction

function _#util#Noop()
endfunction

" Resolves variable value respecting window->buffer->global hierarchy
" If var does not exist at any level, returns user-provided fallback value
function _#util#get_var(...)
  let varName = a:1

  if exists('w:' . varName)
    return w:{varName}
  elseif exists('b:' . varName)
    return b:{varName}
  elseif exists('g:' . varName)
    return g:{varName}
  else
    return exists('a:2') ? a:2 : ''
  endif
endfunction

