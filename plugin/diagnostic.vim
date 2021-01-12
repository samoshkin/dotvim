if exists("g:__loaded_diagnostic")
  finish
endif
let g:__loaded_diagnostic = 1

" Show code actions for current line
nmap <leader>ee <Plug>(coc-codeaction-line)

" Show code actions for given selection range
xmap <silent> <leader>e  <Plug>(coc-codeaction-selected)
nmap <silent> <leader>e  <Plug>(coc-codeaction-selected)

" Show code actions for current file
nmap <leader>eb  <Plug>(coc-codeaction)

" Show current diagnostics in a preview window
nnoremap <silent> <leader>ep :<C-u>call CocAction("diagnosticPreview")<CR>

" Show available quick fixes
nnoremap <silent> <leader>eq :<C-u>CocAction quickfix<CR>

" Navigate through diagnostic issues
nmap ]e <Plug>(coc-diagnostic-next)
nmap [e <Plug>(coc-diagnostic-prev)
nmap ]E <Plug>(coc-diagnostic-next-error)
nmap [E <Plug>(coc-diagnostic-prev-error)

" Toggle diagnostics ON/OFF
nnoremap <silent> <leader>te :call CocAction("diagnosticToggle")<CR>

" Show list of diagnostics (in a coc list, or in a Vim's loclist)
nnoremap <leader>ce :<C-u>CocList diagnostics<CR>
nnoremap <leader>cE :<C-u>CocDiagnostics<CR>

