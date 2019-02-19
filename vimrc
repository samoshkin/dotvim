" Ensure plugins are supported
set nocompatible
filetype plugin indent on

set shell=/bin/bash

" Set 'UTF-8' as default text encoding
set encoding=utf-8

" Line numbering
set number

" Whitespaces and tabs
set tabstop=2 softtabstop=2 shiftwidth=2 expandtab
" set smarttab

" key bindings - How to map Alt key? - Vi and Vim Stack Exchange - https://vi.stackexchange.com/questions/2350/how-to-map-alt-key
if &term =~ 'xterm' && !has("gui_running")
  " Tell vim what escape sequence to expect for various keychords
  " This is needed for terminal Vim to regognize Meta and Shift modifiers
  execute "set <A-w>=\ew"
  execute "set <S-F2>=\e[1;2Q"
  execute "set <A-k>=\ek"
  execute "set <A-j>=\ej"
endif


" Disable spellcheck
set nospell

" Automatically source vimrc on change
augroup auto_source_vimrc
  au!

  autocmd BufWritePost vimrc source $MYVIMRC
augroup END

" Map <ESC> key in insert mode to use 'jk' shortcut
" Remap <Ctrl-C> to <ESC> because I'm so used to it after shell environment
inoremap jk <ESC>
noremap <C-C> <ESC>
nnoremap <silent> <C-C> :noh<CR><ESC>

" Expand '%%' for directory of current file in command line mode
cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>


" Timeout settings
" Wait forever until I recall mapping
" Don't wait to much for keycodes send by terminal, so there's no delay on <ESC>
set notimeout
set ttimeout
set timeoutlen=2000
set ttimeoutlen=30

" Duplicate lines (experimental)
nnoremap <silent> D :copy .<CR>
vnoremap <silent> D :copy '><CR>gv

" Drop into insert mode
nnoremap <BS> i<BS>

" Always use system clipboard as unnamed register
set clipboard=unnamed,unnamedplus


" Move lines up/down
" http://vim.wikia.com/wiki/Moving_lines_up_or_down
function! s:MoveBlockDown() range
  execute a:firstline "," a:lastline "move '>+1"
  normal! gv=gv
endfunction

function! s:MoveBlockUp() range
  execute a:firstline "," a:lastline "move '<-2"
  normal! gv=gv
endfunction

nnoremap <silent> <A-j> :m .+1<CR>==
nnoremap <silent> <A-k> :m .-2<CR>==
inoremap <silent> <A-j> <Esc>:m .+1<CR>==gi
inoremap <silent> <A-k> <Esc>:m .-2<CR>==gi
vnoremap <silent> <A-j> :call <SID>MoveBlockDown()<CR>
vnoremap <silent> <A-k> :call <SID>MoveBlockUp()<CR>

" Zsh like <Tab> completion in Command mode
set wildmenu
set wildmode=full

" Set <leader> key to <Space>
nnoremap <Space> <Nop>
let mapleader=" "
let maplocalleader="\\"

" <Backspace> in Insert mode
set backspace=indent,eol,start



" Center search results
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz

" When navigating to the EOF, center the screen
" Don't bend your neck
nnoremap G Gzz

" Show invisible characters
set list
set listchars=tab:→\ ,space:⋅,extends:>,precedes:<
set showbreak=↪
set linebreak


" Auto indentation
set autoindent
set smartindent
set pastetoggle=<F2>

" Experimental
set shiftround

" Soft wrap

function! s:ToggleWrap()
  if &wrap
    echo "Wrap OFF"

    setlocal nowrap

    silent! unmap k
    silent! unmap j
    silent! unmap 0
    silent! unmap $
    silent! unmap <Home>
    silent! unmap <End>

    silent! iunmap <Up>
    silent! iunmap <Down>
    silent! iunmap <Home>
    silent! iunmap <End>
  else
    echo "Wrap ON"

    setlocal wrap

    noremap  <silent> <expr> k v:count ? 'k' : 'gk'
    noremap  <silent> <expr> j v:count ? 'j' : 'gj'
    noremap  <silent> 0 g0
    noremap  <silent> $ g$
    noremap  <silent> <Home> g<Home>
    noremap  <silent> <End>  g<End>

    "inoremap <silent> <Up>   <C-o>gk
    "inoremap <silent> <Down> <C-o>gj
    "inoremap <silent> <Home> <C-o>g<Home>
    "inoremap <silent> <End>  <C-o>g<End>
  endif
