if exists("g:__loaded_line_manipulation")
  finish
endif
let g:__loaded_line_manipulation = 1

" Add blank line above and below
" When adding line below, move cursor to the just added line (most likely you're going to edit next)
" When adding line above, don't move cursor at all
nnoremap <silent> <Plug>blankUp   :<C-U>call <SID>BlankUp(v:count1)<CR>
nnoremap <silent> <Plug>blankDown :<C-U>call <SID>BlankDown(v:count1)<CR>

" Do not override <CR> in quickfix and command line window
" Let <CR> and <S-CR>(mapped as <F20>) behave in the same way in normal mode
" Let <C-CR> (mapped as <F21>) to put new line above
nnoremap <expr> <CR> &buftype ==# 'quickfix' \|\| getcmdwintype() != '' ? "\<CR>" : "o\<ESC>"
nnoremap <expr> <F20> &buftype ==# 'quickfix' \|\| getcmdwintype() != '' ? "\<CR>" : "o\<ESC>"
nmap <F21> <Plug>blankUp

" Move lines up/down
" http://vim.wikia.com/wiki/Moving_lines_up_or_down
nnoremap <silent> <A-j> :m .+1<CR>==
nnoremap <silent> <A-k> :m .-2<CR>==
inoremap <silent> <A-j> <Esc>:m .+1<CR>==gi
inoremap <silent> <A-k> <Esc>:m .-2<CR>==gi
vnoremap <silent> <A-j> :call <SID>MoveBlockDown()<CR>
vnoremap <silent> <A-k> :call <SID>MoveBlockUp()<CR>

" Duplicate lines or selection
vnoremap <silent> <localleader>d "zy`>"zp
nnoremap <silent> <localleader>d :<C-u>execute 'normal! "zyy' . v:count1 . '"zp'<CR>

" Execute {action} to the beginning of the line
" D - removes from cursor to the EOL
" <localleader>D is the opposite, removes from cursor to the BOL
nmap <localleader>D d0
nmap <localleader>C c0
nmap <localleader>X x0
nmap <localleader>Y y0

" Split line
nnoremap <silent> M :call <SID>SplitLine()<CR>

function s:SplitLine()
  " Do a split
  exe "normal! i\<CR>\<ESC>"

  " Remember position and last search expression
  normal! mw
  let _s = @/

  " Remove any trailing whitespace characters from the line above
  silent! -1 s/\v +$//

  " Restore last search expression
  nohlsearch
  let @/ = _s

  " Restore cursor position
  normal! `w
endfunction

" Insert blank line below and above without changing cursor
function! s:BlankUp(count) abort
  put!=repeat(nr2char(10), a:count)
  ']+1
  silent! call repeat#set("\<Plug>blankUp", a:count)
endfunction

function! s:BlankDown(count) abort
  put =repeat(nr2char(10), a:count)
  '[-1
  silent! call repeat#set("\<Plug>blankDown", a:count)
endfunction

" Borrowed from 'matze/vim-move': Plugin to move lines and selections up and down
" https://github.com/matze/vim-move
function! s:MoveBlockDown() range
  execute "silent!" a:firstline "," a:lastline "move '>+1"
  normal! gv=gv
endfunction

function! s:MoveBlockUp() range
  execute "silent!" a:firstline "," a:lastline "move '<-2"
  normal! gv=gv
endfunction
