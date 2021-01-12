if exists("g:__loaded_buffers")
  finish
endif
let g:__loaded_buffers = 1

" Navigate buffers
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [b :bprev<CR>

" Kill buffer, but retain any split window, and show alternate buffer
nnoremap <silent> <leader>x :bp \| bwipeout #<CR>

" Kill all buffers
nnoremap <silent> <leader>X :%bwipeout<CR>

" Read command output and show it in new scratch buffer
" :Read !{system_command}
" :Read {vim_command}
command! -nargs=1 -complete=command Read silent call _#buffer#read_command_output_in_new_buffer(<q-args>)

" Cycle between main and alternate file
nnoremap <silent> <leader><Tab> <C-^>

" Save file as
nnoremap <silent> <leader>wa :call feedkeys(':saveas '.expand('%'), 't')<CR>
" Rename file (using coc.nvim)
nnoremap <silent> <leader>wr :<C-u>CocCommand workspace.renameCurrentFile<CR>

" Copy file basename only, file path, dirname
command! -nargs=0 CopyFileName let @+ = expand("%:t") | echo 'Copied to clipboard: ' . @+
command! -nargs=0 CopyFilePath let @+ = expand("%:p:~") | echo 'Copied to clipboard: ' . @+
command! -nargs=0 CopyFileDir let @+ = expand("%:p:~:h") | echo 'Copied to clipboard: ' . @+

nnoremap <leader>yfn :CopyFileName<CR>
nnoremap <leader>yfp :CopyFilePath<CR>
nnoremap <leader>yfd :CopyFileDir<CR>

" Open current directory in Finder
" 'open' is OSX specific
command -nargs=0 OpenDirectory silent exec "!open " . expand("%:p:h") | redraw!


