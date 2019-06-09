" General options{{{

" Should be first, use vim settings rather than vi settings
" Enable loading plugins
set nocompatible
filetype plugin indent on

" Ask before unsafe actions
set confirm

" FIXME: use /bin/bash as a shell, until I fix lags with zsh
set shell=/bin/bash
set encoding=utf-8

" Show absolute line numbers in a gutter
set number

" Timeout settings
" Eliminating ESC delays in vim - Metaserv - https://meta-serv.com/article/vim_delay
" Delayed esc from insert mode caused by cursor-shape terminal sequence - Vi and Vim Stack Exchange - https://vi.stackexchange.com/questions/15633/delayed-esc-from-insert-mode-caused-by-cursor-shape-terminal-sequence
" Wait forever until I recall mapping
" Don't wait to much for keycodes send by terminal, so there's no delay on <ESC>
set notimeout
set ttimeout
set timeoutlen=2000
set ttimeoutlen=30

" Zsh like <Tab> completion in command mode
set wildmenu
set wildmode=full
" Files will be ignored when expanding globs.
" set wildignore+=.hg,.git,.svn,*.swp,*.bak,*.pyc,*.class

" Set <leader> key to <Space>
nnoremap <Space> <Nop>
let mapleader=" "
let maplocalleader=","

" Allow Backspace to work over indent, line endings, and start of insert. By default Backspace works only against inserted text
set backspace=indent,eol,start

" Minimal number of screen lines to keep above and below the cursor, expect for bol and eol
" Sets padding to the screen boundaries when scrolling up and down
set scrolloff=2

" Status line
" Always show status line, even when 1 window is opened
set laststatus=2

" Do not warn abount unsaved changes when navigating to another buffer
set hidden

" Highlight the line with a cursor
set cursorline

" Disable cursor line highlighting in Insert mode
augroup aug_cursor_line
  au!
  au InsertEnter * setlocal nocursorline
  au InsertLeave * setlocal cursorline
augroup END

" Disable reading vim variables & options from special comments within file header or footer
set modelines=0

" Display uncompleted keystrokes in the status line
set showcmd

" Use /g flag for substitute command by default
set gdefault

" Tweak autocompletion behavior for <C-n>/<C-p> in insert mode
" Default is ".,w,b,u,t,i" without "i", where:
" . - scan current buffer. Same to invoking <C-x><C-n> individually
" w - buffers in other windows
" b - loaded buffers in buffer list
" u - unloaded buffers in buffer list
" t - tags. Same to invoking <C-x><C-]> individually
" i - included files. We don't need this.
" kspell, when spell check is active, use words from spellfiles
set complete-=i
set complete+=kspell

" Do not insert first sugggestion
set completeopt=menu,preview,noinsert

" Add @@@ marks on the last column of last line if there is more text below
set display=lastline

" Timeout of user inactivity. Used to save swap file, and by vim-gitgutter plugin
set updatetime=1000

" Experimental. Allow cursor to move one character after the end of line
" In visual block mode, allow cursor to be positioned
" where there's no actual character
set virtualedit+=onemore,block

" Auto indentation
" Preserve the same level of indentation each time we create a new line in Insert mode.
" Also, do smart autoindenting when starting a new line.
set autoindent
set smartindent
" When pasting from clipboard, Vim acts as though each character has been typed by hand.
" "set paste" option turns off Insert mode mappings and autoindentation, so text is pasted verbatim, and is not reindented. No formatting is done
set pastetoggle=<F12>

" Experimental. Round indent to multiple of 'shiftwidth'.
set shiftround

" Disable startup message
set shortmess+=I

" Conceal text and highlight with "Conceal" highlight group
set conceallevel=2

" Additional <ESC> mappings:
" jk, in INSERT mode
" <C-c>, I'm so used to it after shell environment
inoremap jk <ESC>
noremap <C-C> <ESC>
xnoremap <C-C> <ESC>

" Do not use arrows in Normal mode
noremap <silent> <Up>    <Nop>
noremap <silent> <Down>  <Nop>
noremap <silent> <Left>  <Nop>
noremap <silent> <Right> <Nop>