endfunction

" Keep some characters visible during horizontal scroll
" Recenter cursor during horizontal scroll
set sidescroll=0
set sidescrolloff=3

" Don't do hard wraps ever
set textwidth=0

" Soft wraps by default
set wrap
set breakindent
" silent! call <SID>ToggleWrap()

" Toggle between 'nowrap' and 'soft wrap'
noremap <silent> <F6> :call <SID>ToggleWrap()<CR>

" Format options
" Remove most related to hard wrapping
" Use autocommand to override defaults from $VIMRUNTIME/ftplugin
augroup format_options
  au!

  au Filetype * setlocal formatoptions=rqn1j
augroup END

" Make '*' and '#' search for a selection in visual mode
" From https://github.com/nelstrom/vim-visual-star-search/blob/master/plugin/visual-star-search.vim
" Got Ravings?: Vim pr0n: Visual search mappings - http://got-ravings.blogspot.com/2008/07/vim-pr0n-visual-search-mappings.html
function! s:VSetSearch(cmdtype)
  let temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
  let @s = temp
endfunction


xnoremap * :<C-u>call <SID>VSetSearch('/')<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch('?')<CR>?<C-R>=@/<CR><CR>
" Status line
" Always show status line, even when 1 window is opened
set laststatus=2

" Use 'H' and 'L' keys to move to start/end of the line
noremap H ^
noremap L $

" Column 80 marker
"highlight OverLength ctermbg=darkred ctermfg=white guibg=#660000
"match OverLength /\%81v.\+/


" In Insert mode, treat pasting form a buffer as a separate undoable operation
" Which can be undone with '<C-o>u'
inoremap <C-r> <C-g>u<C-r>


" Automatically open quickfix window
"augroup autoquickfix
"  autocmd!
"  autocmd QuickFixCmdPost [^l]* cwindow
"  autocmd QuickFixCmdPost    l* lwindow
"augroup END

" TODO: toggle quickfix and location list

