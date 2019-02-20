" General options{{{

" Should be first, use vim settings rather than vi settings
set nocompatible
filetype plugin indent on

set nospell

" Ask before unsafe actions
set confirm

set shell=/bin/bash
set encoding=utf-8
set number

" Whitespaces and tabs
set tabstop=2 softtabstop=2 shiftwidth=2 expandtab
set smarttab

" Timeout settings
" Wait forever until I recall mapping
" Don't wait to much for keycodes send by terminal, so there's no delay on <ESC>
set notimeout
set ttimeout
set timeoutlen=2000
set ttimeoutlen=30

" Zsh like <Tab> completion in Command mode
set wildmenu
set wildmode=full

" Set <leader> key to <Space>
nnoremap <Space> <Nop>
let mapleader=" "

" <Backspace> in Insert mode
set backspace=indent,eol,start

" Keep some characters visible during horizontal scroll
" Recenter cursor during horizontal scroll
set sidescroll=0
set sidescrolloff=3

" Minimal number of screen lines to keep above and below the cursor, expect for bol and eol
set scrolloff=2

" Status line
" Always show status line, even when 1 window is opened
set laststatus=2

" Do not warn abount unsaved changes when navigating to another buffer
set hidden

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

" Timeout of user inactivity. Used to save swap file, and by vim-gitgutter plugin
set updatetime=1000

" Experimental. Allow cursor to move one character after the end of line
" In visual block mode, allow cursor to be positioned
" where there's no actual character
set virtualedit+=onemore,block

" Auto indentation
set autoindent
set smartindent
set pastetoggle=<F2>

" Experimental
set shiftround

" Disable startup message
set shortmess+=I

" Additional <ESC> mappings:
" jk, in INSERT mode
" <C-c>, I'm so used to it after shell environment
inoremap jk <ESC>
noremap <C-C> <ESC>

" key bindings - How to map Alt key? - Vi and Vim Stack Exchange - https://vi.stackexchange.com/questions/2350/how-to-map-alt-key
if &term =~ 'xterm' && !has("gui_running")
  " Tell vim what escape sequence to expect for various keychords
  " This is needed for terminal Vim to regognize Meta and Shift modifiers
  execute "set <A-w>=\ew"
  execute "set <S-F2>=\e[1;2Q"
  execute "set <A-k>=\ek"
  execute "set <A-j>=\ej"
endif
" }}}


" Plugins{{{
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
  Plug 'rhysd/clever-f.vim'

  " Text objects
  Plug 'kana/vim-textobj-user'
  Plug 'kana/vim-textobj-entire'
  Plug 'kana/vim-textobj-indent'
  Plug 'kana/vim-textobj-line'
  Plug 'kana/vim-textobj-function'
  Plug 'kana/vim-textobj-fold'
  Plug 'beloglazov/vim-textobj-quotes'
  Plug 'kana/vim-textobj-syntax'
  Plug 'jceb/vim-textobj-uri'
  Plug 'Julian/vim-textobj-variable-segment'
  Plug 'Julian/vim-textobj-brace'
  Plug 'adriaanzon/vim-textobj-matchit'
call plug#end()
syntax off

" Load the version of matchit.vim that ships with Vim
runtime macros/matchit.vim
" }}}

" Color scheme{{{
set background=dark
colorscheme dracula

" Enable true color support
if &t_Co >= 256 || has("gui_running")
  "let g:dracula_italic=0
  let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"

  if (has("termguicolors"))
    set termguicolors
  endif
endif

if &t_Co > 2 || has("gui_running")
  syntax on
endif
" }}}

" Line manipulation{{{

" Insert blank line below and above without changing cursor
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
" Not used in favor of <leader><CR> and <CR>
" nmap [<Space> <Plug>blankUp
" nmap ]<Space> <Plug>blankDown


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


" Duplicate lines
vnoremap <silent> <leader>D :copy '><CR>gv
nnoremap <silent> <leader>D :<C-u>execute "normal! yy" . v:count1 . "p"<CR>