" key bindings - How to map Alt key? - Vi and Vim Stack Exchange - https://vi.stackexchange.com/questions/2350/how-to-map-alt-key
if &term =~ 'xterm' && !has("gui_running")
  " Tell vim what escape sequence to expect for various keychords
  " This is needed for terminal Vim to regognize Meta and Shift modifiers
  execute "set <A-w>=\ew"
  execute "set <S-F2>=\e[1;2Q"
  execute "set <A-k>=\ek"
  execute "set <A-j>=\ej"
  execute "set <A-,>=\e,"

  " I've failed to map <Home> and <End> keys when vim runs inside tmux
  " Although <Home> and <End> move cursor, Vim does not recognize them as <Home>/<End> in mappings
  " The root cause is that tmux reports itself as "xterm-256color", which is wrong,
  " And Vim expects \EOH and \EOF sequences for Home and End keys, whereas \E[1~ and \E[4~ are actually send
  " The right solution is make tmux to report itself as "screen-256color" or "tmux-256color"
  " But it brokes truecolor highlighting
  " TODO: fix tmux wrong $TERM type
  " set t_kh=[1~
  " set <Home>=[1~

  " NOTE: not portable solution, but I need <S-CR> so much
  " I configured iTerm to send '[13;2u' escape sequence for <S-CR>, so I can map it in Vim
  nmap [13;2u <S-CR>
  imap [13;2u <S-CR>
  nnoremap <silent> <S-CR> :call <SID>Noop()<CR>
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
  Plug 'junegunn/gv.vim'
  Plug 'tpope/vim-repeat'
  Plug 'airblade/vim-gitgutter'
  Plug 'tpope/vim-surround'
  Plug 'terryma/vim-smooth-scroll'
  Plug 'tpope/vim-commentary'
  Plug 'bronson/vim-trailing-whitespace'
  Plug 'junegunn/vim-easy-align'
  Plug 'svermeulen/vim-cutlass'
  Plug 'svermeulen/vim-subversive'
  Plug 'svermeulen/vim-yoink'
  Plug 'samoshkin/vim-lastplace'
  Plug 'rhysd/clever-f.vim'
  Plug 'ryanoasis/vim-devicons'
  " Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
  Plug 'vim-scripts/CursorLineCurrentWindow'
  Plug 'majutsushi/tagbar'
  Plug 'ludovicchabant/vim-gutentags'
  Plug 'Raimondi/delimitMate'
  Plug 'vim-scripts/SyntaxAttr.vim'
  Plug 'SirVer/ultisnips'
  Plug 'honza/vim-snippets'
  Plug 'mattn/emmet-vim'
  Plug 'editorconfig/editorconfig-vim'
  Plug 'alvan/vim-closetag'
  Plug 'samoshkin/vim-mergetool'
  Plug 'romainl/vim-qf'
  Plug 'dyng/ctrlsf.vim'
  Plug 'samoshkin/vim-find-files'
  Plug 'RRethy/vim-hexokinase'
  Plug 'sheerun/vim-polyglot'
  Plug 'w0rp/ale'
  Plug 'mattn/gist-vim'
  Plug 'mattn/webapi-vim'

  " Markdown
  Plug 'suan/vim-instant-markdown'
  Plug 'junegunn/goyo.vim'
  Plug 'junegunn/limelight.vim'
  Plug 'plasticboy/vim-markdown'

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
  set guifont=DroidSansMono\ Nerd\ Font\ Mono:h14
endif

" Borrowed from https://github.com/tiagofumo/vim-nerdtree-syntax-highlight
" Fits well for dark schemes
let g:colors = {
      \ 'brown': ["#905532", 95],
      \ 'aqua': ["#3AFFDB", 86],
      \ 'blue': ["#689FB6", 73],
      \ 'darkBlue': ["#44788E", 66],
      \ 'purple': ["#834F79", 93],
      \ 'red': ["#AE403F", 131],
      \ 'darkRed': ["#97050C", 88],
      \ 'beige': ["#F5C06F", 215],
      \ 'yellow': ["#F09F17", 214],
      \ 'orange': ["#D4843E", 172],
      \ 'orange2': ["#DD5E1C", 166],
      \ 'darkOrange': ["#F16529", 202],
      \ 'pink': ["#CB6F6F", 167],
      \ 'lightGreen': ["#8FAA54", 107],
      \ 'green': ["#31B53E", 71],
      \ 'white': ["#FFFFFF", 231],
      \}

fun s:PatchDraculaScheme()
  hi! ColorColumn ctermfg=255 ctermbg=203 guifg=#F8F8F2 guibg=#FF5555

  " Show NERDTree directory nodes in yellow
  hi! __DirectoryNode cterm=bold ctermfg=214 gui=bold guifg=#E7A427
  hi! link NerdTreeDir __DirectoryNode
  hi! link NERDTreeFlags __DirectoryNode

  " Show NERDTree toggle icons as white
  hi! link NERDTreeOpenable Normal
  hi! link NERDTreeClosable Normal

  " Do not highlight changed line, highlight only changed text within a line
  hi! DiffText term=NONE ctermfg=215 ctermbg=233 cterm=NONE guifg=#FFB86C guibg=#14141a gui=NONE
  hi! link DiffChange NONE
  hi! clear DiffChange

  " dyng/ctrlsf.vim
  hi! link ctrlsfMatch DraculaOrange
  hi! link ctrlsfCuttingLine Title

  " Use a bit deeper yellow/orange color
  hi! DraculaOrange guifg=#F09F17 ctermfg=214
  hi! DraculaOrangeBold cterm=bold ctermfg=214 gui=bold guifg=#F09F17
  hi! DraculaOrangeBoldItalic cterm=bold,italic ctermfg=214 gui=bold,italic guifg=#F09F17
  hi! DraculaOrangeInverse ctermfg=236 ctermbg=214 guifg=#282A36 guibg=#F09F17
  hi! DraculaOrangeItalic cterm=italic ctermfg=214 gui=italic guifg=#F09F17

  " In Dracula theme, ALEError->DraculaErrorLine, ALEWarning->DraculaWarnLine
  " No need to set ALEStyleError and ALEStyleWarning, as they are linked to ALEError/ALEWarning
  hi! DraculaWarnLine cterm=undercurl ctermfg=214 gui=undercurl guifg=#F09F17 guisp=#F09F17
endf


" Shortcut command to 'vim-scripts/SyntaxAttr.vim'
command ViewSyntaxAttr call SyntaxAttr()

" Customime color scheme after it was loaded
augroup aug_color_scheme
  au!

  autocmd ColorScheme dracula call s:PatchDraculaScheme()
augroup END

" Apply a particular color scheme
" NOTE: Should go after 'autocmd ColorScheme' customization
set background=dark
colorscheme dracula

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

" Add blank line above and below
" When adding line below, move cursor to the just added line (most likely you're going to edit next)
" When adding line above, don't move cursor at all
" Do not override <CR> in quickfix and command line window
nnoremap <expr> <CR> &buftype ==# 'quickfix' \|\| getcmdwintype() != '' ? "\<CR>" : "o\<ESC>"
nmap <leader><CR> <Plug>blankUp

" Move lines up/down
" http://vim.wikia.com/wiki/Moving_lines_up_or_down

" There is a plugin, but it does not worth installing.
" matze/vim-move: Plugin to move lines and selections up and down - https://github.com/matze/vim-move
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


" Duplicate lines or selection
vnoremap <silent> <localleader>d "zy`>"zp
nnoremap <silent> <localleader>d :<C-u>execute 'normal! "zyy' . v:count1 . '"zp'<CR>

" Delete line without storing in clipboard
nnoremap <silent> K :d _<CR>

" Join lines and keep the cursor in place
nnoremap J mzJ`z

" Split line (opposite to join lines)
nnoremap <silent> M :call <SID>split_line()<CR>

function s:split_line()
  " Do a split
  exe "normal! i\<CR>\<ESC>"

  " Remember position and last search expression
  normal! mw
  let _s = @/

  " Remove any trailing whitespace characters from the line above
  silent! -1 s/\v +$//

  " Restore last search expression
  nohlsearch
  let @/ = _s

  " Restore cursor position
  normal! `w

  startinsert
endfunction

" }}}

" Wrapping{{{

" Soft wraps
" Limitation: you cannot have soft wrap at specified line width (textwidth is responsible for hard wraps). The only workaround is to limit the width of the window using "set columns = 80"
set wrap
set breakindent

" Hard wraps
" "textwidth" and "wrapmargin" are not applicable for soft wraps
" Don't do hard wraps ever
set textwidth=0

" No wraps. Long lines will exceed screen boundaries
" set nowrap

" Toggle between 'nowrap' and 'soft wrap'
" TODO: fix mapping
noremap <silent> <F6> :set wrap!<CR>

" Recenter cursor during horizontal scroll
" Keep some characters visible during horizontal scroll
" Makes sense only for nowrap
set sidescroll=0
set sidescrolloff=3

" Show invisible characters
" "extends" and "precedes" is when long lines are not wrapped
set list
set listchars=tab:→\ ,space:⋅,extends:>,precedes:<
set showbreak=↪
set linebreak

" Let movements work with display lines instead of real lines
noremap  <silent> <expr> k v:count ? 'k' : 'gk'
noremap  <silent> <expr> j v:count ? 'j' : 'gj'
noremap  <silent> 0 g0
noremap  <silent> $ g$
" FIXME: <Home> and <End> mapping don't work, until I find the solution with wrong tmux $TERM type
nnoremap <Home> g<Home>
noremap  <End>  g<End>

" TODO: ensure keys are not overridden when pumvisible()
" See https://vim.fandom.com/wiki/Move_cursor_by_display_lines_when_wrapping
inoremap <silent> <Down> <C-o>gj
inoremap <silent> <Up> <C-o>gk
" <Home> and <End> mapping don't work, until I find the solution with wrong tmux $TERM type
inoremap <silent> <Home> <C-o>g<Home>
inoremap <silent> <End>  <C-o>g<End>

" Format options
" Remove most related to hard wrapping
" Use autocommand to override defaults from $VIMRUNTIME/ftplugin
augroup aug_format_options
  au!

  " t - automatic text wrapping, but not comments (for hard wrapping)
  " c - auto wrap comments (for hard wrapping)
  " a - reformat on any change
  " q - allow formatting of comments with "gq"
  " r - insert comment leader after hitting <CR> in Insert mode
  " n - When formatting text, recognize numbered lists and use the indent after the number for the next line
  " 2 - Use indent of the second line of a paragraph for the reset of the paragraph
  " 1 - Don't break line after a one-letter word, it's broken before it.
  " j - Remove a comment leader when joining lines
  " o - automatically insert comment leader after hitting 'o' or 'O' in normal mode
  au Filetype * setlocal formatoptions=rqn1j
augroup END

" }}}

" Trailing whitespaces {{{

" "bronson/vim-trailing-whitespaces" plugin is used for highlighting
" Use :FixWhitespace to remove trailing whitespaces manually
" Or "w0rp/ale" is used to automatically remove trailing whitespaces, extra empty lines at EOF, and more
let g:extra_whitespace_ignored_filetypes = ['fugitive', 'markdown', 'diff', 'qf', 'help', 'ctrlsf']

augroup aug_trailing_whitespaces
  au!

  " Highlight space characters that appear before or in-between tabs
  au BufRead,BufNew * 2match ExtraWhitespace / \+\ze\t/

  " Disable Airline whitespace detection for ignored filetypes
  for wifile in g:extra_whitespace_ignored_filetypes
    exe "au FileType " . wifile . " let b:airline_whitespace_disabled = 1"
  endfor
augroup END

" }}}

" {{{ Tabs vs spaces

" Whitespaces and tabs
" - tabstop, width of a tab chracter
" - expandtab, cause spaces to be used instead of tabs
" - softtabstop, number of spaces inserted by Tab when expandtab is on.
" - shiftwidth, number of spaces to insert/remove for indentation at the BOL (only used for >>)
" Convert tab<->spaces. Change "expandtab" setting and run "retab!" command
set tabstop=2 softtabstop=2 shiftwidth=2 expandtab
set smarttab

" Change between tabs and spaces
" Borrowed from https://vim.fandom.com/wiki/Super_retab
command! -nargs=? -range=% Space2Tab call IndentConvert(<line1>,<line2>,0,<q-args>)
command! -nargs=? -range=% Tab2Space call IndentConvert(<line1>,<line2>,1,<q-args>)
command! -nargs=? -range=% Retab call IndentConvert(<line1>,<line2>,&et,<q-args>)

" Return indent (all whitespace at start of a line), converted from
" tabs to spaces if what = 1, or from spaces to tabs otherwise.
" When converting to tabs, result has no redundant spaces.
function! Indenting(indent, what, cols)
  let spccol = repeat(' ', a:cols)

  " Normalize all spaces which are multiple of "tabstop" to tabs
  let result = substitute(a:indent, spccol, '\t', 'g')

  " Remove spaces less than a "tabstop" mixed among tabs
  let result = substitute(result, ' \+\ze\t', '', 'g')
  let result = substitute(result, '\t\zs \+', '', 'g')

  " Leave tabs or convert to spaces
  if a:what == 1
    let result = substitute(result, '\t', spccol, 'g')
  endif
  return result
endfunction

" Convert whitespace used for indenting (before first non-whitespace).
" what = 0 (convert spaces to tabs), or 1 (convert tabs to spaces).
" cols = string with number of columns per tab, or empty to use 'tabstop'.
" The cursor position is restored, but the cursor will be in a different
" column when the number of characters in the indent of the line is changed.
function! IndentConvert(line1, line2, what, cols)
  let savepos = getpos('.')
  let cols = empty(a:cols) ? &tabstop : a:cols
  execute a:line1 . ',' . a:line2 . 's/^\s\+/\=Indenting(submatch(0), a:what, cols)/e'
  call histdel('search', -1)
  call setpos('.', savepos)
endfunction

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
set wrapscan

" Highlight both search and incremental search identically
" In dracula theme, one is green, whereas another is orange.
hi! link Search IncSearch

" Center search results
nnoremap n nzvzz
nnoremap N Nzvzz
nnoremap * *zvzz
nnoremap # #zvzz

" Individual shortcut to print total search matches count for last search
nnoremap <silent> g/ :call <SID>PrintSearchTotalCount()<CR>

" Toggle search highlighting
" Don't use :nohl, because by default searches are not highlighted
nnoremap <silent> <leader>n :set hlsearch!<cr>

" Detect when search command line is entered and left
" Detect when search is triggered by hooking into <CR>
" Inspired by https://github.com/google/vim-searchindex
augroup aug_search
  autocmd!

  " Pitfall: Works only in vim8. CmdlineEnter and CmdlineLeave appeared in vim8
  autocmd CmdlineEnter /,\? call <SID>on_search_cmdline_focus(1)
  autocmd CmdlineLeave /,\? call <SID>on_search_cmdline_focus(0)

  " Detect when search command window is entered
  autocmd CmdwinEnter *
        \ if getcmdwintype() =~ '[/?]' |
        \   silent! nmap <buffer> <CR> <CR><Plug>OnSearchCompleted|
        \ endif
augroup END

function! s:on_search_cmdline_focus(enter)
  if a:enter
    " Turn on hlsearch to highlight all matches during incremental search
    set hlsearch

    " Use <C-j> and <C-k> to navigate through matches during incremental search instead of <C-d>,<C-t>
    cmap <C-j> <C-g>
    cmap <C-k> <C-t>

    " Detect when search is triggered by hooking into <CR>
    cmap <expr> <CR> "\<CR>" . (getcmdtype() =~ '[/?]' ? "<Plug>OnSearchCompleted" : "")
  else
    " On cmdline leave, rollback all changes and mappings
    set nohlsearch

    cunmap <C-j>
    cunmap <C-k>
    cunmap <CR>
  endif
endfunction

" Define OnSearchCompleted hook
noremap  <Plug>OnSearchCompleted <Nop>
nnoremap <silent> <Plug>OnSearchCompleted :call <SID>OnSearchCompleted()<CR>

function s:OnSearchCompleted()
  " Print total search matches count
  call s:PrintSearchTotalCount()

  " Open folds in the matches lines
  " foldopen+=search causes search commands to open folds in the matched line
  " - but it doesn't work in mappings. Hence, we just open the folds here.
  if &foldopen =~# "search"
    normal! zv
  endif

  " Recenter screen for any kind of search (same as we do for n/N shortcuts)
  normal! zz
endfunction

function s:PrintSearchTotalCount()
  " Detect search direction
  let search_dir = v:searchforward ? '/' : '?'

  " Remember cursor position
  let pos=getpos('.')

  " Remember start and end marks of last change/yank
  let saved_marks = [ getpos("'["), getpos("']") ]

  try
    " Execute "%s///gn" command to capture match count for the last search pattern
    let output = ''
    redir => output
      silent! keepjumps %s///gne
    redir END

    " Extract only match count from string like "X matches on Y lines"
    let match_count = str2nr(matchstr(output, '\d\+'))

    " Compose message like "X matches for /pattern"
    let msg = l:match_count . " matches for " . l:search_dir . @/

    " Flush any delayed screen updates before printing "l:msg".
    " See ":h :echo-redraw".
    redraw | echo l:msg
  finally

    " Restore [ and ] marks
    call setpos("'[", saved_marks[0])
    call setpos("']", saved_marks[1])

    " Restore cursor position
    call setpos('.', pos)
  endtry
endfunction

" Make '*' and '#' search for a selection in visual mode
" Inspired by https://github.com/nelstrom/vim-visual-star-search
" Got Ravings?: Vim pr0n: Visual search mappings - http://got-ravings.blogspot.com/2008/07/vim-pr0n-visual-search-mappings.html
vnoremap * :<C-u>call <SID>search_from_context("/", "selection")<CR>
vnoremap # :<C-u>call <SID>search_from_context("?", "selection")<CR>

function! s:search_from_context(direction, context)
  let text = a:context ==# 'word' ? expand("<cword>") : s:get_selected_text()
  let text = substitute(escape(text, a:direction . '\'), '\n', '\\n', 'g')
  let @/ = '\V' . text

  call feedkeys(a:direction . "\<C-R>=@/\<CR>\<CR>")
endfunction

" Shortcuts for substitute as ex command
nnoremap <C-s> :%s/
vnoremap <C-s> :s/

" }}}

" {{{ Project-wide search

let g:search_ignore_dirs = ['.git', 'node_modules']

" TODO: git grep when under repository
" Choose grep backend, use ripgrep if available
if executable("rg")
  set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case\ --hidden\ --follow
  set grepformat=%f:%l:%c:%m
else
  set grepprg=grep\ -n\ --with-filename\ -I\ -R
  set grepformat=%f:%l:%m
endif

" Without bang, search is relative to cwd, otherwise relative to current file
command -nargs=* -bang -complete=file Grep call <SID>execute_search("Grep", <q-args>, <bang>0)
command -nargs=* -bang -complete=file GrepFzf call <SID>execute_search("GrepFzf", <q-args>, <bang>0)
command -nargs=* -bang -complete=file GrepSF call <SID>execute_search_ctrlsf(<q-args>, <bang>0)

" :grep + grepprg + quickfix list
nnoremap <F7><F7> :call <SID>prepare_search_command("", "Grep")<CR>
nnoremap <F7>w :call <SID>prepare_search_command("word", "Grep")<CR>
nnoremap <F7>s :call <SID>prepare_search_command("selection", "Grep")<CR>
nnoremap <F7>/ :call <SID>prepare_search_command("search", "Grep")<CR>
vnoremap <silent> <F7> :call <SID>prepare_search_command("selection", "Grep")<CR>

" fzf-vim + ripgrep
nnoremap <S-F7><S-F7> :call <SID>prepare_search_command("", "GrepFzf")<CR>
nnoremap <S-F7>w :call <SID>prepare_search_command("word", "GrepFzf")<CR>
nnoremap <S-F7>s :call <SID>prepare_search_command("selection", "GrepFzf")<CR>
nnoremap <S-F7>/ :call <SID>prepare_search_command("search", "GrepFzf")<CR>
vnoremap <silent> <S-F7> :call <SID>prepare_search_command("selection", "GrepFzf")<CR>

" ctrlsf.vim (uses ack, ag or rg under the hood)
nnoremap <F8><F8> :call <SID>prepare_search_command("", "GrepSF")<CR>
nnoremap <F8>w :call <SID>prepare_search_command("word", "GrepSF")<CR>
nnoremap <F8>s :call <SID>prepare_search_command("selection", "GrepSF")<CR>
nnoremap <F8>/ :call <SID>prepare_search_command("search", "GrepSF")<CR>
vnoremap <silent> <F8> :call <SID>prepare_search_command("selection", "GrepSF")<CR>


" Execute search for particular command (Grep, GrepSF, GrepFzf)
function s:execute_search(command, args, is_relative)
  if empty(a:args)
    call s:echo_warning("Search text not specified")
    return
  endif

  let extra_args = []
  let using_ripgrep = &grepprg =~ '^rg'

  " Set global mark to easily get back after we're done with a search
  normal mF

  " Exclude well known ignore dirs
  " This is useful for GNU grep, that does not respect .gitignore
  let ignore_dirs = s:get_var('search_ignore_dirs')
  for l:dir in ignore_dirs
    if using_ripgrep
      call add(extra_args, '--glob ' . shellescape(printf("!%s/", l:dir)))
    else
      call add(extra_args, '--exclude-dir ' . shellescape(printf("%s", l:dir)))
    endif
  endfor

  " Change cwd temporarily if search is relative to the current file
  if a:is_relative
    exe "cd " . expand("%:p:h")
  endif

  " Execute :grep + grepprg search, show results in quickfix list
  if a:command ==# 'Grep'
    " Perform search
    silent! exe "grep! " . join(extra_args) . " " . a:args
    redraw!

    " If matches are found, open quickfix list and focus first match
    " Do not open with copen, because we have qf list automatically open on search
    if len(getqflist())
      cc
    else
      cclose
      call s:echo_warning("No match found")
    endif
  endif

  " Execute search using fzf.vim + grep/ripgrep
  if a:command ==# 'GrepFzf'
    " Run in fullscreen mode, with preview at the top
    call fzf#vim#grep(printf("%s %s --color=always %s", &grepprg, join(extra_args), a:args),
          \ 1,
          \ fzf#vim#with_preview('up:60%'),
          \ 1)
  endif

  " Restore cwd back
  if a:is_relative
    exe "cd -"
  endif
endfunction

function s:execute_search_ctrlsf(args, is_relative)
  if empty(a:args)
    call s:echo_warning("Search text not specified")
    return
  endif

  " Show CtrlSF search pane in new tab
  tab split
  let t:is_ctrlsf_tab = 1

  " Change cwd, but do it window-local
  " Do not restore cwd, because ctrlsf#Search is async
  " Just close tab, when you're done with a search
  if a:is_relative
    exe "lcd " . expand("%:p:h")
  endif

  " Create new scratch buffer
  enew
  setlocal bufhidden=delete nobuflisted

  " Execute search
  call ctrlsf#Search(a:args)
endfunction

" Initiate search, prepare command using selected backend and context for the search
" Contexts are: word, selection, last search pattern
function s:prepare_search_command(context, backend)
  let text = a:context ==# 'word' ? expand("<cword>")
        \ : a:context ==# 'selection' ? s:get_selected_text()
        \ : a:context ==# 'search' ? @/
        \ : ''

  " Properly escape search text
  " Remove new lines (when several lines are visually selected)
  let text = substitute(text, "\n", "", "g")

  " Escape backslashes
  let text = escape(text, '\')

  " Put in double quotes
  let text = escape(text, '"')
  let text = empty(text) ? text : '"' . text . '"'

  " Grep/ripgrep/ctrlsf args
  " Always search literally, without regexp
  " Use word boundaries when context is 'word'
  let args = [a:backend ==# 'GrepSF' ? '-L' : '-F']
  if a:context ==# 'word'
    call add(args, a:backend ==# 'GrepSF' ? '-W' : '-w')
  endif

  " Compose ":GrepXX" command to put on a command line
  let search_command = ":\<C-u>" . a:backend
  let search_command .= empty(args) ? ' ' : ' ' . join(args, ' ') . ' '
  let search_command .= '-- ' . text

  " Put actual command in a command line, but do not execute
  " User would initiate a search manually with <CR>
  call feedkeys(search_command, 'n')
endfunction

" }}}

" {{{ Find files by name
" Uses https://github.com/samoshkin/vim-find-files plugin

function s:findprg_compose_ignoredir_args(backend, ignore_dirs)
  if empty(a:ignore_dirs)
    return ""
  endif

  let args = []
  if a:backend ==# 'fd'
    for l:dir in a:ignore_dirs
      call add(args, '-E ' . shellescape(printf('%s/', l:dir)))
    endfor
    return join(args)
  else
    for l:dir in a:ignore_dirs
      call add(args, '-path ' . shellescape(printf('*/%s/*', l:dir)))
    endfor
    return "\\( " . join(args) . " \\) -prune -o"
  endif
endfunction

" Similar to built-in grepprg, makeprg
if executable('fd')
  let g:find_files_findprg = printf("fd --hidden %s $* $d", s:findprg_compose_ignoredir_args("fd", g:search_ignore_dirs))
else
  let g:find_files_findprg = printf("find $d %s ! -type d $* -print", s:findprg_compose_ignoredir_args("find", g:search_ignore_dirs))
endif

" }}}

" Navigation{{{

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

" Tag matching list
nnoremap <silent> ]t :tnext<CR>
nnoremap <silent> [t :tprev<CR>
nnoremap <silent> ]T :tlast<CR>
nnoremap <silent> [T :tfirst<CR>

" Tags in preview window
nnoremap <silent> ]p :ptnext<CR>
nnoremap <silent> [p :ptprev<CR>
nnoremap <silent> ]P :ptlast<CR>
nnoremap <silent> [P :ptfirst<CR>

" Center screen after navigation shortcuts
nnoremap } }zvzz
nnoremap { {zvzz

nnoremap ]] ]]zvzz
nnoremap [[ [[zvzz
nnoremap [] []zvzz
nnoremap ][ ][zvzz

" Reselect text this was last changed or yanked
" https://vim.fandom.com/wiki/Selecting_your_pasted_text
nnoremap <expr> g[] '`[' . getregtype()[0] . '`]'
onoremap [] :exec "normal g[]"<CR>

" Some aliases for operator pending mode:
" 8 - operate inside word
" * - operate inside WORD
onoremap 8 iw
onoremap * iW

" q - operate inside quotes (' " `)
" [ - operate inside parentheses ( [ { . Same shortcut as used in rhysd/clever-f.vim plugin to match all signs
" t - operate inside tags
omap q iq
omap j ij
omap t it

" }}}

" Insert mode{{{

" Drop into insert mode on Backspace
nnoremap <BS> i<BS>

" In Insert mode, treat pasting form a buffer as a separate undoable operation
" Which can be undone with '<C-o>u'
inoremap <C-r> <C-g>u<C-r>

" CTRL-U in insert mode deletes a lot. Use CTRL-G u to first break undo
inoremap <C-u> <C-g>u<C-u>

" Use <C-v> instead of <C-r>
" Yes we're overriding <C-v> normal behavior, and unable to use some registers
" In these rare cases, resort back to <C-r>
" imap <C-v> <C-r>

" p/P, paste with formatting, due to 'g:yoinkAutoFormatPaste=1'
imap <C-v>p <ESC>pi
imap <C-v>P <ESC>Pi

" <C-v>v, paste verbatim, by entering Paste mode
imap <C-v>v <F12><C-r>+<F12>

" Retain original <C-v> behavior, insert character by code
" 'c' for character
inoremap <C-v>c <C-v>

" Insert digraph, 'd' for digraph
inoremap <C-v>d <C-k>

" Shift-Enter to start editing new line without splitting the current one
inoremap <S-CR> <C-o>o
" }}}

" Clipboard{{{

" Extend built-in functionality with these plugins:
" - https://github.com/svermeulen/vim-cutlass
" - https://github.com/svermeulen/vim-subversive
" - https://github.com/svermeulen/vim-yoink

" always use system clipboard as unnamed register
set clipboard=unnamed,unnamedplus

" Normalize Y behavior to yank till the end of line
nnoremap Y y$

" ------------------------------
" https://github.com/svermeulen/vim-cutlass
" ------------------------------

" Use 'x' as cut operation instead
" All other actions, like d, c, s will delete without storing in clipboard
nnoremap x d
nnoremap xx dd
nnoremap X D
xnoremap x d

" Retain original x and X behavior
" when we want to remove single character without entering insert mode
nnoremap <localleader>x x
nnoremap <localleader>X X

" ------------------------------
" https://github.com/svermeulen/vim-yoink
" ------------------------------

" Normally cursor remains in place during paste
" Move it to the end, so it's easy to start editing
let g:yoinkMoveCursorToEndOfPaste=1

" Every time the yank history changes the numbered registers 1 - 9 will be updated to sync with the first 9 entries in the yank history
let g:yoinkSyncNumberedRegisters = 1

" Auto formatting on paste, and be able to toggle formatting on/off
" Replaces the need for 'vim-pasta' plugin
let g:yoinkAutoFormatPaste=1
nmap <leader>= <plug>(YoinkPostPasteToggleFormat)

" For integration with 'svermeulen/cutclass', so 'cut'/x operator will be added to the yank history
let g:yoinkIncludeDeleteOperations=1

" Navigation through yank ring
nmap <C-p> <plug>(YoinkPostPasteSwapBack)
nmap <C-n> <plug>(YoinkPostPasteSwapForward)

" Map p and P keys to notify yoink that paste has occurred so we can further traverse yank ring with <c-n> and <c-p>
" NOTE: vim-yoink does not supports swapping when doing paste in visual mode, so we don't add "xmap p" here
" this feature is handled separately by vim-subversive
nmap p <plug>(YoinkPaste_p)
nmap P <plug>(YoinkPaste_P)

" Preserve cursor position after yank operation
nmap y <plug>(YoinkYankPreserveCursorPosition)
xmap y <plug>(YoinkYankPreserveCursorPosition)

" ------------------------------
" https://github.com/svermeulen/vim-subversive
" ------------------------------

" Store text that being substituted in register 'r'
let g:subversiveCurrentTextRegister='r'

" 'Use 's' as 'cut & replace' action, not as a shortcut to 'change' action
nmap s <plug>(SubversiveSubstitute)
nmap ss <plug>(SubversiveSubstituteLine)
nmap S <plug>(SubversiveSubstituteToEndOfLine)
xmap s <plug>(SubversiveSubstitute)

" In visual mode, regular 'put' operation actually does a substitution
" After remapping we can cycle through yank ring provided by 'vim-yoink' with <C-p> and <C-n>
" complements "svermeulen/vim-yoink"
xmap p <plug>(SubversiveSubstitute)
xmap P <plug>(SubversiveSubstitute)

" Substitute operation performed multiple times for a given text range
" Common usage is to replace same word in a paragraph or sentence
nmap <leader>s <plug>(SubversiveSubstituteRange)
nmap <leader>ss <plug>(SubversiveSubstituteWordRange)
xmap <leader>s <plug>(SubversiveSubstituteRange)

" }}}

" Folding ---------------------------------------------------------{{{

set foldenable
set foldmethod=marker
set foldlevelstart=0
set foldcolumn=1

" What triggers automatic fold opening
set foldopen-=block
set foldopen-=hor
set foldopen+=jump

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

" Remap because 'za' is highly inconvenient to type
nnoremap <leader><Space> za

" Close all folds except the one under the cursor, and center the screen
nnoremap <leader>z zMzvzz

" }}}

" Buffers and Files {{{

" Navigate buffers
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [b :bprev<CR>

" Kill buffer
nnoremap <silent> <leader>k :bd!<CR>

" Navigation over args list
nnoremap <silent> ]a :next<CR>
nnoremap <silent> [a :prev<CR>
nnoremap <silent> ]A :last<CR>
nnoremap <silent> [A :first<CR>

" Copy file basename only, file path, dirname
command! -nargs=0 CopyFileName let @+ = expand("%:t") | echo 'Copied to clipboard: ' . @+
command! -nargs=0 CopyFilePath let @+ = expand("%:p:~") | echo 'Copied to clipboard: ' . @+
command! -nargs=0 CopyFileDir let @+ = expand("%:p:~:h") | echo 'Copied to clipboard: ' . @+

" Open current directory in Finder
nnoremap <leader>F :silent exec "!open %:p:h" \| redraw!<CR>

" Scratch buffer and Eread command

" Read command output and show it in new scratch buffer
" :Eread !{system_command}
" :Eread {vim_command}
command! -nargs=1 -complete=command Eread silent call <SID>read_command_output_in_new_buffer(<q-args>)

" Capture command's output and show it in a new buffer
function! s:read_command_output_in_new_buffer(cmd)
  " Capture command output
  if a:cmd =~ '^!'
    let output = system(matchstr(a:cmd, '^!\zs.*'))
  else
    redir => output
    execute a:cmd
    redir END
  endif

  " Show in new scratch buffer
  call s:new_scratch_buffer(output, "Command: " . a:cmd)
endfunction

" Show text of list of lines in new scratch buffer
function s:new_scratch_buffer(content, ...)
  let title = get(a:, "1", "[Scratch]")
  let new_command = get(a:, "2", "enew")

  exe new_command
  let w:scratch = 1
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile hidden
  silent! exe "file! " . title

  " Automatically kill buffer on WinLeave
  augroup aug_scratch_autohide
    autocmd!
    execute 'autocmd WinLeave <buffer=' . bufnr('%') . '> bdelete'
  augroup END

  if type(a:content) == type([])
    call setline(1, a:content)
  else
    call setline(1, split(a:content, "\n"))
  endif
endfunction

" Smart quit window function
command QuitWindow call s:QuitWindow()
nnoremap <silent> <leader>q :QuitWindow<CR>

" Close all readonly buffers with just a "q" keystroke, otherwise "q" is used to record macros in a normal mode
nnoremap  <expr> q &readonly ? ":quit\<CR>" : "q"

" Save and quit
nnoremap <silent> <leader>w :update!<CR>
nnoremap ZZ :update! \| QuitWindow<CR>

" Save and quit for multiple buffers
nnoremap <silent> <leader>W :wall<CR>
nnoremap <silent> <leader>Q :confirm qall<CR>
nnoremap <silent> ZX :confirm xall<CR>


" Close list of windows
function s:CloseEachWindow(windows)
  " Reverse sort window numbers, start closing from the highest window number: 3,2,1
  " This is to ensure window numbers are not shifted while closing
  for _win in sort(copy(a:windows), {a, b -> b - a})
    exe _win . "wincmd c"
  endfor
endfunction

" Context-aware quit window logic
function s:QuitWindow()

  " If we're in merge mode, exit it
  if get(g:, 'mergetool_in_merge_mode', 0)
    call mergetool#stop()
    return
  endif

  " TODO: maybe use buffers instead of windows
  let l:diff_windows = s:GetDiffWindows()

  " When running as 'vimdiff' or 'vim -d', close both files and exit Vim
  if get(g:, 'is_started_as_vim_diff', 0)
    windo quit
    return
  endif

  " If current window is in diff mode, and we have two or more diff windows
  if &diff && len(l:diff_windows) >= 2
    let l:fug_diff_windows = filter(l:diff_windows[:], { idx, val -> s:IsFugitiveDiffWindow(val) })

    if s:GetFugitiveStatusWindow() != -1
      call s:CloseEachWindow(l:diff_windows)
    elseif !empty(l:fug_diff_windows)
      call s:CloseEachWindow(l:fug_diff_windows)
    else
      quit
    endif

    diffoff!
    diffoff!

    exe "norm zvzz"

    return
  endif

  quit
endfunction

" }}}

"  Window management {{{

" Navigate between windows
noremap <silent> <C-k> :wincmd k<CR>
noremap <silent> <C-j> :wincmd j<CR>
noremap <silent> <C-h> :wincmd h<CR>
noremap <silent> <C-l> :wincmd l<CR>

" Use <Bslash> instead of <C-w>, which is tough to type
nmap <Bslash> <C-w>

" Splits
set splitbelow
set splitright
nnoremap <silent> <leader>_ :split<CR>
nnoremap <silent> <leader>\| :vsplit<CR>
nnoremap <silent> <leader>0 :only<CR>

" Maximize split
" Use '<C-w>=' to make window sizes equal back
nnoremap <C-w><Bslash> <C-w>_<C-w>\|

" Tab navigation
nnoremap <silent> <leader>1 :tabnext 1<CR>
nnoremap <silent> <leader>2 :tabnext 2<CR>
nnoremap <silent> <leader>3 :tabnext 3<CR>
nnoremap <silent> <leader>4 :tabnext 4<CR>
nnoremap <silent> <leader>5 :tabnext 5<CR>
nnoremap <silent> <leader>9 :tablast<CR>

" Or use built-in gt/gT to traverse between tabs
nnoremap <silent> ]<Tab> :tabnext<CR>
nnoremap <silent> [<Tab> :tabprev<CR>

" Tab management
nnoremap <silent> <leader>+ :tabnew<CR>:edit .<CR>
nnoremap <silent> <leader>) :tabonly<CR>
nnoremap <silent> <leader>- :tabclose<CR>

" <C-w>T, moves window to a new tab (built-in)
" <C-w>t, copies window to a new tab
" NOTE: Hides original <C-w>t behavior to move to the topmost window
nnoremap <C-w>t :tab split<CR>

" Cycle between main and alternate file
nnoremap <C-w><Tab> <C-^>zz

" Resize windows
" in steps greather than just 1 column at a time
let _resize_factor = 1.2
nnoremap <C-w>> :exe "vert resize " . float2nr(round(winwidth(0) * _resize_factor))<CR>
nnoremap <C-w>< :exe "vert resize " . float2nr(round(winwidth(0) * 1/_resize_factor))<CR>
nnoremap <C-w>+ :exe "resize " . float2nr(round(winheight(0) * _resize_factor))<CR>
nnoremap <C-w>- :exe "resize " . float2nr(round(winheight(0) * 1/_resize_factor))<CR>

augroup aug_window_management
  au!

  " Detect when window is closed and fire custom event
  au BufWinEnter,WinEnter,BufDelete * call s:CheckIfWindowWasClosed()
  au User OnWinClose call s:Noop()

  " Make all windows of equal size on Vim resize
  au VimResized * wincmd =
augroup END

" Detect when window in a tab was closed
" Vim does not have WinClose event, so try to emulate it
" NOTE: does not work when non-current window gets closed
" See: https://github.com/vim/vim/issues/742
function! s:CheckIfWindowWasClosed()
  " Check if previous window count per tab is greather than current window count
  " It indicates that window was closed
  if get(t:, 'prevWinCount', 0) > winnr('$')
    doautocmd User OnWinClose
  endif

  let t:prevWinCount = winnr('$')
endfunction

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
set redrawtime=500

" Delay screen redraw for macros, uncompleted commands
" Redraw as fewer as possible
set lazyredraw

" Don't try to highlight lines longer than N characters.
set synmaxcol=200

" In some versions of vim it was reported that cursorline cause lags with scrolling
" set nocursorline
" }}}

" Diffs{{{

" Open diffs in vertical splits
" Use 'xdiff' library options: patience algorithm with indent-heuristics (same to Git options)
" NOTE: vim uses the external diff utility which doesn't do word diffs nor can it find moved-and-modified lines.
" See: https://stackoverflow.com/questions/36519864/the-way-to-improve-vimdiff-similarity-searching-mechanism
set diffopt=internal,filler,vertical,context:5,foldcolumn:1,indent-heuristic,algorithm:patience

" Detect if vim is started as a diff tool (vim -d, vimdiff)
" NOTE: Does not work when you start Vim as usual and enter diff mode using :diffthis
if &diff
  let g:is_started_as_vim_diff = 1
endif

augroup aug_diffs
  au!

  " Inspect whether some windows are in diff mode, and apply changes for such windows
  " Run asynchronously, to ensure '&diff' option is properly set by Vim
  au WinEnter,BufEnter * call timer_start(50, 'CheckDiffMode')

  " Highlight VCS conflict markers
  au VimEnter,WinEnter * if !exists('w:_vsc_conflict_marker_match') |
        \   let w:_vsc_conflict_marker_match = matchadd('ErrorMsg', '^\(<\|=\||\|>\)\{7\}\([^=].\+\)\?$') |
        \ endif
augroup END

" Get list of all windows running in diff mode
function s:GetDiffWindows()
  return filter(range(1, winnr('$')), { idx, val -> getwinvar(val, '&diff') })
endfunction

" In diff mode:
" - Disable syntax highlighting
" - Disable spell checking
function CheckDiffMode(timer)
  let curwin = winnr()

  " Check each window
  for _win in range(1, winnr('$'))
    exe "noautocmd " . _win . "wincmd w"

    call s:change_option_in_diffmode('b:', 'syntax', 'off')
    call s:change_option_in_diffmode('w:', 'spell', 0, 1)
  endfor

  " Get back to original window
  exe "noautocmd " . curwin . "wincmd w"
endfunction

" Detect window or buffer local option is in sync with diff mode
function s:change_option_in_diffmode(scope, option, value, ...)
  let isBoolean = get(a:, "1", 0)
  let backupVarname = a:scope . "_old_" . a:option

  " Entering diff mode
  if &diff && !exists(backupVarname)
    exe "let " . backupVarname . "=&" . a:option
    call s:set_option(a:option, a:value, 1, isBoolean)
  endif

  " Exiting diff mode
  if !&diff && exists(backupVarname)
    let oldValue = eval(backupVarname)
    call s:set_option(a:option, oldValue, 1, isBoolean)
    exe "unlet " . backupVarname
  endif
endfunction

" Diff exchange and movement actions. Mappings come from 'samoshkin/vim-mergetool'
nmap <expr> <C-Left> &diff? '<Plug>(MergetoolDiffExchangeLeft)' : '<C-Left>'
nmap <expr> <C-Right> &diff? '<Plug>(MergetoolDiffExchangeRight)' : '<C-Right>'
nmap <expr> <C-Down> &diff? '<Plug>(MergetoolDiffExchangeDown)' : '<C-Down>'
nmap <expr> <C-Up> &diff? '<Plug>(MergetoolDiffExchangeUp)' : '<C-Up>'

" Move through diffs. [c and ]c are native Vim mappings
nnoremap <expr> <Up> &diff ? '[czz' : ''
nnoremap <expr> <Down> &diff ? ']czz' : ''
nnoremap <expr> <Left> &diff? '<C-w>h' : ''
nnoremap <expr> <Right> &diff? '<C-w>l' : ''

" Change :diffsplit command to open diff in new tab
cnoreabbrev <expr> diffsplit getcmdtype() == ":" && getcmdline() == 'diffsplit' ? 'tab split \| diffsplit' : 'diffsplit'
" }}}

" Session management{{{

" Session is created manually and bounded to project cwd
" If given dir has session associated, it gets loaded automatically

" Use "https://github.com/tpope/vim-obsession" to automatically save session using :mksession on various events
" when new buffer is added, when Vim is exited, when layout changes

" What is going to be save in session
" + buffers,curdir,tabpages,winsize,terminal
set sessionoptions-=folds
set sessionoptions-=options
set sessionoptions-=help
set sessionoptions-=blank

" All sessions are stored in "~/.vim/sessions" directory
function! s:GetSessionDir()
  return $HOME . "/.vim/sessions" . getcwd()
endfunction

" Create new session
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
function! s:SessionUnload(shouldRemove)
  if ObsessionStatus() == '[$]'
    exe (a:shouldRemove ? "Obsession!" : "Obsession")
    silent! %bdelete
  else
    echo "No session loaded."
  endif
endfunction

" Automatically try loading session for current directory,
" unless arguments are passed to vim and input is not read from stdin
augroup aug_session_management
  au!

  autocmd StdinReadPre * let g:__is_stdin = 1
  autocmd VimEnter * nested if argc() == 0 && !exists("g:__is_stdin")
        \ | call <SID>SessionLoad()
        \ | endif
augroup END

" Expose set of commands to manage sessions
command! -nargs=0 SessionCreate call <SID>SessionCreate()
command! -nargs=0 SessionLoad call <SID>SessionLoad()
command! -nargs=0 SessionUnload call <SID>SessionUnload(0)
command! -nargs=0 SessionRemove call <SID>SessionUnload(1)

" }}}

" Autosave and backup{{{

" Features defaults:
" - autosave: off
" - backup: off
" - undofile: on
" - swapfile: on

" Regarding autosaving:
" - built-in "autowrite" saves file on buffer change and quit
" - '907th/vim-auto-save' saves file on given events (TextChanged, InsertLeave, CursorHold)

" Do not use built-in "autosave" behavior, because it triggers for a limited set of events
set noautowrite
" In addition to autosaving, enable swap file, disable backup
" and keep persistent undo history that survives Vim process lifetime
set swapfile
set nobackup

" Automatically read files which are changed outside vim
set autoread

" '907th/vim-auto-save' settings
" Can be overridden per buffer
let g:auto_save=0
let g:auto_save_events = ["InsertLeave", "TextChanged", "CursorHold"]
let g:auto_save_silent = 1
let g:auto_save_presave_hook = 'call OnAutoSaveHook()'

function OnAutoSaveHook()
  " Disable auto-saving in diff mode
  if &diff
    let g:auto_save_abort = 1
  endif
endfunction

" Toggle autosave ON/OFF per buffer
command -nargs=0 ToggleAutoSave let b:auto_save = !s:get_var('auto_save', 0)

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

" Context-aware Tab behavior{{{
function s:ExpandTab()
  if pumvisible()
    return "\<C-n>"
  endif

  let l:snippet = UltiSnips#ExpandSnippetOrJump()
  if g:ulti_expand_or_jump_res > 0
    return ""
  endif

  if s:IsEmmetInstalled()
    if s:IsInsideEmmetExpansion()
      call feedkeys("\<A-,>n")
      return ""
    endif

    if emmet#isExpandable()
      call feedkeys("\<A-,>,")
      return ""
    endif
  endif

  return "\<Tab>"
endfunction


function s:ExpandShiftTab()
  if pumvisible()
    return "\<C-p>"
  endif

  let l:snippet = UltiSnips#JumpBackwards()
  if g:ulti_jump_backwards_res > 0
    return ""
  endif

  if s:IsEmmetInstalled() && s:IsInsideEmmetExpansion()
    call feedkeys("\<A-,>N")
    return ""
  endif

  return "\<S-Tab>"
endfunction

function s:IsInsideEmmetExpansion()
  let line = getline('.')

  " Check if we're inside quotes or angle brackets
  if col('.') < len(line)
    let line = matchstr(line, '[">][^<"]*\%'.col('.').'c[^>"]*[<"]')
    return len(line) >= 2
  endif

  return 0
endfunction

function s:IsEmmetInstalled()
  return hasmapto('<plug>(emmet-move-next)', 'i') &&
        \ hasmapto('<plug>(emmet-move-prev)', 'i') &&
        \ hasmapto('<plug>(emmet-expand-abbr)', 'i')
endfunction

inoremap <Tab> <C-R>=<SID>ExpandTab()<CR>
inoremap <S-Tab> <C-R>=<SID>ExpandShiftTab()<CR>
snoremap <Tab> <ESC>:call UltiSnips#JumpForwards()<CR>
snoremap <S-Tab> <ESC>:call UltiSnips#JumpBackwards()<CR>
" }}}

" {{{ Spell checking

" Use .vim dir for now. Later use dropbox dir to share spellfile between machines
if !isdirectory(expand('~/.vim/spell'))
  call mkdir(expand('~/.vim/spell'), 'p')
endif

" Used for <C-x><C-k> completion in insert mode
" Not used for spellcheck purposes
set dictionary=/usr/share/dict/words

" Disable spell checking by default
set nospell

set spelllang=en

" Dict with words marked as good/wrong
" TODO: move to ~/sync/dropbox later
set spellfile=~/.vim/spell/dict.utf-8.add

" In Insert mode automatically fix last misspelled word by picking first suggestion
inoremap <C-S>f <C-G>u<Esc>[s1z=gi<C-G>u

" In insert mode, select previous misspelled word, and drop in Select mode
" In insert mode, we usually don't care about next misspelled word
inoremap <C-S>s <Esc>[sve<C-G>

" }}}

" Quickfix and Location list{{{

" <F5> for quickfix list
nmap <F5> <Plug>(qf_qf_toggle)
nmap <S-F5> <Plug>(qf_qf_switch)
nnoremap <silent> <leader><F5> :call <SID>qf_loc_quit('qf')<CR>
nnoremap <silent> [<F5> :call <SID>qf_loc_history_navigate('colder')<CR>
nnoremap <silent> ]<F5> :call <SID>qf_loc_history_navigate('cnewer')<CR>

" <F6> for location list
nmap <F6> <Plug>(qf_loc_toggle)
nmap <S-F6> <Plug>(qf_loc_switch)
nmap <silent> <leader><F6> :call <SID>qf_loc_quit('loc')<CR>
nnoremap <silent> [<F6> :call <SID>qf_loc_history_navigate('lolder')<CR>
nnoremap <silent> ]<F6> :call <SID>qf_loc_history_navigate('lnewer')<CR>

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

" Navigate thru items in quickfix and location lists
" Borrowed from tpope/vim-unimpaired
" Pitfall: In order to use <C-q>, <C-s> shortcuts to navigate quick list
" make sure to sisable XON/XOFF flow control with 'stty -ixon'

" Quickfix list
nnoremap <silent> ]q :<C-u>call <SID>qf_loc_list_navigate("cnext")<CR>
nnoremap <silent> [q :<C-u>call <SID>qf_loc_list_navigate("cprev")<CR>
nnoremap <silent> ]Q :<C-u>call <SID>qf_loc_list_navigate("clast")<CR>
nnoremap <silent> [Q :<C-u>call <SID>qf_loc_list_navigate("cfirst")<CR>
nnoremap <silent> ]<C-q> :<C-u>call <SID>qf_loc_list_navigate("cnfile")<CR>
nnoremap <silent> [<C-q> :<C-u>call <SID>qf_loc_list_navigate("cpfile")<CR>

" Location list
nnoremap <silent> ]e :<C-u>call <SID>qf_loc_list_navigate("lnext")<CR>
nnoremap <silent> [e :<C-u>call <SID>qf_loc_list_navigate("lprev")<CR>
nnoremap <silent> ]E :<C-u>call <SID>qf_loc_list_navigate("llast")<CR>
nnoremap <silent> [E :<C-u>call <SID>qf_loc_list_navigate("lfirst")<CR>
nnoremap <silent> ]<C-e> :<C-u>call <SID>qf_loc_list_navigate("lnfile")<CR>
nnoremap <silent> [<C-e> :<C-u>call <SID>qf_loc_list_navigate("lpfile")<CR>

" Remove single item from quickfix/loc list using conditional '-' key mapping
nnoremap <Plug>QfRemoveCurrentItem :<C-U>call <SID>qf_loc_remove_current_item('qf')<CR>
nnoremap <Plug>LocRemoveCurrentItem :<C-U>call <SID>qf_loc_remove_current_item('loc')<CR>
nmap <silent> <expr> - qf#IsLocWindowOpen(0) ? '<Plug>LocRemoveCurrentItem'
      \ : qf#IsQfWindowOpen() ? '<Plug>QfRemoveCurrentItem' : '-'

augroup aug_quickfix_list
  au!

  autocmd QuickFixCmdPre [^l]* call s:qf_loc_on_enter('qf')
  autocmd QuickFixCmdPre    l* call s:qf_loc_on_enter('loc')

  autocmd FileType qf command! -nargs=0 ReloadList call <SID>qf_loc_reload_list(empty(getloclist(0)) ? 'qf' : 'loc')
augroup END

" Remember cursor position before running quickfix cmd
" Disable folding
function s:qf_loc_on_enter(list_type)
  " Do nothing, when we're already in quickfix list
  if &filetype ==# 'qf'
    return
  endif

  exe "normal m" . (a:list_type ==# 'qf' ? 'Q' : 'L')

  " Disable folding temporarily
  let curr_buffer = bufnr("%")
  bufdo set nofoldenable
  execute 'buffer ' . curr_buffer
endfunction

" Navigate thru lists, open closed folds, and recenter screen
function s:qf_loc_list_navigate(command)
  try
    exe a:command
  catch /E553/
    echohl WarningMsg
    echo "No more items in a list"
    echohl None
    return
  endtry
  if &foldopen =~ 'quickfix' && foldclosed(line('.')) != -1
    normal! zv
  endif
  normal zz
endfunction

" Close quickfix or location list if opened
" And get back to cursor position before quickfix command was executed
function s:qf_loc_quit(list_type)
  " First, remove focus from quickfix list
  if &filetype ==# 'qf'
    wincmd p
  endif

  " Restore folding back
  bufdo set foldenable

  if a:list_type ==# 'qf'
    if qf#IsQfWindowOpen()
      call qf#toggle#ToggleQfWindow(0)
    endif
    normal `Q
  else
    if qf#IsLocWindowOpen(0)
      call qf#toggle#ToggleLocWindow(0)
    endif
    normal `L
  endif
endfunction

" Removes current item from quickfix/location list and reloads it
function s:qf_loc_remove_current_item(list_type)
  if a:list_type ==# 'qf'
    " Get index of current item in quickfix list
    " Index is 1-based
    let current_item_idx = get(getqflist({'idx': 0}), 'idx', 0)

    " List is empty, nothing to remove
    if current_item_idx == 0
      echohl WarningMsg
      echo "No more items in a list"
      echohl None
      return
    endif

    " Replace quickfix list with a new list without one item
    " filter v:key index is 0-based
    call setqflist(filter(getqflist(), 'v:key != ' . (current_item_idx - 1)), 'r')

    " Close and reopen quickfix list to fix highlighting
    cclose | cwindow

    " Display the next item, so we don't start at first one
    exe "cc " . current_item_idx
  else
    " Get index of current item in location list
    let current_item_idx = get(getloclist(0, {'idx': 0}), 'idx', 0)

    " List is empty, nothing to remove
    if current_item_idx == 0
      echohl WarningMsg
      echo "No more items in a list"
      echohl None
      return
    endif

    " Replace quickfix list with a new list without one item
    " filter v:key index is 0-based
    call setloclist(0, filter(getloclist(0), 'v:key != ' . (current_item_idx - 1)), 'r')

    " Close and reopen quickfix list to fix highlighting
    lclose | lwindow

    " Display the next item, so we don't start at first one
    exe "ll " . current_item_idx
  endif
endfunction

" TODO: submit pull request to "romainl/vim-qf"
" Reloads quickfix list to pull changes after 'Search&replace' scenario
function s:qf_loc_reload_list(list_type)
  if a:list_type ==# 'qf'
    call setqflist(map(getqflist(), 'extend(v:val, {"text":get(getbufline(v:val.bufnr, v:val.lnum),0)})'), 'r')
    cfirst
  else
    call setloclist(0, map(getloclist(), 'extend(v:val, {"text":get(getbufline(v:val.bufnr, v:val.lnum),0)})'), 'r')
    lfirst
  endif
endfunction

" Navigate to older/newer qf/loc list
function s:qf_loc_history_navigate(command)
  try
    exe a:command
    cfirst
  catch /E\(380\|381\)/
    echohl WarningMsg
    echo "Reached end of the history"
    echohl None
  endtry
endfunction

" }}}

" {{{ GIT integration

" --------------------
" PLUGIN: tpope/vim-fugitive
" --------------------

" View GIT index window
nnoremap <silent> <leader>gs :Gstatus<CR>

" Use <leader>ge to return to working tree version from blob, blame, log
nnoremap <silent> <leader>ge :Gedit<CR>

" Undo changes in working tree
" nnoremap <silent> <leader>gu :Git checkout HEAD -- %:p<CR>
nnoremap <silent> <leader>gu :Gread<CR>
xnoremap <silent> <leader>gu :Gread<CR>

" Commit changes
nnoremap <silent> <leader>gca :Gcommit --all --verbose<CR>
nnoremap <silent> <leader>gcf :Gcommit --amend --reuse-message HEAD<CR>
nnoremap <silent> <leader>gcf :Gcommit --amend --verbose<CR>

" Diff working tree vs index vs HEAD
nnoremap <silent> <leader>gdw :Gdiff<CR>
nnoremap <silent> <leader>gdh :Gdiff HEAD<CR>
nnoremap <silent> <leader>gdi :Gdiff --cached HEAD<CR>

" gla, gva, list (a)ll commits
nnoremap <silent> <leader>gla :FzfCommits<CR>
nnoremap <silent> <leader>gva :GV<CR>

" glf, gvf, list commits touching current (f)ile
nnoremap <silent> <leader>glf :FzfBCommits<CR>
nnoremap <silent> <leader>gvf :GV!<CR>
xnoremap <silent> <leader>gvf :GV<CR>

" gls, gvs, list commits touching current file, but show file revisions or (s)napshots (populates quickfix list)
nnoremap <silent> <leader>gls :silent! Glog<CR><C-l>
nnoremap <silent> <leader>gvs :GV?<CR>

" glF, list commits touching current file, show full commit objects (using vim-fugitive)
nnoremap <silent> <leader>glF :silent! Glog -- %<CR><C-l>

" Change branch
nnoremap <silent> <leader>gco :Git checkout<Space>

" ------------------------------
" PLUGIN: airblade/vim-gitgutter
" ------------------------------

let g:gitgutter_terminal_reports_focus=0
let g:gitgutter_enabled = 1

nnoremap <silent> <F4> :GitGutterFold<CR>
nnoremap <silent> <leader><F4> :GitGutterBufferToggle<CR>

" Use 'd' as a motion for hunks, instead of default 'c'
" Use '[d' and ']d' to move between hunks in regular files and in diff mode
" It's easier to use 'do' and 'dp' when a finger is already on 'd' key
nmap <expr> ]d &diff ? ']czz' : '<Plug>GitGutterNextHunkzz'
nmap <expr> [d &diff ? '[czz' : '<Plug>GitGutterPrevHunkzz'

" Undo and stage diff hunks in diff and normal modes
nmap <expr> + &diff ? '<Plug>GitGutterStageHunk' : '+'
nmap <expr> - &diff ? '<Plug>GitGutterUndoHunk' : '-'
nmap <silent> <leader>hu <Plug>GitGutterUndoHunk
nmap <silent> <leader>hs <Plug>GitGutterStageHunk

" Text objects for diff hunks
omap id <Plug>GitGutterTextObjectInnerPending
omap ad <Plug>GitGutterTextObjectOuterPending
xmap id <Plug>GitGutterTextObjectInnerVisual
xmap ad <Plug>GitGutterTextObjectOuterVisual

augroup aug_git_integration
  au!

  " Move one level up with '..' when browsing tree or blob
  autocmd User fugitive
        \ if get(b:, 'fugitive_type', '') =~# '^\%(tree\|blob\)$' |
        \   nnoremap <buffer> .. :edit %:h<CR> |
        \ endif

  " Show Fugitive status window in separate tab
  autocmd BufEnter */.git/index
        \ if !exists('b:created') && get(b:, 'fugitive_type', '') == 'index' |
        \   let b:created = 1 |
        \   wincmd T |
        \ endif

  " Collapse status window when viewing diff or editing commit message
  autocmd BufLeave */.git/index call s:OnFugitiveStatusBufferEnterOrLeave(0)
  autocmd BufEnter */.git/index call s:OnFugitiveStatusBufferEnterOrLeave(1)

  " Delete fugitive buffers automatically on leave
  autocmd BufReadPost fugitive://* set bufhidden=delete

  " Disable folding in "junegunn/gv.vim" plugin buffers
  au FileType GV set nofoldenable
augroup END

" Find fugitive status window and return it's number
function s:GetFugitiveStatusWindow()
  for winnr in range(1, winnr('$'))
    if getbufvar(winbufnr(winnr), 'fugitive_type') == 'index'
      return winnr
    endif
  endfor
  return -1
endfunction

function s:OnFugitiveStatusBufferEnterOrLeave(isEnter)
  let l:fug_status_window = s:GetFugitiveStatusWindow()
  if l:fug_status_window != -1
    if a:isEnter
      " When entering, resize status window to equal widht and height
      exe l:fug_status_window . " wincmd w"
      exe "wincmd ="
    elseif !a:isEnter && winnr('$') > 1
      " When leaving, collapse status window
      exe l:fug_status_window . " wincmd w"
      exe "resize 0"
      exe "wincmd p"
    endif
  endif
endfunction

function s:IsFugitiveDiffWindow(winnr)
  return bufname(winbufnr(a:winnr)) =~ '^fugitive:' && getwinvar(a:winnr, '&diff')
endfunction

" }}}

" Snippets {{{

" 'SirVer/ultisnips' is only the snippet engine.
" Defines snippet files syntax. Understands ULtiSnips syntax and vim-snipmate (another engine) snippets

" Snippet definition files are separate and shipped by 'honza/vim-snippets'

" Do not let UltiSnips set <Tab> mapping, as we're using own smart <Tab> implementation
" Also we don't need snippet listing, as we're using fzf for this purpose
let g:UltiSnipsExpandTrigger="<NUL>"
let g:UltiSnipsListSnippets="<NUL>"
let g:UltiSnipsEditSplit = 'context'

" Find available snippets from Insert mode using fzf
" Use :UltiSnipsEdit(!) command to edit private(all) snippet definition file
inoremap <silent> <F9> <ESC>:FzfSnippets<CR>
nnoremap <silent> <F9> :UltiSnipsEdit!<CR>
" }}}

" Misc{{{

" Expand '%%' and '##' for current/alternate files in command line
" This is useful for commands that do not understand %%
cnoremap %% <C-R>=fnameescape(expand('%'))<cr>
cnoremap ## <C-R>=fnameescape(expand('#'))<cr>

" Apply '.' repeat command for selected each line in visual mode
vnoremap . :normal .<CR>

" Get visually selected text
" FIXME: should not change cursor position
function! s:get_selected_text()
  try
    let regb = @z
    normal! gv"zy
    return @z
  finally
    let @z = regb
  endtry
endfunction

" Set option using set or setlocal, be it string or boolean value
function s:set_option(option, value, ...)
  let isLocal = get(a:, "1", 0)
  let isBoolean = get(a:, "2", 0)
  if isBoolean
    exe (isLocal ? "setlocal " : "set ") . (a:value ? "" : "no") . a:option
  else
    exe (isLocal ? "setlocal " : "set ") . a:option . "=" . a:value
  endif
endfunction

" Echo warning message with highlighting enabled
function s:echo_warning(message)
  echohl WarningMsg
  echo a:message
  echohl None
endfunction

function s:Noop()
endfunction

" Resolves variable value respecting window, buffer, global hierarchy
function s:get_var(...)
  let varName = a:1

  if exists('w:' . varName)
    return w:{varName}
  elseif exists('b:' . varName)
    return b:{varName}
  elseif exists('g:' . varName)
    return g:{varName}
  else
    return exists('a:2') ? a:2 : ''
  endif
endfunction

"}}}


" PLUGIN: Airline {{{

" Do not use default status line
set noshowmode

" Do not use powerline arrows, it looks not serious
let g:airline_powerline_fonts = 0

let g:airline_skip_empty_sections = 1

" Do not show spell language indicator, show only spell/nospell
let g:airline_detect_spelllang=0

" Disable some icons in lune number section_z to reduce length
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.linenr=''
let g:airline_symbols.maxlinenr=''
let g:airline_symbols.space=' '

let s:spc = g:airline_symbols.space

" Extensions
"
" Disable airline default extension, as we want to customize output:
" - obsession (btw, it does not work for some reason)
" - gutentags
" - tagbar
let g:airline#extensions#obsession#enabled=0
let g:airline#extensions#gutentags#enabled = 0
let g:airline#extensions#tagbar#enabled = 0

" Extension: obsession
function! GetObsessionStatus()
  return ObsessionStatus('ⓢ' . s:spc, '')
endfunction

call airline#parts#define_function('_obsession', 'GetObsessionStatus')
call airline#parts#define_accent('_obsession', 'bold')

" Extension: gutentags
function! GetGutentagStatusText(mods) abort
  let l:msg = ''

  " Show indicator when tags are enabled
  if g:gutentags_enabled
    let l:msg .= 'ⓣ' . s:spc
  endif

  " Show indicator when tag generation is in progress
  if index(a:mods, 'ctags') >= 0
    let l:msg = '~' . l:msg
  endif

  return l:msg
endfunction

function! AirlineGutentagsPart()
  return gutentags#statusline_cb(function('GetGutentagStatusText'), 1)
endfunction

call airline#parts#define_function('_gutentags', 'AirlineGutentagsPart')
call airline#parts#define_accent('_gutentags', 'bold')

" Extension: Diff or merge indicator
function! AirlineDiffmergePart()
  if get(g:, 'mergetool_in_merge_mode', 0)
    return '↸' . s:spc . s:spc
  endif

  if &diff
    return '↹' . s:spc . s:spc
  endif

  return ''
endfunction

call airline#parts#define_function('_diffmerge', 'AirlineDiffmergePart')
call airline#parts#define_accent('_diffmerge', 'bold')

" Extension: Autosave indicator
function! AirlineAutosavePart()
  return s:get_var('auto_save', 0) ? '' . s:spc : ''
endfunction

call airline#parts#define_function('_autosave', 'AirlineAutosavePart')

" Modified indicator
" Show only modified [+] indicator colored, not the whole file name
call airline#parts#define_raw('modified', '%m')
call airline#parts#define_accent('modified', 'orange')

" Extension: 'ffenc'
" Do not show default encoding. Show only when does not match given string
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'

" Extensions: hunks
let g:airline#extensions#hunks#non_zero_only = 1

" Buffer number, show only for diff windows
" NOTE: use define_function() instead of define_raw() because raw does not work with condition
function! AirlineBufnrPart()
  return bufnr('') . ':'
endfunction

call airline#parts#define_function('bufnr', 'AirlineBufnrPart')
call airline#parts#define_condition('bufnr', "&diff")

" Extension: scratch buffer indicator
" Indicator to tell if this is a scratch buffer
" Show indicator only in NORMAL mode
function! AirlinsScratchBufferIndicatorPart()
  if &buftype ==# 'nofile' && (&bufhidden ==# 'wipe' || &bufhidden ==# 'delete') && !buflisted(bufnr('%'))
    return 'Scratch'
  endif

  return ''
endfunction

call airline#parts#define_function('scratch', 'AirlinsScratchBufferIndicatorPart')
call airline#parts#define_condition('scratch', "mode() ==# 'n'")

" Extension: word count
" Do not show live word count
let g:airline#extensions#wordcount#enabled = 0

" Extensions: whitespace
let g:airline#extensions#whitespace#checks = ['indent', 'trailing', 'mixed-indent-file']
let g:airline#extensions#whitespace#trailing_format = 't[%s]'
let g:airline#extensions#whitespace#mixed_indent_format = 'i[%s]'
let g:airline#extensions#whitespace#mixed_indent_file_format = 'i[%s]'

" Airline sections customization
let g:airline_section_a = airline#section#create_left(['mode', 'scratch', 'crypt', 'paste', 'keymap', 'spell', 'capslock', 'xkblayout', 'iminsert'])
let g:airline_section_z = airline#section#create(['_autosave', '_diffmerge', '_gutentags', '_obsession', '%3p%% ', 'linenr', ':%3v'])
let g:airline_section_c = airline#section#create(['bufnr', '%<', '%f', 'modified', ' ', 'readonly'])

" Tell at which window width sections are shrinked
let g:airline#extensions#default#section_truncate_width = get(g:, 'airline#extensions#default#section_truncate_width', {
      \ 'b': 80,
      \ 'x': 60,
      \ 'y': 80,
      \ 'z': 45,
      \ 'warning': 80,
      \ 'error': 80,
      \ })

" Patch airline theme

" Default theme
let g:airline_theme='jellybeans'
let g:airline_theme_patch_func = 'AirlineThemePatch'

" Do not change coloring of section 'c' and 'x' in visual, replace, insert modes
" Add additional accent colors for status line icons
function! AirlineThemePatch(palette)
  let a:palette.insert.airline_x = a:palette.normal.airline_x
  let a:palette.insert.airline_c = a:palette.normal.airline_c

  let a:palette.replace.airline_x = a:palette.normal.airline_x
  let a:palette.replace.airline_c = a:palette.normal.airline_c

  let a:palette.visual.airline_x = a:palette.normal.airline_x
  let a:palette.visual.airline_c = a:palette.normal.airline_c

  " Reminder on palette values: [ guifg, guibg, ctermfg, ctermbg, opts ].
  " let a:palette.accents = get(a:palette, 'accents', {})

  " Do not highlight whole modified file. I want to hihglight only [+] modified indicator
  silent! unlet a:palette.normal_modified
  silent! unlet a:palette.replace_modified
  silent! unlet a:palette.visual_modified
  silent! unlet a:palette.insert_modified
  silent! unlet a:palette.inactive_modified

endfunction

" Hide sections on the right for inactive window, same as we do for left sections
function! PatchInactiveStatusLine(...)
  call setwinvar(a:2.winnr, 'airline_section_z', '')
  call setwinvar(a:2.winnr, 'airline_section_y', '')
endfunction
call airline#add_inactive_statusline_func('PatchInactiveStatusLine')

"Tabline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline#extensions#tabline#tab_min_count = 2
let g:airline#extensions#tabline#tabs_label = 't'

" Disable fancy powerline arrows
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#right_sep = ''
let g:airline#extensions#tabline#right_alt_sep = ''

" Buffers (disable, Tabline makes sense only for tabs IMO)
let g:airline#extensions#tabline#show_buffers = 0

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
let NERDTreeWinSize=40

" Automatically delete buffer when file is deleted from the tree explorer
let NERDTreeAutoDeleteBuffer=1

" Locate current file in a tree
noremap  <F2> :NERDTreeToggle<CR>
nnoremap <leader>f :NERDTreeFind<CR>

augroup aug_nerd_tree
  au!

  " Auto launch tree when vim is run with directory as argument
  autocmd StdinReadPre * let s:std_in=1
  autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

  " Exit vim when the only buffer remaining is NerdTree
  autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

  " Use arrow keys to navigate
  autocmd FileType nerdtree nmap <buffer> l o
  autocmd FileType nerdtree nmap <buffer> L O
  autocmd FileType nerdtree nmap <buffer> h p
  autocmd FileType nerdtree nmap <buffer> H P

  " Disable cursorline in NERDtree to avoid lags
  " built-in g:NERDTreeHighlightCursorline does not work
  autocmd FileType nerdtree setlocal nocursorline
augroup END

" Open and preview in splits
let g:NERDTreeMapOpenSplit="s"
let g:NERDTreeMapPreviewSplit="S"
let g:NERDTreeMapOpenVSplit="v"
let g:NERDTreeMapPreviewVSplit="V"

" Open and preview in current window
let g:NERDTreeMapActivateNode="o"
let g:NERDTreeMapPreview="O"

" Instead of "I" default mapping (D for dotfiles)
let g:NERDTreeMapToggleHidden="D"

" Do not show '.git' directories, in addition to what specified in .gitignore
let NERDTreeIgnore=['\~$', '^\.git$[[dir]]']

" Tweak status line, so it shortens path if it's under HOME directory
let g:NERDTreeStatusline="%{exists('b:NERDTree')? fnamemodify(b:NERDTree.root.path.str(), ':p:~') :''}"

" }}}

" Plugin: ryanoasis/vim-devicons {{{
" Do not show brackets around icons in NERDTree
let g:webdevicons_conceal_nerdtree_brackets = 1

" Show icons for directories
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:WebDevIconsUnicodeGlyphDoubleWidth = 0

" Use different icons for opened and closed folder
let g:DevIconsEnableFoldersOpenClose = 1

" Do not put extra whitespace before icon
let g:WebDevIconsNerdTreeBeforeGlyphPadding=''

" Do not overwrite airline.section_y with custom fileformat indicator
" BUG: unfortunately, vim-devicons overrites section instead of appending
let g:webdevicons_enable_airline_statusline_fileformat_symbols = 0

" Disable for tabline. Distract too much
let g:webdevicons_enable_airline_tabline = 0

" Colorize devicons
let g:devicons_colors = {
      \ 'brown': ['', '', ''],
      \ 'aqua': [''],
      \ 'blue': ['', '', '', '', '', '', '', '', '', '', '', '', '', '', ''],
      \ 'purple': ['', '', '', '', '', '', ''],
      \ 'red': ['', '', '', '', '', ''],
      \ 'beige': ['', '', '', ''],
      \ 'yellow': ['', '', 'λ', ''],
      \ 'orange': ['', '', ''],
      \ 'darkOrange': ['', '', '', ''],
      \ 'pink': ['', ''],
      \ 'green': ['', '', '', '', '', '', '', ''],
      \ 'white': ['', '', '', '', ''],
      \ }

augroup aug_vim_devicons
  au!

  " Apply devicons coloring only for NERDtree buffer
  for color in keys(g:devicons_colors)
    exec 'autocmd FileType nerdtree syntax match devicons_' . color . ' /\v' . join(g:devicons_colors[color], '.|') . './ containedin=ALL'
    exec 'autocmd FileType nerdtree highlight devicons_' . color . ' guifg=' .g:colors[color][0] . ' ctermfg=' . g:colors[color][1]
  endfor
augroup END

" From FAQ: How do I solve issues after re-sourcing my vimrc?
if exists("g:loaded_webdevicons")
  call webdevicons#refresh()
endif

" }}}

" PLUGIN: fzf.vim{{{

let g:fzf_layout = { 'down': '~40%' }

" Populate quickfix list with selected files
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  botright copen
  cc
endfunction

" Ctrl-q allows to select multiple elements an open them in quick list
let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
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
imap <c-x><c-l> <plug>(fzf-complete-buffer-line)

" Use preview when FzfFiles runs in fullscreen
command! -nargs=? -bang -complete=dir FzfFiles
      \ call fzf#vim#files(<q-args>, <bang>0 ? fzf#vim#with_preview('up:60%') : {}, <bang>0)

" Mappings
nnoremap <silent> <leader>o :FzfFiles<CR>
nnoremap <silent> <leader>O :FzfFiles!<CR>
nnoremap <silent> <leader>l  :FzfBuffers<CR>
nnoremap <silent> <leader>b :FzfBLines<CR>
nnoremap <silent> <leader>`  :FzfMarks<CR>
nnoremap <silent> <leader>p :FzfCommands<CR>
nnoremap <silent> <F1> :FzfHelptags<CR>
inoremap <silent> <F1> <ESC>:FzfHelptags<CR>
cnoremap <silent> <expr> <C-p> getcmdtype() == ":" ? "<C-u>:FzfHistory:\<CR>" : "\<ESC>:FzfHistory/\<CR>"
cnoremap <silent> <C-_> <C-u>:FzfCommands<CR>

" fzf.Tags uses existing 'tags' file or generates it otherwise
nnoremap <silent> <leader>t :FzfTags<CR>
xnoremap <silent> <leader>t "zy:FzfTags <C-r>z<CR>

" fzf.BTags generate tags on-fly for current file
nnoremap <silent> <leader>T :FzfBTags<CR>
xnoremap <silent> <leader>T "zy:FzfBTags <C-r>z<CR>

" Show list of change in fzf
" Some code is borrowed from ctrlp.vim and tweaked to work with fzf
command FzfChanges call s:fzf_changes()
nnoremap <silent> <leader>; :FzfChanges<CR>

function! s:fzf_changelist()
  redir => result
  silent! changes
  redir END

  return map(split(result, "\n")[1:], 'tr(v:val, "	", " ")')
endf

function! s:fzf_changeaccept(line)
  let info = matchlist(a:line, '\s\+\(\d\+\)\s\+\(\d\+\)\s\+\(\d\+\).\+$')
  call cursor(get(info, 2), get(info, 3))
  silent! norm! zvzz
endfunction

function! s:fzf_changes()
  return fzf#run(fzf#wrap({
        \ 'source':  reverse(s:fzf_changelist()),
        \ 'sink': function('s:fzf_changeaccept'),
        \ 'options': '+m +s --nth=3..'
        \ }))
endfunction

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'
" }}}

" PLUGIN: vim-smooth-scroll {{{
noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 20, 2)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 20, 2)<CR>
noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 20, 4)<CR>
noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 20, 4)<CR>
" }}}