" Borrowed from tpope/vim-unimpaired
nnoremap <silent> ]q :cnext<CR>
nnoremap <silent> [q :cprev<CR>
nnoremap <silent> ]Q :clast<CR>
nnoremap <silent> [Q :cfirst<CR>
" In order to use <C-q>, <C-s> shortcuts to navigate quick list
" make sure to sisable XON/XOFF flow control with 'stty -ixon'
nnoremap <silent> ]<C-q> :cnfile<CR>
nnoremap <silent> [<C-q> :cpfile<CR>

nnoremap <silent> ]l :lnext<CR>
nnoremap <silent> [l :lprev<CR>
nnoremap <silent> ]L :llast<CR>
nnoremap <silent> [L :lfirst<CR>
nnoremap <silent> ]<C-l> :lnfile<CR>
nnoremap <silent> [<C-l> :lpfile<CR>



" TODO: add shortcuts to navigate tags
" TODO: add shortcuts to navigate conflict markers/diff hunks

" =====================
"     Misc
" ====================
" Do not warn abount unsaved changes when navigating to another buffer
set hidden

" Apply '.' repeat command for selected each line in visual mode
vnoremap . :normal .<CR>

" Highlight the line with a cursor
set cursorline

" Show cursorline in current window and not in insert mode
augroup cursor_line
  au!
  au WinLeave,InsertEnter * set nocursorline
  au WinEnter,InsertLeave * set cursorline
augroup END

" Disable reading vim variables & options from special comments within file header or footer
set modelines=0

" Minimal number of screen lines to keep above and below the cursor, expect for bol and eol
set scrolloff=2


" Display uncompleted commands in the status line
set showcmd

" Show ruler
set ruler
" Use /g flag for substitute command by default
set gdefault


" Tweak autocompletion behavior
set complete-=i

" Add @@@ marks on the last column of last line if there is more text below
set display=lastline


"==================================================
"===           Plugins                        =====
"==================================================

" Install plugins
" Minimalist Vim Plugin Manager - https://github.com/junegunn/vim-plug
call plug#begin('~/.vim/plugged')
  Plug 'scrooloose/nerdtree'
  Plug '907th/vim-auto-save'
  Plug 'dracula/vim', { 'as': 'dracula' }
  Plug 'tpope/vim-obsession'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'junegunn/fzf', { 'do': './install --bin' }
  Plug 'junegunn/fzf.vim'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-repeat'
  Plug 'airblade/vim-gitgutter'
  Plug 'tpope/vim-surround'
  Plug 'terryma/vim-smooth-scroll'
  Plug 'tpope/vim-commentary'
  Plug 'bronson/vim-trailing-whitespace'
  Plug 'godlygeek/tabular'
  Plug 'jiangmiao/auto-pairs'
  Plug 'svermeulen/vim-cutlass'
  Plug 'svermeulen/vim-subversive'
  Plug 'svermeulen/vim-yoink'
  Plug 'farmergreg/vim-lastplace'
call plug#end()
syntax off

" NERDTree plugin

" Automatically close tree after file is opened from it
let NERDTreeQuitOnOpen=1
"autocmd BufReadPre,FileReadPre * :NERDTreeClose

" Sort files with numbers naturally
let NERDTreeNaturalSort=1

" Show hidden files by default
let NERDTreeShowHidden=1

" Minimal UI, do not show bookmarks and help blocks
let NERDTreeMinimalUI=1

" Increase tree explorer split a bit (default is 31)
let NERDTreeWinSize=35

" Automatically delete buffer when file is deleted from the tree explorer
let NERDTreeAutoDeleteBuffer=1

" Toggle tree visibility
noremap <F2> :NERDTreeToggle<CR>

" Locate current file in a tree
noremap  <S-F2> :NERDTreeFind<CR>
inoremap <S-F2> <esc>:NERDTreeFind<CR>

augroup nerd_tree
  au!

  " Auto launch tree when vim is run with directory as argument
  autocmd StdinReadPre * let s:std_in=1
  autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

  " Exit vim when the only buffer remaining is NerdTree
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

  " Use arrow keys to navigate
  autocmd FileType nerdtree nmap <buffer> l o
  autocmd FileType nerdtree nmap <buffer> L O
  autocmd FileType nerdtree nmap <buffer> h p
  autocmd FileType nerdtree nmap <buffer> H P
augroup END

" Preview in splits without 'g...' prefix
let g:NERDTreeMapPreviewSplit="I"
let g:NERDTreeMapPreviewVSplit="S"
let g:NERDTreeMapToggleHidden="D"

let g:NERDTreeMapPreview="O"

" Do not show '.git' and 'node_modules' directories
let NERDTreeIgnore=['\~$', '^\.git$[[dir]]', '^node_modules$[[dir]]']

" Tweak status line, so it shortens path if it's under HOME directory
let g:NERDTreeStatusline="%{exists('b:NERDTree')? fnamemodify(b:NERDTree.root.path.str(), ':p:~') :''}"

" Auto-save and swap files
let g:auto_save_events=["CursorHold"]
let g:auto_save_silent = 1

" By default auto save is off
let g:auto_save=0
set hidden
set noautowrite

" In addition to autosaving, enable swap file and disable backup
set swapfile
set nobackup
set undofile

" Directories for backup, undo and swap files
set undodir=~/.vim/tmp/undo//
set backupdir=~/.vim/tmp/backup//
set directory=~/.vim/tmp/swap//

" Make those folders automatically if they don't already exist.
if !isdirectory(expand(&undodir))
  call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&backupdir))
  call mkdir(expand(&backupdir), "p")
endif
if !isdirectory(expand(&directory))
  call mkdir(expand(&directory), "p")
endif

" Automatically read files which are changed outside vim
set autoread

nnoremap <F3> :call ToggleAutoSave()<CR>
function ToggleAutoSave()
  AutoSaveToggle
  set autowrite!
  set hidden!
endfunction


" Load the version of matchit.vim that ships with Vim
runtime macros/matchit.vim

" Color scheme
set background=dark

if &t_Co >= 256 || has("gui_running")
  "let g:dracula_italic=0
  let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"

  if (has("termguicolors"))
    set termguicolors
  endif

  colorscheme dracula

endif

if &t_Co > 2 || has("gui_running")
  syntax on
endif


" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" FZF. Fuzzy Find
let g:fzf_layout = { 'down': '~40%' }
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }

" fzf.vim plugin

" Add namespace for fzf.vim exported commands
let g:fzf_command_prefix = 'Fzf'

" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

" File path completion in Insert mode using fzf
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-line)
" imap <c-x><c-j> <plug>(fzf-complete-file-ag)

" Open directory explorer at cwd
nmap <silent> <leader>O :edit .<CR>

