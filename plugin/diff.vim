if exists("g:__loaded_diff")
  finish
endif
let g:__loaded_diff = 1

" Open diffs in vertical splits
" Use 'xdiff' library options: patience algorithm with indent-heuristics (same to Git options)
" NOTE: vim uses the external diff utility which doesn't do word diffs nor can it find moved-and-modified lines.
" NOTE: still this algorithm is worse than "delta" or "DiffMerge"
" See: https://stackoverflow.com/questions/36519864/the-way-to-improve-vimdiff-similarity-searching-mechanism
" See: https://vimways.org/2018/the-power-of-diff/
set diffopt=internal,filler,vertical,context:5,foldcolumn:1,indent-heuristic,algorithm:patience

" Detect if vim is started as a 'git difftool' (e.g. vim -d, vimdiff)
if &diff
  let g:is_started_as_vim_diff = 1
endif

" Diff exchange and movement actions. Mappings come from 'samoshkin/vim-mergetool'
nmap <expr> <C-Left> &diff? '<Plug>(MergetoolDiffExchangeLeft)' : '<C-Left>'
nmap <expr> <C-Right> &diff? '<Plug>(MergetoolDiffExchangeRight)' : '<C-Right>'
nmap <expr> <C-Down> &diff? '<Plug>(MergetoolDiffExchangeDown)' : '<C-Down>'
nmap <expr> <C-Up> &diff? '<Plug>(MergetoolDiffExchangeUp)' : '<C-Up>'

" Move through diffs. [c and ]c are native Vim mappings
" Use "do", "dp" native mappings to pull\push diff hunks between diff splits
nnoremap <expr> <Up> &diff ? '[czz' : ''
nnoremap <expr> <Down> &diff ? ']czz' : ''
nnoremap <expr> <Left> &diff? '<C-w>h' : ''
nnoremap <expr> <Right> &diff? '<C-w>l' : ''

" Change :diffsplit command to open diff in new tab
cnoreabbrev <expr> diffsplit getcmdtype() == ":" && getcmdline() == 'diffsplit' ? 'tab split \| diffsplit' : 'diffsplit'

augroup aug_diffs
  au!

  " Inspect whether some windows are in diff mode, and tweak them
  " Run after a delay to make sure '&diff' option is already set by Vim
  au WinEnter,BufEnter * call timer_start(50, '_#diff#DetectDiffMode')

  " Highlight VCS conflict markers (<<<<<<<, =======, >>>>>>>)
  au VimEnter,WinEnter * if !exists('w:_vsc_conflict_marker_match') |
        \   let w:_vsc_conflict_marker_match = matchadd('ErrorMsg', '^\(<\|=\||\|>\)\{7\}\([^=].\+\)\?$') |
        \ endif
augroup END