" PLUGIN: vim-commentary {{{

augroup aug_commentary
  au!

  " Tell how comment is marked depending on file type
  au FileType vim setlocal commentstring=\"\ %s
augroup end

" Comment line and move 1 line down
nmap <silent> <leader>c <Plug>CommentaryLine :normal j<CR>
xmap <leader>c <Plug>Commentary

" }}}

" PLUGIN: rhysd/clever-f.vim{{{

" Add highlighting for f/t searches
" Uses f/t to advance to next match instead of using ';' and ','
let g:clever_f_ignore_case = 1
let g:clever_f_smart_case = 1

" Use same highlighting group as a normal search
let g:clever_f_mark_char_color = 'IncSearch'

" Use ; character as a placeholder for any sign characters: {, (, "
let g:clever_f_chars_match_any_signs = ';'

" }}}

" PLUGIN: majutsushi/tagbar{{{
" nnoremap <silent> <F9> :TagbarToggle<CR>
let g:tagbar_autoclose = 0
let g:tagbar_autofocus = 1
let g:tagbar_compact = 1
let g:tagbar_foldlevel = 1
let g:tagbar_indent = 1
let g:tagbar_iconchars = ['▸', '▾']
let g:tagbar_silent = 1
" }}}

" PLUGIN: ludovicchabant/vim-gutentags{{{