nnoremap <silent> <expr> <leader>o (expand('%') =~ 'NERD_tree' ? "\<C-w>\<C-w>" : '').":FzfFiles\<CR>"
cnoremap <silent> <C-p>  :FzfHistory:<CR>
nnoremap <silent> <leader>p  :FzfBuffers<CR>
nnoremap <silent> <leader>`  :FzfMarks<CR>
nnoremap <silent> <F1>  :FzfHelptags<CR>
noremap <silent> <leader>; :FzfCommands<CR>
nnoremap <silent> <C-_> :FzfHistory/<CR>

" Search files containing word under the cursor or selection using 'rg'
nnoremap <silent> <leader>F :FzfRg <C-r><C-w><CR>
xnoremap <silent> <leader>F y:FzfRg <C-R>"<CR>

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'


" Insert blank line below and above
function! s:BlankUp(count) abort
  put!=repeat(nr2char(10), a:count)
  ']+1
  silent! call repeat#set("\<Plug>blankUp", a:count)
endfunction

function! s:BlankDown(count) abort
  put =repeat(nr2char(10), a:count)
  '[-1
  silent! call repeat#set("\<Plug>blankDown", a:count)
endfunction

nnoremap <silent> <Plug>blankUp   :<C-U>call <SID>BlankUp(v:count1)<CR>
nnoremap <silent> <Plug>blankDown :<C-U>call <SID>BlankDown(v:count1)<CR>
nmap [<Space> <Plug>blankUp
nmap ]<Space> <Plug>blankDown

" Can't live without it
nnoremap <CR> o<ESC>


" vim-figutive
augroup vim_figutive
  au!

  " Move one level up when browsing tree or blob
  autocmd User fugitive
    \ if get(b:, 'fugitive_type', '') =~# '^\%(tree\|blob\)$' |
    \   nnoremap <buffer> .. :edit %:h<CR> |
    \ endif

  " Delete fugitive buffers automatically on leave
  autocmd BufReadPost fugitive://* set bufhidden=delete
augroup END

nnoremap <silent> <leader>gs :G<CR>
nnoremap <silent> <leader>ge :Gedit<CR>
nnoremap <silent> <leader>gu :Git checkout HEAD -- %:p<CR>
nnoremap <silent> <leader>gc :Gcommit -v<CR>
nnoremap <silent> <leader>gd :Gdiff<CR>
nnoremap <silent> <leader>gD :Gdiff HEAD<CR>
nnoremap <silent> <leader>gla :FzfCommits<CR>
nnoremap <silent> <leader>glf :FzfBCommits<CR>
nnoremap <silent> <leader>glF :silent! Glog -- %<CR><C-l>
nnoremap <silent> <leader>gls :silent! Glog<CR><C-l>
nnoremap <silent> <leader>go :Git checkout<Space>
nnoremap <silent> <leader>gb :Gblame<CR>
cnoreabbrev gd Gdiff
cnoreabbrev gc Gcommit -v
cnoreabbrev ge Gedit
cnoreabbrev gl Glog
cnoreabbrev gr Ggrep
cnoreabbrev go Git<Space>checkout


" vim-gitgutter
set updatetime=1000

let g:gitgutter_terminal_reports_focus=0
let g:gitgutter_enabled = 1

nnoremap <silent> <F4> :GitGutterToggle<CR>
nnoremap <silent> <leader><F4> :GitGutterFold<CR>
nmap <leader>hp <Plug>GitGutterPreviewHunk
nmap <leader>hs <Plug>GitGutterStageHunk
nmap <leader>hu <Plug>GitGutterUndoHunk

" vim-smooth-scroll
noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 20, 2)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 20, 2)<CR>
noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 20, 4)<CR>
noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 20, 4)<CR>

" vim-commentary
augroup commentary
  au!
  au FileType vim setlocal commentstring=\"\ %s
augroup end

cnoreabbrev cm Commetary

nmap <silent> <leader>c <Plug>CommentaryLine :normal j<CR>
xmap <leader>c <Plug>Commentary

" Search settings

" Case sensitivity
set ignorecase
set smartcase

set nohlsearch
set incsearch
set wrapscan

" Turn on hlsearch  search to highlight all matches during incremental search
" Use <C-j> and <C-k> to navigate through matches instead of <C-d>,<C-t>
" Pitfall: Works only in vim8. CmdlineEnter and CmdlineLeave appeared in vim8
augroup vimrc-incsearch-highlight
  autocmd!
  autocmd CmdlineEnter /,\? :set hlsearch
  autocmd CmdlineEnter /,\? :cmap <C-j> <C-g>
  autocmd CmdlineEnter /,\? :cmap <C-k> <C-t>

  autocmd CmdlineLeave /,\? :set nohlsearch
  autocmd CmdlineLeave /,\? :cunmap <C-j>
  autocmd CmdlineLeave /,\? :cunmap <C-k>
augroup END

" Toggle search highlighting
" Don't use :nohl, because by default searches are not highlighted
nnoremap <silent> <leader>n :set hlsearch!<cr>

" Highlight both search and incremental search identically
" In dracula theme, one is green, whereas another is orange.
hi! link Search IncSearch

" Trailing whitespaces
let g:extra_whitespace_ignored_filetypes=['fugitive']
" In addition to https://github.com/bronson/vim-trailing-whitespace
" Highlight space characters that appear before or in-between tabs
" Use 'autocmd' because ExtraWhitespace highlight group doesn't exist yet
" augroup trailing_whitespace
"   au!

"   autocmd BufRead,BufNew * 2match ExtraWhitespace / \+\ze\t/
" augroup END

" jiangmiao/auto-pairs: Vim plugin, insert or delete brackets, parens, quotes in pair - https://github.com/jiangmiao/auto-pairs
let g:AutoPairsShortcutToggle = '<F7>'

" Disable most bells and whistles
let g:AutoPairsShortcutJump=''
let g:AutoPairsShortcutBackInsert=''
let g:AutoPairsMoveCharacter=''

" I'm using only core closing behavior + fast wrap(maybe?)
let g:AutoPairsShortcutFastWrap='<A-w>'

" Do not autoclose double quote in vimrc.
augroup auto_pairs
  au!

  au FileType vim let b:AutoPairs=copy(g:AutoPairs) | unlet b:AutoPairs['"']
augroup END

" Clipboard

" https://github.com/svermeulen/vim-cutlass
" Use 'X' as cut operation instead
" All other actions, like d, c, s will delete without storing in clipboard
nnoremap x d
nnoremap xx dd
nnoremap X D
xnoremap x d

" " Delete whole line without storing in clipboard
nnoremap <silent> <S-k> :d _<CR>

" " Normalize Y behavior to yank till the end of line
nnoremap Y y$

" " https://github.com/svermeulen/vim-subversive
" " 'Use 's' as 'substitute' action, not as a shortcut to 'change' action
nmap s <plug>(SubversiveSubstitute)
nmap ss <plug>(SubversiveSubstituteLine)
" nmap S <plug>(SubversiveSubstituteToEndOfLine)
xmap s <plug>(SubversiveSubstitute)

" In visual mode, regular 'put' operation actually does a substitution
" By remapping, we can cycle through yank ring provided by 'vim-yoink'
" with <C-p> and <C-n>
xmap p <plug>(SubversiveSubstitute)
xmap P <plug>(SubversiveSubstitute)

" Substitute operation performed multiple times for a given text range
nmap <leader>s <plug>(SubversiveSubstituteRange)
nmap <leader>ss <plug>(SubversiveSubstituteWordRange
xmap <leader>s <plug>(SubversiveSubstituteRange)

let g:subversiveCurrentTextRegister='r'

" https://github.com/svermeulen/vim-yoink{{{
let g:yoinkMoveCursorToEndOfPaste=1

" Replace the need for 'vim-pasta' plugin
let g:yoinkAutoFormatPaste=1

" For integration with 'svermeulen/cutclass'
let g:yoinkIncludeDeleteOperations=1

" Navigation through yank ring
nmap <C-p> <plug>(YoinkPostPasteSwapBack)
nmap <C-n> <plug>(YoinkPostPasteSwapForward)

nmap p <plug>(YoinkPaste_p)
nmap P <plug>(YoinkPaste_P)
" }}}


" Folding ---------------------------------------------------------{{{

set foldenable
set foldmethod=marker
set foldlevelstart=0
set foldcolumn=1
set foldopen-=block

" Remap [z and ]z to navigate to prev/next closed fold
" Use zj and zk to navigate to neighbooring folds
" https://stackoverflow.com/questions/9403098/is-it-possible-to-jump-to-closed-folds-in-vim
nnoremap <silent> ]z :call <SID>NextClosedFold('j')<CR>
nnoremap <silent> [z :call <SID>NextClosedFold('k')<CR>

function! s:NextClosedFold(dir)
  let cmd = 'norm!z' . a:dir
  let view = winsaveview()
  let [l0, l, open] = [0, view.lnum, 1]
  while l != l0 && open
    exe cmd
    let [l0, l] = [l, line('.')]
    let open = foldclosed(l) < 0
  endwhile
  if open
    call winrestview(view)
  endif
endfunction

" Remap because 'za' is highly inconvenient to type
nnoremap zp za

" Close all folds except the one under the cursor, and center the screen
nnoremap <leader>z zMzvzz

augroup ft_vim
  au!
  au FileType vim setlocal foldmethod=marker
augroup END

" }}}



" Windows,buffers,tabs  {{{

" Ask before unsafe actions
set confirm

" Navigate buffers
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [b :bprev<CR>
nnoremap gb :ls<CR>:b<Space>

" Kill buffer
nnoremap <silent> <leader>k :bd!<CR>

" Navigate between windows
noremap <silent> <C-k> :wincmd k<CR>
noremap <silent> <C-j> :wincmd j<CR>
noremap <silent> <C-h> :wincmd h<CR>
noremap <silent> <C-l> :wincmd l<CR>

" Resize windows
" TODO: fix terminal escape sequences
" nnoremap <silent> <M-right> :vertical resize +3<CR>
" nnoremap <silent> <M-left> :vertical resize -3<CR>
" nnoremap <silent> <M-up> :resize +3<CR>
" nnoremap <silent> <M-down> :resize -3<CR>

" Tab navigation
nnoremap <silent> <leader>1 :tabnext 1<CR>
nnoremap <silent> <leader>2 :tabnext 2<CR>
nnoremap <silent> <leader>3 :tabnext 3<CR>
nnoremap <silent> <leader>4 :tabnext 4<CR>
nnoremap <silent> <leader>5 :tabnext 5<CR>
nnoremap <silent> <leader>9 :tablast<CR>

nnoremap <silent> <bslash>+ :tabnew<CR>:edit .<CR>
nnoremap <silent> <bslash>0 :tabonly<CR>
nnoremap <silent> <bslash>- :tabclose<CR>
nnoremap <silent> <bslash>] :tabnext<CR>
nnoremap <silent> <bslash>[ :tabprev<CR>

" Maximize window size
nnoremap <silent> <leader>+ <C-w>_<C-w>\|
nnoremap <silent> <leader>= <C-w>=
nnoremap <silent> <leader>0 :only<CR>

" Open splits right and below
set splitbelow
set splitright
nnoremap <silent> _ :split<CR>
nnoremap <silent> \| :vsplit<CR>

" Save and quit for single buffer
nnoremap <silent> <leader>w :update!<CR>
nnoremap <silent> <leader>q :confirm q<CR>
" Use ZZ to save file and quit (aka :x)

" Save and quit for multiple buffers
nnoremap <silent> <leader>W :wall<CR>
nnoremap <silent> <leader>Q :confirm qall<CR>
nnoremap <silent> <leader>X :confirm xall<CR>

" Cycle between main and alternate file
nnoremap <leader><Tab> <C-^>zz

" Cycle through current and previous splits
nnoremap <S-Tab> <C-w>p

" }}}

" Performance optimizations{{{
" Indicate we have a fast terminal connection. Improves smooth redrawing
set ttyfast

" Investigate performance lags when scrolling. Disable highlighting matching parentheses
let g:loaded_matchparen=1

" Use old regex engine. It's said that it speeds up matching syntax elements
" https://github.com/vim/vim/issues/2712
" Vim 7.4 has introduced a weaker regex engine and setting this option will revert it to older
set regexpengine=1

" After given time, Vim will stop hihglighting further matches
" Syntax highlighting vs performance trade-off
set redrawtime=200

" Delay screen redraw for macros, uncompleted commands
" Redraw as fewer as possible
set lazyredraw

" Indicate we have a fast terminal connection. Improves smooth redrawing
set ttyfast

" Don't try to highlight lines longer than N characters.
set synmaxcol=200

" In some versions of vim it was reported that cursorline cause lags with scrolling
" set nocursorline
" }}}

" Diffs{{{
" Open diffs in vertical splits
set diffopt+=vertical

" Toggle diff mode
nnoremap <F8> :diffoff!<cr>" }}}


" Check if files are changed outside and prompt to reload
noremap <F5> :checktime<cr>
inoremap <F5> <esc>:checktime<cr>

" Keep the cursor in place while joining lines
nnoremap J mzJ`z

