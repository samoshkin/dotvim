if exists("g:__loaded_search")
  finish
endif
let g:__loaded_search = 1

" Case sensitivity
set ignorecase
set smartcase

" Do not highlight search results by default
" Enable incremental searching
" Stop when reaching last match, don't start over
set nohlsearch
set incsearch
set wrapscan

" Use /g flag for substitute command by default
set gdefault

" Center search results and open fold
nnoremap n nzvzz
nnoremap N Nzvzz
nnoremap * *zvzz
nnoremap # #zvzz

" Print total search matches count for last search
nnoremap <silent> g? :call <SID>PrintSearchTotalCount()<CR>

" Toggle search highlighting
" Don't use :nohl, because by default searches are not highlighted
nnoremap <silent> <leader>th :set hlsearch!<cr>

" Make '*' and '#' search for a selection in visual mode
" Inspired by https://github.com/nelstrom/vim-visual-star-search
" Got Ravings?: Vim pr0n: Visual search mappings - http://got-ravings.blogspot.com/2008/07/vim-pr0n-visual-search-mappings.html
vnoremap * :<C-u>call _#search#search_from_context("/", "selection")<CR>
vnoremap # :<C-u>call _#search#search_from_context("?", "selection")<CR>

" Shortcuts for substitute as ex command
nnoremap <C-s> :%s/
vnoremap <C-s> :s/

" Choose grep backend, use ripgrep if available
if executable("rg")
  set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case\ --hidden\ --follow
  set grepformat=%f:%l:%c:%m
else
  set grepprg=grep\ -n\ --with-filename\ -I\ -R
  set grepformat=%f:%l:%m
endif

" Search commands including native :grep
command! -nargs=+ -complete=custom,s:RipgrepArgs Grep  grep <args> | redraw!
command! -nargs=+ -complete=custom,s:RipgrepArgs -bang Rg call _#search#search_fzf_ripgrep(<q-args>, <bang>0)
command! -nargs=* -complete=custom,s:RipgrepArgs -bang Rgi call _#search#search_fzf_ripgrep_instant(<q-args>, <bang>0)
command! -nargs=+ -complete=custom,s:RipgrepArgs -bang Rgl call _#search#search_fzf_ripgrep_list_files(<q-args>, <bang>0)

" Search all TODOs, FIXMEs, BUGs (project wide or in current file)
command! -nargs=* Todos silent grep --word-regexp -e 'TODO:' -e 'FIXME:' -e 'BUG:' | redraw!
command! -nargs=* BTodos silent grep --word-regexp -e 'TODO:' -e 'FIXME:' -e 'BUG:' % | redraw!

" Command line suggestions of ripgrep args
function! s:RipgrepArgs(...)
  let list = ['-S', '--smartcase', '-i', '--ignorecase', '-w', '--word-regexp',
        \ '-e', '--regex', '-u', '--skip-vcs-ignores', '-t', '--extension',
        \ '-F', '--fixed-strings']
  return join(list, "\n")
endfunction

" <leader>/{motion}, use motion to select text to search
nnoremap <silent> <leader>/ :<C-u>set operatorfunc=_#search#search_from_textobj<CR>g@
vnoremap <silent> <leader>/ :<C-u>call _#search#search_from_textobj()<CR>
" Search for word under the cursor
nnoremap <silent> <leader>/w :call _#search#build_search_command("word", expand('<cword>'), 0)<CR>
" Repeat buffer-local search project-wide
nnoremap <silent> <leader>// :call _#search#build_search_command("search", @/, 0)<CR>
" Get back to the location before the search started
nnoremap <silent> <leader>? `G

" Start instant search with ripgrep right away without any prompts
nnoremap <silent> g/ :exe "norm mG" <bar> Rgi<CR>

augroup aug_search
  autocmd!

  " Detect when search command line is entered and left
  " Inspired by https://github.com/google/vim-searchindex
  autocmd CmdlineEnter /,\? call <SID>on_search_cmdline_focus(1)
  autocmd CmdlineLeave /,\? call <SID>on_search_cmdline_focus(0)

  " Detect when search command window is entered
  autocmd CmdwinEnter *
        \ if getcmdwintype() =~ '[/?]' |
        \   silent! nmap <buffer> <CR> <CR><Plug>OnSearchCompleted|
        \ endif
augroup END

function! s:on_search_cmdline_focus(enter)
  if a:enter
    " Turn on hlsearch to highlight all matches during incremental search
    set hlsearch

    " Use <C-j> and <C-k> to navigate through matches during incremental search instead of <C-d>,<C-t>
    cmap <C-j> <C-g>
    cmap <C-k> <C-t>

    " Detect when search is triggered by hooking into <CR>
    cmap <expr> <CR> "\<CR>" . (getcmdtype() =~ '[/?]' ? "<Plug>OnSearchCompleted" : "")
  else
    " On cmdline leave, rollback all changes and mappings
    set nohlsearch

    cunmap <C-j>
    cunmap <C-k>
    cunmap <CR>
  endif
endfunction

" Define OnSearchCompleted hook
noremap  <Plug>OnSearchCompleted <Nop>
nnoremap <silent> <Plug>OnSearchCompleted :call <SID>OnSearchCompleted()<CR>

function s:OnSearchCompleted()

  " Open folds in the matches lines
  " foldopen+=search causes search commands to open folds in the matched line
  " - but it doesn't work in mappings. Hence, we just open the folds here.
  if &foldopen =~# "search"
    normal! zv
  endif

  " Recenter screen for any kind of search (same as we do for n/N shortcuts)
  normal! zz

  " Print total search matches count
  call s:PrintSearchTotalCount()
endfunction

function s:PrintSearchTotalCount()
  " Detect search direction
  let search_dir = v:searchforward ? '/' : '?'

  " Remember cursor position
  let pos=getpos('.')

  " Remember start and end marks of last change/yank
  let saved_marks = [ getpos("'["), getpos("']") ]

  try
    " Execute "%s///gn" command to capture match count for the last search pattern
    let output = ''
    redir => output
    silent! keepjumps %s///gne
    redir END

    " Extract only match count from string like "X matches on Y lines"
    let match_count = str2nr(matchstr(output, '\d\+'))

    " Compose message like "X matches for /pattern"
    let msg = l:match_count . " matches for " . l:search_dir . @/

    " Flush any delayed screen updates before printing "l:msg".
    " See ":h :echo-redraw".
    redraw | echom l:msg
  finally

    " Restore [ and ] marks
    call setpos("'[", saved_marks[0])
    call setpos("']", saved_marks[1])

    " Restore cursor position
    call setpos('.', pos)
  endtry
endfunction

