if exists("g:__loaded_folding")
  finish
endif
let g:__loaded_folding = 1

set foldenable
set foldlevelstart=99
set foldlevel=99
set foldcolumn=1
" foldmethod is usually set on per-file basis
" set foldmethod=indent

" What triggers automatic fold opening
set foldopen-=block
set foldopen-=hor

" Use [z and ]z to navigate to start/end of the fold
" Use zj and zk to navigate to neighbooring folds
" Use zJ and zK to navigate to prev/next opened fold
" https://stackoverflow.com/questions/9403098/is-it-possible-to-jump-to-closed-folds-in-vim
nnoremap <silent> zJ :call <SID>NextOpenedFold('j')<CR>
nnoremap <silent> zK :call <SID>NextOpenedFold('k')<CR>

function! s:NextOpenedFold(dir)
  let cmd = 'norm!z' . a:dir
  let view = winsaveview()
  let [l0, l, open] = [0, view.lnum, 0]
  while l != l0 && !open
    exe cmd
    let [l0, l] = [l, line('.')]
    let open = foldclosed(l) < 0
  endwhile
  if !open
    call winrestview(view)
  endif
endfunction

" Close all folds except the one under the cursor, and center the screen
nnoremap <silent> <leader>z zMzvzz

" Toggle folding in the current buffer
nnoremap <silent> <leader>tz :setlocal foldenable!<CR>