" In addition to substitute commands
nnoremap <C-s> :%s/
vnoremap <C-s> :s/

" Split line (experimental)
nnoremap S i<cr><esc>^mwgk:silent! s/\v +$//<cr>:noh<cr>`w

" Experimental. Allow cursor to move one character after the end of line
" In visual block mode, allow cursor to be positioned
" where there's no actual character
set virtualedit+=onemore,block

" Recenter when jump back
nnoremap <C-o> <C-o>zz

" z+, moves next line below the window
" z-, moves next line above the window
nnoremap z- z^


" Session management{{{
set sessionoptions-=folds
set sessionoptions-=options
set sessionoptions-=help
set sessionoptions-=blank

function! s:GetSessionDir()
  return $HOME . "/.vim/sessions" . getcwd()
endfunction

" Session is created manually
" Session is bound to project cwd
function! s:SessionCreate()
  let l:sessiondir = s:GetSessionDir()
  if !isdirectory(l:sessiondir)
    call mkdir(l:sessiondir, "p")
  endif
  exe "Obsession " . s:GetSessionDir()
endfunction

" Loads a session if it exists, and if not already within a session
function! s:SessionLoad()
  let l:sessionfile = s:GetSessionDir() . '/Session.vim'
  if filereadable(l:sessionfile) && ObsessionStatus() != '[$]'
    silent! %bdelete
    exe 'source ' . l:sessionfile
  else
    echo "No session loaded."
  endif