let g:gutentags_define_advanced_commands = 1

" Enable only when tags file already exists
let g:gutentags_enabled = 0
if filereadable('./tags')
  let g:gutentags_enabled = 1
endif

" When enabled, force update tags file for all project
" When disabled, removed tags file
function s:GutentagsToggle()
  GutentagsToggleEnabled

  if g:gutentags_enabled
    GutentagsUpdate!
  else
    call system('rm -f ./tags')
  endif
endfunction

command! GutentagsToggle :call <SID>GutentagsToggle()
" nnoremap <silent> <F11> :GutentagsToggle<CR>

" Let user decide when to generate tags file for the project
" Don't do it automatically for any VCS repo
let g:gutentags_generate_on_missing = 0
let g:gutentags_generate_on_new = 0
" }}}

" PLUGIN: Raimondi/delimitMate{{{

" Turn autoclosing behavior on
let delimitMate_autoclose = 1

let g:delimitMate_expand_cr = 2
let g:delimitMate_expand_space = 1
let g:delimitMate_jump_expansion = 1
let g:delimitMate_balance_matchpairs = 1
let g:delimitMate_matchpairs = "(:),[:],{:}"
let g:delimitMate_nesting_quotes = ['`']

" Indeed we are going to exclude Comment and String syntax group names
" But turns out this plugin relies upon highlight groups rather than syntax group names
" So we have to use linked Dracula highlight groups instead
" NOTE: If you change current theme, this code should be updated as well
" https://github.com/Raimondi/delimitMate/issues/277#issuecomment-466780034
let g:delimitMate_excluded_regions = "DraculaYellow,DraculaComment"

