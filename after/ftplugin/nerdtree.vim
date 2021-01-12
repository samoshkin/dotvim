" Use arrow keys to navigate
nmap <buffer> l o
nmap <buffer> L O
nmap <buffer> h p
nmap <buffer> H P

" Remap 'x' (close parent node) with <nowait> to make Vim not wait for global 'xx' mapping
nnoremap <nowait> <buffer> x :call nerdtree#ui_glue#invokeKeyMap("x")<CR>

" Disable cursorline in NERDtree to avoid lags
" built-in g:NERDTreeHighlightCursorline does not work
setlocal nocursorline

" Delete fugitive buffers automatically on leave
setlocal bufhidden=wipe