endfunction

" Unload current session, stop tracking.
" Do not remove underlying session file, so you can load session back later
function! s:SessionUnload()
  if ObsessionStatus() == '[$]'
    exe "Obsession"
    silent! %bdelete
  else
    echo "No session loaded."
  endif
endfunction

" Automatically try loading session for current directory,
" unless arguments are passed to vim and input is not read from stdin
augroup load_session_on_startup
  au!

  autocmd StdinReadPre * let g:__is_stdin = 1
  autocmd VimEnter * nested if argc() == 0 && !exists("g:__is_stdin")
    \ | call <SID>SessionLoad()
    \ | endif
augroup END

" Expose set of commands to manage sessions
command! -nargs=? SessionCreate call <SID>SessionCreate(<f-args>)
command! -nargs=? SessionLoad call <SID>SessionLoad(<f-args>)
command! -nargs=? SessionUnload call <SID>SessionUnload(<f-args>)" }}}

" Output the current syntax group
nnoremap <f10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
      \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
      \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<cr>

" File types{{{
augroup ft_gitcommit
  au!

  " Highlight summary line when exceeds 72 columns, not 50 as a default
  au FileType gitcommit syn clear gitcommitSummary
  au FileType gitcommit syn match gitcommitSummary "^.\{0,72\}" contained containedin=gitcommitFirstLine nextgroup=gitcommitOverflow contains=@Spell