" }}}

" PLUGIN" mattn/emmet-vim{{{
let g:user_emmet_leader_key = "<A-,>"
let g:user_emmet_mode = 'iv'

" Enable only for some file types
let g:user_emmet_install_global = 0
augroup aug_plugin_emmet
  au!

  autocmd FileType html,css EmmetInstall
  autocmd FileType html,css imap <C-j> <plug>(emmet-move-next)
  autocmd FileType html,css imap <C-k> <plug>(emmet-move-prev)
augroup END
" }}}

" PLUGIN: editorconfig/editorconfig-vim{{{
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

" Highlights when line exceeds allowed length (column 80 marker)
let g:EditorConfig_max_line_indicator = 'exceeding'
let g:EditorConfig_preserve_formatoptions = 1
" }}}

" PLUGIN: alvan/vim-closetag{{{
let g:closetag_xhtml_filenames = "*.xhtml,*.jsx"
let g:closetag_xhtml_filetypes = "xhtml,jsx"
" }}}

" PLUGIN: samoshkin/vim-mergetool{{{

function s:on_mergetool_set_layout(split)
  " Disable syntax and spell checking highlighting in merge mode
  setlocal syntax=off
  setlocal nospell

  " When base is horizontal split at the bottom
  " Turn off diff mode, and show syntax highlighting
  " Also let it take less height
  if a:split["layout"] ==# 'mr,b' && a:split["split"] ==# 'b'
    setlocal nodiff
    setlocal syntax=on
    resize 15
  endif
endfunction

let g:mergetool_layout = 'mr'
let g:mergetool_prefer_revision = 'local'
let g:MergetoolSetLayoutCallback = function('s:on_mergetool_set_layout')

nmap <leader>mt <plug>(MergetoolToggle)
nnoremap <silent> <leader>mb :call mergetool#toggle_layout('mr,b')<CR>

" }}}

" {{{ PLUGIN: suan/vim-instant-markdown

" NOTE: Requires 'npm i -g instant-markdown-d'
let g:instant_markdown_slow = 1
let g:instant_markdown_autostart = 0
" }}}

" {{{ Plugin junegunn/goyo.vim

let g:goyo_width = 90
nnoremap <silent> <F3> :Goyo<CR>

augroup aug_plug_goyo
  au!

  autocmd! User GoyoEnter Limelight
  autocmd! User GoyoLeave Limelight!
augroup END

let g:limelight_default_coefficient = 0.7
let g:limelight_priority = -1

" }}}

" Plugin: plasticboy/vim-markdown{{{

let g:vim_markdown_folding_style_pythonic = 1
let g:vim_markdown_toc_autofit = 1
let g:vim_markdown_new_list_item_indent = 0
let g:vim_markdown_no_extensions_in_markdown = 1
" Disable auto write/save, since we have general non-markdown specific mechanism
let g:vim_markdown_autowrite = 0

" TODO: create key mapping for :Toc

" }}}

" {{{ PLUGIN: dyng/ctrlsf.vim

let g:ctrlsf_auto_focus = { "at": "start" }
let g:ctrlsf_ignore_dir = g:search_ignore_dirs
let g:ctrlsf_regex_pattern = 1
let g:ctrlsf_case_sensitive = 'smart'
let g:ctrlsf_follow_symlinks = 1
let g:ctrlsf_selected_line_hl = 'po'
let g:ctrlsf_indent = 2

" Autoclose search pane in both normal and compact view
" o, <CR>, open file and close search pane
" O, open file and keep search pane
" n/N, navigate thru results and immediately open a preview
let g:ctrlsf_auto_close = {
      \ "normal" : 1,
      \ "compact": 1
      \ }
let g:ctrlsf_mapping = {
      \ "open": ["<CR>", "o"],
      \ "openb": "O",
      \ "next": { "key": "n", "suffix": ":norm O<CR><C-w>p" },
      \ "prev": { "key": "N", "suffix": ":norm O<CR><C-w>p" },
      \ }

" If ripgrep is available, use it
if executable('rg')
  let g:ctrlsf_ackprg = 'rg'
  let g:ctrlsf_extra_backend_args = {
        \ 'rg': '--hidden'
        \ }
endif

" Tweak search pane window options
function! g:CtrlSFAfterMainWindowInit()
  setlocal list
endfunction

" Commands and mappings
nnoremap <S-F8> :CtrlSFOpen<CR>
nnoremap <leader><F8> :call <SID>ctrlsf_search_quit()<CR>

" Stop searching, get back
function s:ctrlsf_search_quit()
  CtrlSFClose
  CtrlSFClearHL
  if exists("t:is_ctrlsf_tab")
    tabclose
  endif
endfunction

" }}}

" {{{ PLUGIN: RRethy/vim-hexokinase

" TODO: toggle shortcuts: HexokinaseToggle
let g:Hexokinase_refreshEvents = ['CursorHold', 'CursorHoldI', 'BufWritePost']
let g:Hexokinase_ftAutoload = ['css']
" two {u258B} unicode characters
let g:Hexokinase_signIcon = '▋▋'

" }}}

" {{{ PLUGIN: junegunn/easy-align

" Start interactive EasyAlign in visual mode (e.g. vipga)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
" Use :EasyAlign in command mode
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" Retain original "ga" behavior to print ASCII value of a character under the cursor
nnoremap <leader>ga ga

" Always ignore lines that do not have delimiter
let g:easy_align_ignore_unmatched = 1

" ----------------------------------------
" Cheatsheet:
" ----------------------------------------

" Commands:
" ga{text_object} {delimiter_rule}
" v{motion_or_text_object}ga {delimiter_rule}
" :EasyAlign[!] [N-th] DELIMITER_KEY [OPTIONS]
" :EasyAlign[!] [N-th] /REGEXP/ [OPTIONS]
" :EasyAlign

" delimiter_rule = [nth_delimiter] [key_or_regex] [options]

" [nth_delimiter] = 1,2,*(all delimiters),**(left-rigth alternating alignment),-1,-2(last Nth delimiter)

" [key] = <Space>, = : . , | & # "
" [key] = <C-x> /regex/

" Options (interactive mode):
" - <C-p>, live interactive mode with instant preview
" - <CR>, cycle through LEFT|CENTER|RIGHT alignment for text between delimiters
" - <C-f>, filter and align lines matching pattern g/pattern/ or v/pattern/
" - <C-l>, <C-r>, specify left/right margin
" - <Down>, reset all margins to zero
" - <Left>/<Right>, stick to left or right
" - <C-u>, whether to ignore lines without delimiters or not
" - <C-g>, whether to ignore delimiters found in "Comment" and "String" syntax groups
" - <C-I>, whether original indentation of lines should be changed

" }}}

" {{{ PLUGIN: sheerun/vim-polyglot

" JS: https://github.com/pangloss/vim-javascript
" JSX: https://github.com/mxw/vim-jsx
" Set "javascript.jsx" filetype only for files with .jsx extension
let g:jsx_ext_required = 1

" }}}

" {{{ PLUGIN: mattn/gist-vim

" :Gist, create a public gist
" :Gist -p, create a private gist
" :Gist -l, list my gists
" :Gist -l mattn, list gist from user @mattn
" :Gist -m, create multifile gist from all open buffers
" :Gist -d, delete the Gist (provided that you've opened the Gist buffer)
" :Gist XXXXX, get Gist by ID
" :Gist -b, open Gist in browser after you post it or updated

" Mappings in Gist listing window:
" -y, copy the contents of Gist to the clipboard
" -<CR>, o, open Gist in a buffer and close listing
" -p, paste contents of the Gist in the buffer from which gist-vim listing was called
" -b, open Gist in the browser
let g:gist_open_browser_after_post = 1
let g:gist_show_privates = 1

" }}}

" {{{ PLUGIN: w0rp/ale

" Enable linting, disable completion
let g:ale_enabled = 1
let g:ale_completion_enabled = 0

" What triggers linting automatically
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_on_save = 1
let g:ale_lint_on_enter = 1
let g:ale_lint_on_filetype_changed = 1

" Increase delay after which linters are running after text is changed
let g:ale_lint_delay = 500

" Mappings
" :ALELint, lint once manually
" :ALEToggleBuffer, toggle ALE for individual buffer
" :ALEToggle, toggle ALE for all buffers
" :ALEReset, remove all linting errors, but do not disable linting
nmap <F10> <Plug>(ale_toggle_buffer)
nmap <S-F10> <Plug>(ale_reset)
nmap <leader><F10> <Plug>(ale_fix)

" Show marks in sign column
let g:ale_set_signs = 1
let g:ale_sign_column_always = 1
let g:ale_change_sign_column_color = 0

" Use same symbol for error and warnings, but use different colours
" See highlight groups: ALEErrorSign, ALEWarningSign
let g:ale_sign_error = ""
let g:ale_sign_warning = ""
let g:ale_sign_info = ""

" Echo truncated error message when cursor is near error
" Do not display preview window with full message when cursor is near error
" :ALEDetail, show full linter message in a preview window
let g:ale_echo_cursor = 1
let g:ale_cursor_detail = 0

" Configure error message format
let g:ale_echo_msg_error_str = ""
let g:ale_echo_msg_warning_str = ""
let g:ale_echo_msg_info_str = ""
let g:ale_echo_msg_format = '%severity% [%linter%%: code%] %s'
let ale_loclist_msg_format = '[%linter%%: code%] %s'

" Use loclist to report errors, but do not open automatically
let g:ale_open_list = 0
let g:ale_set_loclist = 1
let g:ale_set_quickfix = 0
let g:ale_keep_list_window_open = 0

" Set error highlights for erroneous code
" See ALEError, ALEWarning, ALEInfo highlights
let g:ale_set_highlights = 1

" Configure linter tools per file type
let g:ale_linters = {
      \ 'javascript': ['eslint'],
      \ }

" ESlint integration
" Do not report errors when there's no .eslintrc config file
" Do not report errors for files which are ignored by .eslintignore
let g:ale_javascript_eslint_suppress_missing_config = 1
let g:ale_javascript_eslint_suppress_eslintignore = 1

" vim-airline + ALE integration
let g:airline#extensions#ale#enabled = 1
let airline#extensions#ale#error_symbol = " "
let airline#extensions#ale#warning_symbol = " "

" Reduce linter's process priority. Nice value is in range -20(highest priority) to 20(lowest priority)
let g:ale_command_wrapper = 'nice -n10'

" Stop linting when file size is bigger than 96Kbytes
let g:ale_maximum_file_size = 98304

" Remember up to 5 most recent linting command output
let g:ale_history_enabled = 0
let g:ale_max_buffer_history_size = 20

" Do not warn about trailing whitespaces, as we highlight them manually
" NOTE: errors comes from selected linter program, and are not produced by ALE itself
let g:ale_warn_about_trailing_whitespace = 0
let g:ale_warn_about_trailing_blank_lines = 1

" Declare list of available fixers
" Remove trailing lines and trim traling whitespaces as default fixers
" File specific fixers (e.g. prettier) would be declared in respective ftplugin files
let g:ale_fixers = {
      \   '*': ['trim_whitespace', 'remove_trailing_lines'],
      \   'diff': [],
      \   'fugitive': [],
      \   'help': [],
      \   'qf': [],
      \   'ctrlsf': [],
      \   'css': ['prettier'],
      \   'javascript': ['prettier'],
      \   'json': ['prettier'],
      \   'yaml': ['prettier'],
      \   'scss': ['prettier'],
      \   'less': ['prettier'],
      \   'markdown': ['remove_trailing_lines']
      \}

" Override ALE options based on Glob pattern (as opposite to filetype only)
" Do not lint and fix minified JS and CSS files
let g:ale_pattern_options_enabled = 1
let g:ale_pattern_options = {
      \ '\.min\.js$': {'ale_linters': [], 'ale_fixers': []},
      \ '\.min\.css$': {'ale_linters': [], 'ale_fixers': []},
      \}

" Whether to fix formatting automatically on save, text changed and insert leave
let g:perform_auto_format = 1

" Toggle auto format setting
command -nargs=0 ToggleAutoFormat let b:perform_auto_format = 0

augroup aug_ale
  au!

  " Auto fix on saving buffer to file
  " NOTE: do not use "ale_fix_on_save" option, because we have some custom tweaks
  au BufWritePre * call ReformatBuffer(1)

  " Auto fix on any text change and when we're leaving insert mode
  " NOTE: Do it asynchronously to ensure we're in a Normal mode before applying formatting
  " Some plugins like "Raimondi/delimitMate" jump out of an Insert mode quickly to perform <CR>, <BS>, <SPACE> expansion
  " We don't want to apply formatting at those moments, only when user leaves Insert mode manually
  au InsertLeave,TextChanged * call timer_start(50, 'ReformatBuffer')
augroup END

function ReformatBuffer(timer)
  " Apply formatting only if we're in a Normal mode
  if s:get_var('perform_auto_format') && mode('full') ==? 'n' && &modifiable

    " Join fix/formatting changes with last user changes in a single undo block
    " otherwise next "u" command will undo only formatting changes
    silent! undojoin
    ALEFix
  endif
endfunction

" Get prettier command to use with "formatprg"
" formatprg" is used by "gq" command to apply formattings
" NOTE: not used right now
function GetPrettierAsFormatPrg()
  " Set correct file path/file name, so prettier can infer the right parser (JS, JSON, HTML, etc)
  return "prettier\\ --stdin\\ --stdin-filepath=" . fnameescape(expand('<afile>:p:.'))
endfunction

" Create new ALE fixer: Fix spaces vs tabs indentations
" NOTE: not used right now
function! RetabForALE(buffer, lines) abort
  let l:index = 0
  let l:lines_new = range(len(a:lines))

  for l:line in a:lines
    let l:lines_new[l:index] = substitute(l:line, '^\s\+', printf('\=Indenting(submatch(0), %d, %d)', &expandtab, &tabstop), 'e')
    let l:index = l:index + 1
  endfor

  return l:lines_new
endfunction

" }}}
