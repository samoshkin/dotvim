" Make NERDtree respect rules from .gitignore

" Limitation: uses only single root .gitignore file

" Load only once
if exists("loaded_nerdtree_gitignore_filter")
    finish
endif
let loaded_nerdtree_gitignore_filter = 1


" Hook into NERDTreeIgnore mechanism
call NERDTreeAddPathFilter('NERDTreeGitIgnoreFilter')

function NERDTreeGitIgnoreFilter(params)
  let root_path = a:params['nerdtree'].root.path.str()
  let current_path_abs = a:params['path'].str()

  " Take absolute path and make it relative to root path
  " If node is a directory, append trailing slash
  let current_path = fnamemodify(current_path_abs, ':s?\V' . root_path . '??')
  if a:params['path'].isDirectory
    let current_path .= '/'
  endif

  " Find .gitignore file in the root path
  let root_gitignore = root_path . '/.gitignore'
  if !filereadable(root_gitignore)
    return
  endif

  " Parse rules from .gitignore and cache them
  let b:ignore_regexes = exists('b:ignore_regexes')
        \ ? b:ignore_regexes
        \ : s:build_ignore_regex(root_gitignore)

  " First process negative regexes followed by positive
  let regex_pos = b:ignore_regexes[0]
  let regex_neg = b:ignore_regexes[1]

  if regex_pos == '\(\)'
    return
  endif

  if regex_neg == '\(\)'
    return current_path =~ regex_pos
  endif

  return current_path =~ regex_neg ? 0 : current_path =~ regex_pos ? 1 : 0
endfunction

" Convert rules from ignore file to single regex
function s:build_ignore_regex(ignore_file)
  let regexes = []
  let regexes_negated = []
  let lines = readfile(a:ignore_file)

  for l in lines
    if l =~ '^#' || l =~ '^\s*$'
      continue
    endif

    let regex = l
    let regex = substitute(regex, '\.', '\\.', 'g')
    let regex = substitute(regex, '*', '.*', 'g')
    let regex = substitute(regex, '?', '.', 'g')

    " If rule starts with leading slash, it should match the beginning of pathname
    if regex =~ '^/'
      let regex = '^' . regex
    endif
    let regex = escape(regex, '/~')

    " Detect positive and negated regexps
    if regex =~ '^!'
      call add(regexes_negated, regex[1:])
    else
      call add(regexes, regex)
    endif
  endfor

  return [
        \ '\(' . join(regexes, '\|') . '\)',
        \ '\(' . join(regexes_negated, '\|') . '\)']
endfunction