augroup END
" }}}

" Plugin: Airline {{{

let g:airline_theme='jellybeans'

" Do not use powerline arrows, it looks not serious
let g:airline_powerline_fonts = 0

" Do not use default status line
set noshowmode

let g:airline_skip_empty_sections = 1

" Disable some icons in lune number section to reduce length
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.linenr=''
let g:airline_symbols.maxlinenr=''

" airline 'obsession' extension does not work for some reason
" Add indicator manually as described in wiki
" https://github.com/vim-airline/vim-airline/wiki/Configuration-Examples-and-Snippets#integration-with-vim-obsession
let g:airline#extensions#obsession#enabled=0
let g:airline_section_z = airline#section#create(['%{ObsessionStatus(''$'', '''')}', 'windowswap', '%3p%% ', 'linenr', ':%3v'])

" Do not show default encoding. Show only when does not match given string
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'

"Tabline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline#extensions#tabline#tab_min_count = 2

" Disable fancy powerline arrows
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#right_sep = ''
let g:airline#extensions#tabline#right_alt_sep = '|'

" Buffers (for now disable, Tabline makes sense only for tabs IMO)
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#buffer_min_count = 2
let g:airline#extensions#tabline#buffers_label = 'bufs'
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#fnamemod = ':p:~:.'
let g:airline#extensions#tabline#fnamecollapse = 1

" }}}