" Join lines and keep the cursor in place
nnoremap J mzJ`z

" Split line (experimental)
nnoremap S i<cr><esc>^mwgk:silent! s/\v +$//<cr>:noh<cr>`w

" Delete whole line without storing in clipboard
nnoremap <silent> <S-k> :d _<CR>

" Add blank line above and below
" When adding line below, move cursor to the just added line (most likely you're going to edit next)
" When adding line above, don't move cursor at all
nnoremap <CR> o<ESC>
nmap <leader><CR> <Plug>blankUp

" }}}

" Wrapping{{{

" Soft wraps by default
set wrap
set breakindent

" Don't do hard wraps ever
set textwidth=0

" Show invisible characters
set list
set listchars=tab:→\ ,space:⋅,extends:>,precedes:<
set showbreak=↪
set linebreak

" Let movements work with display lines instead of real lines
noremap  <silent> <expr> k v:count ? 'k' : 'gk'
noremap  <silent> <expr> j v:count ? 'j' : 'gj'
noremap  <silent> 0 g0
noremap  <silent> $ g$

" Toggle between 'nowrap' and 'soft wrap'
noremap <silent> <F6> :set wrap!<CR>

" Format options
" Remove most related to hard wrapping
" Use autocommand to override defaults from $VIMRUNTIME/ftplugin
augroup format_options
  au!

  au Filetype * setlocal formatoptions=rqn1j
augroup END

" }}}

" Search {{{

" Case sensitivity
set ignorecase
set smartcase

" Do not highlight search results by default
" Enable incremental searching
" Stop when reaching last match, don't start over
set nohlsearch
set incsearch
set nowrapscan

" Turn on hlsearch to highlight all matches during incremental search
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

" Center search results
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz

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

" Shortcuts for substitute as ex command
nnoremap <C-s> :%s/
vnoremap <C-s> :s/

" }}}

" Navigation{{{

" TODO: add shortcuts to navigate tags
" TODO: add shortcuts to navigate conflict markers/diff hunks

" When navigating to the EOF, center the screen
nnoremap G Gzz

" Use 'H' and 'L' keys to move to start/end of the line
noremap H g^
noremap L g$

" Recenter when jump back
nnoremap <C-o> <C-o>zz

" z+, moves next line below the window
" z-, moves next line above the window
nnoremap z- z^

