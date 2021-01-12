" MIT License. Copyright (c) 2013-2019 Bailey Ling et al.
" Modified By: Alexey Samoshkin

" Settings
let s:max_lines = get(g:, 'whitespace#max_lines', 5000)
let s:c_like_langs = get(g:, 'whitespace#c_like_langs', ['arduino', 'c', 'cpp', 'cuda', 'go', 'javascript', 'ld', 'php'])
let s:indentation_algorithm = get(g:, 'whitespace#indentation_algorithm', 0)
let s:skip_check_ft = get(g:, 'whitespace#skip_check_ft', ['make'])

" Whitespaces in the end of line
function! s:check_trailing_whitespaces()
  return search('\s$', 'nw')
endfunction

" Mixed tabs and spaces within a line
function! s:check_mixed_indentation()
  if s:indentation_algorithm == 1
    " [<tab>]<space><tab>
    " spaces before or between tabs are not allowed
    let t_s_t = '(^\t* +\t\s*\S)'
    " <tab>(<space> x count)
    " count of spaces at the end of tabs should be less than tabstop value
    let t_l_s = '(^\t+ {' . &ts . ',}' . '\S)'
    return search('\v' . t_s_t . '|' . t_l_s, 'nw')
  elseif s:indentation_algorithm == 2
    return search('\v(^\t* +\t\s*\S)', 'nw')
  else
    return search('\v(^\t+ +)|(^ +\t+)', 'nw')
  endif
endfunction

" Different indentation in different lines
function! s:check_inconsistent_indentation()
  if index(s:c_like_langs, &ft) > -1
    " for C-like languages: allow /** */ comment style with one space before the '*'
    let head_spc = '\v(^ +\*@!)'
  else
    let head_spc = '\v(^ +)'
  endif
  let indent_tabs = search('\v(^\t+)', 'nw')
  let indent_spc  = search(head_spc, 'nw')
  if indent_tabs > 0 && indent_spc > 0
    return min([indent_tabs, indent_spc])
  else
    return 0
  endif
endfunction

" Main function
function! _#mixedwhitespace#check()
  if &readonly || !&modifiable || line('$') > s:max_lines || index(s:skip_check_ft, &ft) >= 0
    return [0, 0, 0]
  endif

  return [
        \ s:check_trailing_whitespaces(),
        \ s:check_mixed_indentation(),
        \ s:check_inconsistent_indentation() ]
endfunction
