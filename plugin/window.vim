if exists("g:__loaded_window")
  finish
endif
let g:__loaded_window = 1

" Navigate between windows with <C-arrow>
nnoremap <silent> <C-k> :wincmd k<CR>
nnoremap <silent> <C-j> :wincmd j<CR>
nnoremap <silent> <C-h> :wincmd h<CR>
nnoremap <silent> <C-l> :wincmd l<CR>

" Use <Bslash> instead of <C-w>, which is tough to type
nmap <Bslash> <C-w>

" Splits
set splitbelow
set splitright

" Maximize split
" Use '<C-w>=' to make window sizes equal back
nnoremap <C-w><Bslash> <C-w>_<C-w>\|

" Tab navigation (up to 5 tabs)
nnoremap <silent> <leader>1 :tabnext 1<CR>
nnoremap <silent> <leader>2 :tabnext 2<CR>
nnoremap <silent> <leader>3 :tabnext 3<CR>
nnoremap <silent> <leader>4 :tabnext 4<CR>
nnoremap <silent> <leader>5 :tabnext 5<CR>

" Or use built-in gt/gT to traverse between tabs
nnoremap <silent> ]<Tab> :tabnext<CR>
nnoremap <silent> [<Tab> :tabprev<CR>

" Tab management
nnoremap <silent> <leader>+ :tabnew<CR>:edit .<CR>
nnoremap <silent> <leader>0 :tabonly<CR>
nnoremap <silent> <leader>- :tabclose<CR>

" <C-w>T, moves window to a new tab (built-in)
" <C-w>t, copies window to a new tab (hides Vim's native behavior)
nnoremap <silent> <C-w>t :tab split<CR>

" Cycle between current and previous tab
" https://github.com/sunaku/.vim/blob/master/plugin/tab.vim
nnoremap <silent> <C-w><Tab> :execute 'normal! '. g:lasttab .'gt'<CR>

" Resize windows
" in steps greather than just 1 column at a time
let _resize_factor = 1.2
nnoremap <C-w>> :exe "vert resize " . float2nr(round(winwidth(0) * _resize_factor))<CR>
nnoremap <C-w>< :exe "vert resize " . float2nr(round(winwidth(0) * 1/_resize_factor))<CR>
nnoremap <C-w>+ :exe "resize " . float2nr(round(winheight(0) * _resize_factor))<CR>
nnoremap <C-w>- :exe "resize " . float2nr(round(winheight(0) * 1/_resize_factor))<CR>

" Smart quit window function
command QuitWindow call _#window#QuitWindow()
nnoremap <silent> <leader>q :QuitWindow<CR>
nnoremap <silent> <C-w>q :QuitWindow<CR>

" Quit all windows, exit Vim
nnoremap <silent> <leader>Q :confirm qall<CR>

" Close all readonly buffers with just a "q" keystroke, otherwise "q" is used to record macros in a normal mode
nnoremap <silent> <expr> q &readonly ? ":quit\<CR>" : "q"

augroup aug_window_management
  au!

  " Make all windows of equal size on Vim resize
  au VimResized * wincmd =

  " Remember last tab page number
  au TabLeave * let g:lasttab = tabpagenr()
augroup END