" Quickfix and location list navigation
" Borrowed from tpope/vim-unimpaired
" Pitfall: In order to use <C-q>, <C-s> shortcuts to navigate quick list
" make sure to sisable XON/XOFF flow control with 'stty -ixon'
nnoremap <silent> ]q :cnext<CR>
nnoremap <silent> [q :cprev<CR>
nnoremap <silent> ]Q :clast<CR>
nnoremap <silent> [Q :cfirst<CR>
nnoremap <silent> ]<C-q> :cnfile<CR>
nnoremap <silent> [<C-q> :cpfile<CR>

nnoremap <silent> ]l :lnext<CR>
nnoremap <silent> [l :lprev<CR>
nnoremap <silent> ]L :llast<CR>
nnoremap <silent> [L :lfirst<CR>
nnoremap <silent> ]<C-l> :lnfile<CR>
nnoremap <silent> [<C-l> :lpfile<CR>

" TODO: toggle quickfix and location list
" Automatically open quickfix window
"augroup autoquickfix
"  autocmd!
"  autocmd QuickFixCmdPost [^l]* cwindow
"  autocmd QuickFixCmdPost    l* lwindow
"augroup END
" }}}

" Insert mode{{{

" Drop into insert mode on Backspace
nnoremap <BS> i<BS>

" In Insert mode, treat pasting form a buffer as a separate undoable operation
" Which can be undone with '<C-o>u'
inoremap <C-r> <C-g>u<C-r>
" }}}

" Clipboard{{{

" Using these plugins:board
" - https://github.com/svermeulen/vim-cutlass
" - https://github.com/svermeulen/vim-subversive
" - https://github.com/svermeulen/vim-yoink

" always use system clipboard as unnamed register
set clipboard=unnamed,unnamedplus

" Reselect just pasted text
nnoremap gV v`[

" Use '<leader>x' as cut operation instead
" All other actions, like d, c, s will delete without storing in clipboard
nnoremap <leader>x d
nnoremap <leader>xx dd
nnoremap <leader>X D
xnoremap x d

" Normalize Y behavior to yank till the end of line
nnoremap Y y$

" 'Use 's' as 'substitute' action, not as a shortcut to 'change' action
nmap s <plug>(SubversiveSubstitute)
nmap ss <plug>(SubversiveSubstituteLine)
" Don't remap S as exception, use it to split lines (counterpart to join lines)
" nmap S <plug>(SubversiveSubstituteToEndOfLine)
xmap s <plug>(SubversiveSubstitute)

" In visual mode, regular 'put' operation actually does a substitution
" After remapping we can cycle through yank ring provided by 'vim-yoink' with <C-p> and <C-n>
xmap p <plug>(SubversiveSubstitute)
xmap P <plug>(SubversiveSubstitute)

" Substitute operation performed multiple times for a given text range
nmap <leader>s <plug>(SubversiveSubstituteRange)
nmap <leader>ss <plug>(SubversiveSubstituteWordRange
xmap <leader>s <plug>(SubversiveSubstituteRange)

" Store text that being substituted in register 'r'
let g:subversiveCurrentTextRegister='r'

" Normally cursor remains in place during paste
" Move it to the end, so it's easy to start editing
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

" Use [z and ]z to navigate to start/end of the fold
" Use zj and zk to navigate to neighbooring folds
" Use zJ and zK to navigate to prev/next closed fold
" https://stackoverflow.com/questions/9403098/is-it-possible-to-jump-to-closed-folds-in-vim
nnoremap <silent> zJ :call <SID>NextClosedFold('j')<CR>
nnoremap <silent> zK :call <SID>NextClosedFold('k')<CR>

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
nnoremap <leader><Space> za

" Close all folds except the one under the cursor, and center the screen
nnoremap <leader>z zMzvzz

augroup ft_vim
  au!
  au FileType vim setlocal foldmethod=marker
augroup END

" }}}

" Windows,buffers,tabs  {{{

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
" Try these mappings, if | and _ are not OK
" nnoremap <silent> <leader>s :split<CR>
" nnoremap <silent> <leader>v :vsplit<CR>
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
nnoremap <silent> ZX :confirm xall<CR>

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
nnoremap <F8> :diffoff!<cr>

" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" }}}

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

" Save and backup{{{

" Features defaults:
" - autosave: off
" - backup: off
" - undofile: on
" - swapfile: on

" Regarding autosaving:
" - "autowrite" saves file on buffer change and quit
" - '907th/vim-auto-save' saves filter when cursor is inactive for few seconds

" Let buffer be switched to another one without requiring to save it first
set hidden

" Disable autosave by default
set noautowrite
let g:auto_save=0
let g:auto_save_events=["CursorHold"]
let g:auto_save_silent = 1

" You can toggle to turn auto save off
nnoremap <F3> :call ToggleAutoSave()<CR>
function ToggleAutoSave()
  AutoSaveToggle
  set autowrite!
  set hidden!
endfunction

" Automatically read files which are changed outside vim
set autoread

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

" }}}

" Misc{{{

" Check if files are changed outside and prompt to reload
noremap <F5> :checktime<cr>
inoremap <F5> <esc>:checktime<cr>

" Expand '%%' for directory of current file in command line mode
cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>

" Apply '.' repeat command for selected each line in visual mode
vnoremap . :normal .<CR>

" Output the current syntax group
nnoremap <f10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
      \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
      \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<cr>
" }}}


" PLUGIN: Airline {{{

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

" PLUGIN: NERDTree {{{

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
" }}}

" PLUGIN: fzf.vim{{{

let g:fzf_layout = { 'down': '~40%' }
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }

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
" }}}

" PLUGIN: vim-figutive{{{
augroup vim_figutive
  au!

  " Move one level up with '..' when browsing tree or blob
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
nnoremap <silent> <leader>gc :Gcommit -a -v<CR>
nnoremap <silent> <leader>gd :Gdiff<CR>
nnoremap <silent> <leader>gD :Gdiff HEAD<CR>
nnoremap <silent> <leader>gla :FzfCommits<CR>
nnoremap <silent> <leader>glf :FzfBCommits<CR>
nnoremap <silent> <leader>glF :silent! Glog -- %<CR><C-l>
nnoremap <silent> <leader>gls :silent! Glog<CR><C-l>
nnoremap <silent> <leader>go :Git checkout<Space>
nnoremap <silent> <leader>gb :Gblame<CR>
cnoreabbrev gd Gdiff
cnoreabbrev gc Gcommit -v -a
cnoreabbrev ge Gedit
cnoreabbrev gl Glog
cnoreabbrev gr Ggrep
cnoreabbrev go Git<Space>checkout

" }}}

" PLUGIN: vim-gitgutter{{{

let g:gitgutter_terminal_reports_focus=0
let g:gitgutter_enabled = 1

nnoremap <silent> <F4> :GitGutterToggle<CR>
nnoremap <silent> <leader><F4> :GitGutterFold<CR>

" Use 'h' as a motion for hunks, instead of default 'c'
nmap ]h <Plug>GitGutterNextHunk
nmap [h <Plug>GitGutterPrevHunk
omap ih <Plug>GitGutterTextObjectInnerPending
omap ah <Plug>GitGutterTextObjectOuterPending
xmap ih <Plug>GitGutterTextObjectInnerVisual
xmap ah <Plug>GitGutterTextObjectOuterVisual

" vim-smooth-scroll
noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 20, 2)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 20, 2)<CR>
noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 20, 4)<CR>
noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 20, 4)<CR>
" }}}

" PLUGIN: vim-commentary{{{
augroup commentary
  au!
  au FileType vim setlocal commentstring=\"\ %s
augroup end

cnoreabbrev cm Commetary

nmap <silent> <leader>c <Plug>CommentaryLine :normal j<CR>
xmap <leader>c <Plug>Commentary
" }}}

" PLUGIN: vim-trailing-whitespace{{{

let g:extra_whitespace_ignored_filetypes=['fugitive']

" In addition to https://github.com/bronson/vim-trailing-whitespace
" Highlight space characters that appear before or in-between tabs
" Use 'autocmd' because ExtraWhitespace highlight group doesn't exist yet
" augroup trailing_whitespace
"   au!

"   autocmd BufRead,BufNew * 2match ExtraWhitespace / \+\ze\t/
" augroup END
" }}}

" PLUGIN: jiangmiao/auto-pairs{{{
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
" }}}

" PLUGIN: rhysd/clever-f.vim{{{

" Add highlighting for f/t searches
" Uses f/t to advance to next match instead of using ';' and ','
let g:clever_f_ignore_case = 1
let g:clever_f_smart_case = 1

" Use same highlighting group as a normal search
let g:clever_f_mark_char_color = 'IncSearch'
" }}}

" File types{{{
augroup ft_gitcommit
  au!

  " Highlight summary line when exceeds 72 columns, not 50 as a default
  au FileType gitcommit syn clear gitcommitSummary
  au FileType gitcommit syn match gitcommitSummary "^.\{0,72\}" contained containedin=gitcommitFirstLine nextgroup=gitcommitOverflow contains=@Spell
augroup END

augroup ft_vim
  au!

  " Automatically source vimrc on change
  autocmd BufWritePost vimrc source $MYVIMRC
augroup END

" }}}


