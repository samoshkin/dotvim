if exists("g:__loaded_plug_splitjoin")
  finish
endif
let g:__loaded_plug_splitjoin = 1

" 'AndrewRadev/splitjoin.vim', Switch between single-line and multiline forms of code
" - "gS" to split a one-liner into multiple lines
" - "gJ" (with the cursor on the first line of a block) to join a block into a single-line statement.

" Do not echo status messages
let g:splitjoin_quiet = 0

" Remap gJ. If splitjoin plugin fails, it would not fallback to Vim's default 'gJ' behavior
let g:splitjoin_join_mapping = ''
nnoremap gJ :SplitjoinJoin<cr>
