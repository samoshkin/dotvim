if exists("g:__loaded_plug_nerdtree")
  finish
endif
let g:__loaded_plug_nerdtree = 1

" FIXME: when NERDTree is used as netrw, alternate buffer is messed up when file
" is opened from NERDTree. It does not happend when NERDTree is used as a drawer

" Open up a window level NERDTree instead of a netrw in the target window.
let NERDTreeHijackNetrw=1

" Automatically close tree after file is opened from it
let NERDTreeQuitOnOpen=0

" Sort files with numbers naturally
let NERDTreeNaturalSort=1

" Show hidden files by default
let NERDTreeShowHidden=1

" Show hidden files/directories first when sorting
let NERDTreeSortHiddenFirst = 1

" Minimal UI, do not show bookmarks and help blocks
let NERDTreeMinimalUI=1

" Increase tree explorer split a bit (default is 31)
let NERDTreeWinSize=40

" Automatically delete buffer when file is deleted from the tree explorer
let NERDTreeAutoDeleteBuffer=1

" Open and preview in splits
let g:NERDTreeMapOpenSplit="s"
let g:NERDTreeMapPreviewSplit="S"
let g:NERDTreeMapOpenVSplit="v"
let g:NERDTreeMapPreviewVSplit="V"

" Open and preview in current window
let g:NERDTreeMapActivateNode="o"
let g:NERDTreeMapPreview="O"

" CC - change root to the current selected directory
" CD - change root to CWD
let g:NERDTreeMapChangeRoot = "CC"

" Instead of "I" default mapping (D for dotfiles)
let g:NERDTreeMapToggleHidden="D"

" Do not show '.git' directories, in addition to what specified in .gitignore
let NERDTreeIgnore=['\~$', '^\.git$[[dir]]']

" Open NERDTree as a drawer on the left side
noremap  <silent> <leader>F :call <SID>toggle_nerd_tree_drawer()<CR>
" Open NERDTree inside current window as netrw does
nnoremap <silent> <leader>f :e %:h<CR>
" Locate current file in NerdTREE drawer
nnoremap <silent> <leader>l :NERDTreeFind<CR>

augroup aug_nerd_tree
  au!

  " Exit vim when the only buffer remaining is NerdTree
  autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

  " Automatically refresh root note, when entering NERDTree
  autocmd BufEnter * if exists("b:NERDTree") && &ft ==# 'nerdtree' | silent NERDTreeRefreshRoot | endif
augroup END

" Toggle NERDTree and resize it to take g:NERDTreeWinSize width
" Because NERDTree window tend to collapse when other windows enter and leave fullscreen mode
function s:toggle_nerd_tree_drawer()
  NERDTreeToggle
  if exists("b:NERDTree")
    exe 'vert resize' . g:NERDTreeWinSize
  endif
endfunction
" }}}
