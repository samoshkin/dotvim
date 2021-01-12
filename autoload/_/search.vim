" Initiate search, prepare command using selected backend and context for the search
" Contexts are: word, selection, last search pattern
function _#search#build_search_command(context, text, run_immediately)
  " Choose search backend: grep, Rg, ...
  let backend = _#search#ask_user_for_search_backend()
  if empty(backend)
    return
  endif

  " Espace special characters
  let text = _#search#escape_search_text(a:text)

  " Grep/ripgrep/ctrlsf args
  let args = []

  " Search literally without regexp when context is 'word' or 'selection'
  if a:context ==# 'word' || a:context ==# 'selection' || a:context ==# 'search'
    call add(args, '-F')
  endif

  " Use word boundaries when context is 'word'
  if a:context ==# 'word'
    call add(args, '-w')
  endif

  " Compose ":GrepXX" command
  let search_command = ":\<C-u>" . backend
  let search_command .= empty(args) ? ' ' : ' ' . join(args, ' ') . ' '
  let search_command .= '-- ' . text

  " Run immediately or let user to review a command
  if a:run_immediately
    let search_command .= "\<CR>"
  endif

  " Set global mark to easily get back after we're done with a search
  normal mG

  " Put actual command in a command line
  call feedkeys(search_command, 'n')
endfunction

" To be used as operatorfunc
function _#search#search_from_textobj()
  let selection = _#util#get_selected_text(visualmode())

  call _#search#build_search_command("selection", selection, 0)
endfunction

" Escape unsafe characters in a search text
function _#search#escape_search_text(text)
  " Properly escape search text
  " Remove new lines (when several lines are visually selected)
  let l:text = substitute(a:text, "\n", "", "g")

  " Escape backslashes
  let l:text = escape(l:text, '\')

  " Put in double quotes
  let l:text = escape(l:text, '"')
  let l:text = empty(l:text) ? l:text : '"' . l:text . '"'

  return l:text
endfunction

" Prompt user for search command
function _#search#ask_user_for_search_backend()
  let search_choice = confirm('Choose search method: ', "&Grep\n&Rgi\nRg&l", 1)
  return search_choice == 1 ? 'Grep'
        \ : search_choice == 2 ? 'Rgi'
        \ : search_choice == 3 ? 'Rgl'
        \ : ''
endfunction

" Ripgrep search
function! _#search#search_fzf_ripgrep(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
  let command = printf(command_fmt, a:query)
  call fzf#vim#grep(command, 1, fzf#vim#with_preview(), a:fullscreen)
endfunction

" Ripgrep search, with instant query as you type. Fzf is used as a dummy
" selector, not as a fuzzy finder
function! _#search#search_fzf_ripgrep_instant(query, fullscreen)
  let text_to_search = match(a:query, '--') >= 0 ?
        \ substitute(a:query, '\v.*--\s*', '', '') :
        \ a:query

  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
  let initial_command = printf(command_fmt, a:query)
  let reload_command = (text_to_search != a:query) ?
        \ substitute(initial_command, '\V'.text_to_search, '{q}', '') :
        \ printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', substitute(text_to_search, '\v"(.+)"', '\1', ''), '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

" Ripgrep search, but show only list of files (-l)
function! _#search#search_fzf_ripgrep_list_files(query, fullscreen)
  let text_to_search = match(a:query, '--') >= 0 ?
        \ substitute(a:query, '\v.*--\s*', '', '') :
        \ a:query

  let command_search = 'rg --files-with-matches --no-messages --color=always --smart-case %s  || true'
  let command_preview = 'bat --style=numbers --color=always {} 2> /dev/null | rg --color always --colors "match:bg:yellow" --context 10 "%s"'
  return fzf#run(fzf#wrap({
        \ 'source': printf(command_search, a:query),
        \ 'options': ['+m', '--ansi', '--no-sort', '--preview', printf(command_preview, substitute(text_to_search, '\v"(.+)"', '\1', ''))]
        \ }, a:fullscreen))
endfunction

" File-local search using word under the cursor, or recent selection
function! _#search#search_from_context(direction, context)
  let text = a:context ==# 'word' ? expand("<cword>") : _#util#get_selected_text(visualmode())
  let text = substitute(escape(text, a:direction . '\'), '\n', '\\n', 'g')
  let @/ = '\V' . text

  call feedkeys(a:direction . "\<C-R>=@/\<CR>\<CR>")
endfunction
