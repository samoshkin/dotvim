if exists("g:__loaded_delimitmate")
  finish
endif
let g:__loaded_plug_delimitmate = 1

" Alternative solutions:
" - https://github.com/jiangmiao/auto-pairs (seems to be abandoned as of Dec 2020)
" - https://github.com/rstacruz/vim-closer (expand only braces and does this only on <CR>)
" - https://github.com/tpope/vim-endwise

" Turn autoclosing behavior on
let delimitMate_autoclose = 1
" Add extra line on CR with proper indentation
let g:delimitMate_expand_cr = 1
" When Space is typed inside pairs, put 2 Spaces at leading and trailing pair
let g:delimitMate_expand_space = 1
" Expand quotes in addition to braces
let g:delimitMate_expand_inside_quotes = 1
" Jump over the bracket when user types closing bracket and it already exists
let g:delimitMate_jump_expansion = 1
" See the correct number of pairs and decide whether to add new pair or not
let g:delimitMate_balance_matchpairs = 1
" What constitutes pairs and quotes
let g:delimitMate_matchpairs = "(:),[:],{:}"
let g:delimitMate_nesting_quotes = ['`']

" Disable expanstion in comments and strings
let delimitMate_excluded_regions = "Comment,String"

" Toggle delimit mate globally
nnoremap <leader>t{} :DelimitMateSwitch<CR>
