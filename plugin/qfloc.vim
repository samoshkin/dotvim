if exists("g:__loaded_qfloc_list")
  finish
endif
let g:__loaded_qfloc_list = 1

" Automatically quit if qf/loc is the last window opened
let g:qf_auto_quit = 1

" Don't autoresize if number of items is less than 10
let g:qf_auto_resize = 0

" Automatically open qf/loc list after :grep, :make
let g:qf_auto_open_quickfix = 1
let g:qf_auto_open_loclist = 1

" Use qf/loc list local mappings to open match in split/tab/preview window
" s - open entry in a new horizontal window
" v - open entry in a new vertical window
" t - open entry in a new tab
" o - open entry and come back
" O - open entry and close the location/quickfix window
" p - open entry in a preview window
let g:qf_mapping_ack_style = 1

" Toggle lists
nmap <silent> <leader>tq <Plug>(qf_qf_toggle_stay)
nmap <silent> <leader>tl <Plug>(qf_loc_toggle_stay)

" Quit lists
nmap <silent> <leader>tQ :call _#qfloc#quit('qf')<CR>
nmap <silent> <leader>tL :call _#qfloc#quit('loc')<CR>

" Navigate thru items in quickfix and location lists
" Borrowed from 'tpope/vim-unimpaired'
nnoremap <silent> ]q :<C-u>call _#qfloc#navigate("cnext")<CR>
nnoremap <silent> [q :<C-u>call _#qfloc#navigate("cprev")<CR>
nnoremap <silent> ]Q :<C-u>call _#qfloc#navigate("clast")<CR>
nnoremap <silent> [Q :<C-u>call _#qfloc#navigate("cfirst")<CR>
nnoremap <silent> ]l :<C-u>call _#qfloc#navigate("lnext")<CR>
nnoremap <silent> [l :<C-u>call _#qfloc#navigate("lprev")<CR>
nnoremap <silent> ]L :<C-u>call _#qfloc#navigate("llast")<CR>
nnoremap <silent> [L :<C-u>call _#qfloc#navigate("lfirst")<CR>
" NOTE: use { and } to navigate to previous and next files in qf/loc list (comes
" from romainl/qf-vim)

" Commands available from 'vim-qf' plugin
" - :Keep {pattern}
" - :Reject {pattern}
" - :Restore
" - :Doline (same to :cdo and :ldo)
" - :Dofile (same to :cfdo and :lfdo)

augroup aug_quickfix_list
  au!

  " Detect entering quickfix/location list and retain current location
  autocmd QuickFixCmdPre [^l]* call _#qfloc#on_enter('qf')
  autocmd QuickFixCmdPre    l* call _#qfloc#on_enter('loc')

  " Remove single item/line using dd. Note, that buffer is still not modifiable. Other normal editing commands are not allowed
  autocmd FileType qf nnoremap <silent> <buffer> dd :call _#qfloc#remove_line()<CR>
  " Show list of unique files
  autocmd FileType qf nnoremap <silent> <buffer> L :FilesOnly<CR> <bar> :copen<CR>
  " Open fold and recenter screen on <Enter>
  autocmd FileType qf nmap <silent> <buffer> <CR> <CR>zvzz
  " Convert to coc.nvim list
  autocmd FileType qf nmap <silent> <buffer> <expr> C empty(getloclist(0)) ? ":cclose\<bar>CocList quickfix\<CR>" : ":lclose\<bar>CocList locationlist\<CR>"
augroup END

