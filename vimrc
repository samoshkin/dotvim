" General options{{{

" Should be first, use vim settings rather than vi settings
set nocompatible
filetype plugin indent on

" Ask before unsafe actions
set confirm

set shell=/bin/bash
set encoding=utf-8
set number

" Whitespaces and tabs
set tabstop=2 softtabstop=2 shiftwidth=2 expandtab
" Use shiftwidth for tab with at the BOL, and tabstop in other places
" Otherwise, tabstop is used always. Shiftwidth is only used for >>
set smarttab

" Let buffer be switched to another one without requiring to save it first
set hidden

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
let maplocalleader=","

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
augroup aug_cursor_line
  au!
  au InsertEnter * setlocal nocursorline
  au InsertLeave * setlocal cursorline
augroup END

" Disable reading vim variables & options from special comments within file header or footer
set modelines=0

" Display uncompleted commands in the status line
set showcmd

" Show ruler
set ruler

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
set autoindent
set smartindent
set pastetoggle=<F2>

" Experimental
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

" Do not use arrows
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

endif

function s:Noop()
endfunction

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
  Plug 'svermeulen/vim-cutlass'
  Plug 'svermeulen/vim-subversive'
  Plug 'svermeulen/vim-yoink'
  Plug 'samoshkin/vim-lastplace'
  Plug 'rhysd/clever-f.vim'
  Plug 'ryanoasis/vim-devicons'
  " Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
  Plug 'vim-scripts/CursorLineCurrentWindow'
  Plug 'majutsushi/tagbar'
  Plug 'Valloric/ListToggle'
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

fun s:PatchColorScheme()
  hi! ColorColumn ctermfg=255 ctermbg=203 guifg=#F8F8F2 guibg=#FF5555

  " Show NERDTree directory nodes in green
  hi! __DirectoryNode cterm=bold ctermfg=106 gui=bold guifg=#9AC83A
  hi! link NerdTreeDir __DirectoryNode
  hi! link NERDTreeFlags __DirectoryNode

  " Show NERDTree toggle icons as white
  hi! link NERDTreeOpenable Normal
  hi! link NERDTreeClosable Normal

  " Do not highlight changed line, highlight only changed text within a line
  hi! DiffText term=NONE ctermfg=215 ctermbg=233 cterm=NONE guifg=#FFB86C guibg=#14141a gui=NONE
  hi! link DiffChange NONE
  hi! clear DiffChange
endf

" Customime color scheme after it was loaded
augroup aug_color_scheme
  au!

  autocmd ColorScheme * call s:PatchColorScheme()
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


" Duplicate lines or selection
vnoremap <silent> <localleader>d "zy`>"zp
nnoremap <silent> <localleader>d :<C-u>execute 'normal! "zyy' . v:count1 . '"zp'<CR>

" Delete line without storing in clipboard
nnoremap <silent> K :d _<CR>

" Join lines and keep the cursor in place
nnoremap J mzJ`z

" Split line (opposite to join lines)
nnoremap M :call <SID>split_line()<CR>

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
endfunction


" Add blank line above and below
" When adding line below, move cursor to the just added line (most likely you're going to edit next)
" When adding line above, don't move cursor at all
nnoremap <expr> <CR> &buftype ==# 'quickfix' ? "\<CR>" : "o\<ESC>"
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
" <Home> and <End> mapping don't work, until I find the solution with wrong tmux $TERM type
nnoremap <Home> g<Home>
noremap  <End>  g<End>

" TODO: ensure keys are not overridden when pumvisible()
" See https://vim.fandom.com/wiki/Move_cursor_by_display_lines_when_wrapping
inoremap <silent> <Down> <C-o>gj
inoremap <silent> <Up> <C-o>gk
" <Home> and <End> mapping don't work, until I find the solution with wrong tmux $TERM type
inoremap <silent> <Home> <C-o>g<Home>
inoremap <silent> <End>  <C-o>g<End>

" Toggle between 'nowrap' and 'soft wrap'
noremap <silent> <F6> :set wrap!<CR>

" Format options
" Remove most related to hard wrapping
" Use autocommand to override defaults from $VIMRUNTIME/ftplugin
augroup aug_format_options
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
set wrapscan

" Turn on hlsearch to highlight all matches during incremental search
" Use <C-j> and <C-k> to navigate through matches instead of <C-d>,<C-t>
" Pitfall: Works only in vim8. CmdlineEnter and CmdlineLeave appeared in vim8
augroup aug_search
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
nnoremap n nzvzz
nnoremap N Nzvzz
nnoremap * *zvzz
nnoremap # #zvzz

function! s:search_from_context(direction, context)
  let text = a:context ==# 'word' ? expand("<cword>") : s:get_selected_text()
  let text = substitute(escape(text, a:direction . '\'), '\n', '\\n', 'g')
  let @/ = '\V' . text

  call feedkeys(a:direction . "\<C-R>=@/\<CR>\<CR>")
endfunction

" Make '*' and '#' search for a selection in visual mode
" Inspired by https://github.com/nelstrom/vim-visual-star-search
" Plus center search results, same as we do in normal mode
vnoremap * :<C-u>call <SID>search_from_context("/", "selection")<CR>zz
vnoremap # :<C-u>call <SID>search_from_context("?", "selection")<CR>zz

" Shortcuts for substitute as ex command
nnoremap <C-s> :%s/
vnoremap <C-s> :s/

" }}}

" {{{ Project-wide search with Grep

" Use ripgrep instead of GNU grep for 'grepprg'
if executable("rg")
  set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case\ --hidden\ --follow\ --glob\ \"!.git/*\"
  set grepformat=%f:%l:%c:%m
endif

" Project wide search using 'grepprg'
function s:grep_search(is_relative, text)
  " Change cwd temporarily if should search relative to current file
  if a:is_relative
    let cwdb = getcwd()
    exe "lcd " . expand("%:p:h")
  endif

  " Set global mark to easily get back after we're done with a search
  normal mF

  " Perform search
  silent! exe "grep! " . a:text

  " If matches are found, open quickfix list and focus first match
  " Do not open with copen, because we have qf list automatically open on search
  if len(getqflist())
    cc
    redraw!
  else
    cclose
    redraw!

    echohl WarningMsg
    echom "No match found for: " . a:text
    echohl None
  endif

  " Restore cwd back
  if a:is_relative
    exe "lcd " . cwdb
  endif
endfunction

" Perform a project wide search using predefined search text: current word or selection
function! s:project_wide_search(context, command) range
  let text = a:context ==# 'word' ? expand("<cword>")
        \ : a:context ==# 'selection' ? s:get_selected_text()
        \ : ''
  let args = ''

  " Remove new lines (when several lines are visually selected)
  let text = substitute(text, "\n", "", "g")

  if a:command ==# "Grep"
    " put in quotes
    let text = escape(text, '"')
    let text = empty(text) ? text : '"' . text . '"'

    " Do not use regular expression search pattern comes from context
    if !empty(text)
      let args = ' -F'
    endif
  endif

  if a:command ==# 'FzfRg'
    " Escape backslash
    let text = escape(text, '\')
  endif

  " Put actual command in a command line, but do not execute
  " User would initiate a search manually with <CR>
  call feedkeys(":" . a:command . args . " " . text)
endfunction

" Without bang, search is relative to cwd, otherwise relative to current file
command -nargs=* -bang -complete=file Grep :call s:grep_search(<bang>0, <q-args>)

" Project-wide search mappings

" Using :Grep and grepprg
nnoremap <F7> :call <SID>project_wide_search("", "Grep")<CR>
nnoremap <S-F7> :call <SID>project_wide_search("word", "Grep")<CR>
vnoremap <silent> <F7> :call <SID>project_wide_search("selection", "Grep")<CR>
" TODO: with the last search pattern
" TODO: search within buffers/args

" Using fzf-vim + Rg
nnoremap <leader><F7> :call <SID>project_wide_search("", "FzfRg")<CR>
nnoremap <leader><S-F7> :call <SID>project_wide_search("word", "FzfRg")<CR>
vnoremap <silent> <leader><F7> :call <SID>project_wide_search("selection", "FzfRg")<CR>

" TODO: ctrlsf.vim

" }}}

" {{{ Project-wide find files

" Similar to built-in grepprg, makeprg
let g:findprg = executable('fd') ? 'fd --hidden' : 'find .'

" Find commands. View results in quickfix list, scratch buffer or args list
command -nargs=* -bang Find :call s:project_wide_find(<q-args>, 'qf')
command -nargs=* -bang FindB :call s:project_wide_find(<q-args>, 'buffer')
command -nargs=* -bang FindA :call s:project_wide_find(<q-args>, 'args')

" Do not expose keyboard mappings, it does not add much value

" Execute 'findprg' via system() call and return list of files
function s:execute_findprg(command)
  let output = system(g:findprg . " " . a:command)
  return split(output, "\n")
endfunction

" Execute find command and render results in selected view
function s:project_wide_find(command, view_in)
  let files = s:execute_findprg(a:command)
  if empty(files)
    call s:echo_warning('No files found')
    return
  endif

  " Set global mark to easily get back after we're done with a search
  normal mF

  if a:view_in ==# 'qf'
    call s:set_qf_list_with_files(l:files, "Find: " . a:command)
  endif

  if a:view_in ==# 'buffer'
    call s:new_scratch_buffer(l:files, "Find: " . a:command)
  endif

  if a:view_in ==# 'args'
    call s:set_args_list_with_files(l:files, 1)
  endif
endfunction

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

" }}}

" Insert mode{{{

" Drop into insert mode on Backspace
nnoremap <BS> i<BS>

" In Insert mode, treat pasting form a buffer as a separate undoable operation
" Which can be undone with '<C-o>u'
inoremap <C-r> <C-g>u<C-r>

" Use <C-v> instead of <C-r>
" Yes we're overriding <C-v> normal behavior, and unable to use some registers
" In these rare cases, resort back to <C-r>
imap <C-v> <C-r>

" p/P, paste with formatting, due to 'g:yoinkAutoFormatPaste=1'
imap <C-v>p <ESC>pi
imap <C-v>P <ESC>Pi

" <C-v>v, paste verbatim, by entering Paste mode
imap <C-v>v <F2><C-r>+<F2>

" Retain original <C-v> behavior, insert character by code
" 'c' for character
inoremap <C-v>c <C-v>

" Insert digraph, 'd' for digraph
inoremap <C-v>d <C-k>

" }}}

" Clipboard{{{

" Using these plugins:board
" - https://github.com/svermeulen/vim-cutlass
" - https://github.com/svermeulen/vim-subversive
" - https://github.com/svermeulen/vim-yoink

" always use system clipboard as unnamed register
set clipboard=unnamed,unnamedplus

" Reselect text that was just pasted
nnoremap <expr> g<C-v> '`[' . getregtype()[0] . '`]'

" Use 'x' as cut operation instead
" All other actions, like d, c, s will delete without storing in clipboard
nnoremap x d
nnoremap xx dd
nnoremap X D
xnoremap x d

" Retain original x and X behavior
" when we want to remove single character without entering insert mode
nnoremap <localleader>x "_x
nnoremap <localleader>X "_X

" Normalize Y behavior to yank till the end of line
nnoremap Y y$

" Preserve cursor position after yank operation
nmap y <plug>(YoinkYankPreserveCursorPosition)
xmap y <plug>(YoinkYankPreserveCursorPosition)

" 'Use 's' as 'substitute' action, not as a shortcut to 'change' action
nmap s <plug>(SubversiveSubstitute)
nmap ss <plug>(SubversiveSubstituteLine)
" Don't remap S as exception, use it to split lines (counterpart to join lines)
nmap S <plug>(SubversiveSubstituteToEndOfLine)
xmap s <plug>(SubversiveSubstitute)

" In visual mode, regular 'put' operation actually does a substitution
" After remapping we can cycle through yank ring provided by 'vim-yoink' with <C-p> and <C-n>
xmap p <plug>(SubversiveSubstitute)
xmap P <plug>(SubversiveSubstitute)

" Substitute operation performed multiple times for a given text range
nmap <leader>s <plug>(SubversiveSubstituteRange)
nmap <leader>ss <plug>(SubversiveSubstituteWordRange)
xmap <leader>s <plug>(SubversiveSubstituteRange)

" Store text that being substituted in register 'r'
let g:subversiveCurrentTextRegister='r'

" Normally cursor remains in place during paste
" Move it to the end, so it's easy to start editing
let g:yoinkMoveCursorToEndOfPaste=1

" Auto formatting on paste, and be able to toggle formatting on/off
" Replaces the need for 'vim-pasta' plugin
let g:yoinkAutoFormatPaste=1
nmap <leader>= <plug>(YoinkPostPasteToggleFormat)

" For integration with 'svermeulen/cutclass'
let g:yoinkIncludeDeleteOperations=1

" Navigation through yank ring
nmap <C-p> <plug>(YoinkPostPasteSwapBack)
nmap <C-n> <plug>(YoinkPostPasteSwapForward)

nmap p <plug>(YoinkPaste_p)
nmap P <plug>(YoinkPaste_P)

" Copy file basename only
" Copy full file path
" Copy file's dirname
nnoremap <localleader>fn :let @+ = expand("%:t") \| echo 'Copied to clipboard: ' . @+<CR>
nnoremap <localleader>fp :let @+ = expand("%:p:~") \| echo 'Copied to clipboard: ' . @+<CR>
nnoremap <localleader>fd :let @+ = expand("%:p:~:h") \| echo 'Copied to clipboard: ' . @+<CR>

" }}}

" Folding ---------------------------------------------------------{{{

set foldenable
set foldmethod=marker
set foldlevelstart=0
set foldcolumn=1
set foldopen-=block
set foldopen+=jump

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

" }}}

" Windows,buffers,tabs  {{{

" Navigate buffers
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [b :bprev<CR>

" Kill buffer
nnoremap <silent> <leader>k :bd!<CR>

" Navigate between windows
noremap <silent> <C-k> :wincmd k<CR>
noremap <silent> <C-j> :wincmd j<CR>
noremap <silent> <C-h> :wincmd h<CR>
noremap <silent> <C-l> :wincmd l<CR>


" Tab navigation
nnoremap <silent> <leader>1 :tabnext 1<CR>
nnoremap <silent> <leader>2 :tabnext 2<CR>
nnoremap <silent> <leader>3 :tabnext 3<CR>
nnoremap <silent> <leader>4 :tabnext 4<CR>
nnoremap <silent> <leader>5 :tabnext 5<CR>
nnoremap <silent> <leader>9 :tablast<CR>
nnoremap <silent> ]<Tab> :tabnext<CR>
nnoremap <silent> [<Tab> :tabprev<CR>

" Tab management
nnoremap <silent> <leader>+ :tabnew<CR>:edit .<CR>
nnoremap <silent> <leader>_ :tabonly<CR>
nnoremap <silent> <leader>- :tabclose<CR>
nnoremap <silent> <leader>0 :only<CR>

" Open splits right and below
" Try these mappings, if | and _ are not OK
set splitbelow
set splitright
nnoremap <silent> _ :split<CR>
nnoremap <silent> \| :vsplit<CR>

" Save and quit for single buffer
command QuitWindow call s:QuitWindow()
nnoremap <silent> <leader>w :update!<CR>
nnoremap <silent> <leader>q :QuitWindow<CR>
nnoremap ZZ :update! \| QuitWindow<CR>
cnoreabbrev q QuitWindow

" Save and quit for multiple buffers
nnoremap <silent> <leader>W :wall<CR>
nnoremap <silent> <leader>Q :confirm qall<CR>
nnoremap <silent> ZX :confirm xall<CR>

" Additional <C-w> mappings
" <C-w>T, moves window to a new tab
" <C-w>t, copies window to a new tab
" NOTE: Hides original <C-w>t behavior to move to the topmost window
nnoremap <C-w>t :tab split<CR>

" Maximize window
" Use '\=' to make window sizes equal
nnoremap <C-w><Bslash> <C-w>_<C-w>\|

" Resize windows in steps greather than just 1 column at a time
let _resize_factor = 1.2
nnoremap <C-w>> :exe "vert resize " . float2nr(round(winwidth(0) * _resize_factor))<CR>
nnoremap <C-w>< :exe "vert resize " . float2nr(round(winwidth(0) * 1/_resize_factor))<CR>
nnoremap <C-w>+ :exe "resize " . float2nr(round(winheight(0) * _resize_factor))<CR>
nnoremap <C-w>- :exe "resize " . float2nr(round(winheight(0) * 1/_resize_factor))<CR>

" Cycle between main and alternate file
nnoremap <C-w><Tab> <C-^>zz

" Use <Bslash> instead of <C-w>, which is tough to type
nmap <Bslash> <C-w>

augroup aug_window_management
  au!

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
  if get(s:, 'is_started_as_vim_diff', 0)
    qall
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
  exe "file! " . title

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

" Indicate we have a fast terminal connection. Improves smooth redrawing
set ttyfast

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
  let s:is_started_as_vim_diff = 1
endif

augroup aug_diffs
  au!

  " Inspect whether some windows are in diff mode, and apply changes for such windows
  " Run asynchronously, to ensure '&diff' option is properly set by Vim
  au WinEnter,BufEnter * call timer_start(50, 'CheckDiffMode')

  " Highlight VCS conflict markers
  au VimEnter,WinEnter * if !exists('w:_vsc_conflict_marker_match') |
        \   let w:_vsc_conflict_marker_match = matchadd('ErrorMsg', '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$') |
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
nmap <expr> <Up> &diff ? '[c' : '<Up>'
nmap <expr> <Down> &diff ? ']c' : '<Down>'

" Change :diffsplit command to open diff in new tab
cnoreabbrev <expr> diffsplit getcmdtype() == ":" && getcmdline() == 'diffsplit' ? 'tab split \| diffsplit' : 'diffsplit'
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
augroup aug_session_management
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

" Autosave and backup{{{

" Features defaults:
" - autosave: off
" - backup: off
" - undofile: on
" - swapfile: on

" Regarding autosaving:
" - "autowrite" saves file on buffer change and quit
" - '907th/vim-auto-save' saves file on given events (TextChanged, InsertLeave, CursorHold)

set noautowrite

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

nnoremap <F10> :AutoSaveToggle<CR>

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
set spellfile=~/.vim/spell/dict.utf-8.add

" Automatically fix last misspelled word by picking first suggestion
inoremap <C-S>f <C-G>u<Esc>[s1z=gi<C-G>u

" Select previous misspelled word, and drop in Select mode
" In insert mode, we usually don't care about next misspelled word
inoremap <C-S>s <Esc>[sve<C-G>

" In normal mode, select next/previous misspelled word, and drop in Select mode
nnoremap <localleader>ss ]sve<C-G>
nnoremap <localleader>sS [sve<C-G>

" In normal mode, fix misspelled next/prev word by picking up first suggestion
nnoremap <localleader>sf ]s1z=
nnoremap <localleader>sF [s1z=

" }}}

" Quickfix and Location list{{{

" <F5> for quickfix list
nmap <F5><F5> <Plug>(qf_qf_toggle)
nmap <S-F5> <Plug>(qf_qf_switch)
nnoremap <silent> <F5>r :call <SID>qf_loc_reload_list('qf')<CR>
nnoremap <silent> <F5>l :call <SID>qf_loc_set_files_only('qf')<CR>
nnoremap <silent> <F5>[ :call <SID>qf_loc_history_navigate('colder')<CR>
nnoremap <silent> <F5>] :call <SID>qf_loc_history_navigate('cnewer')<CR>
nnoremap <silent> <leader><F5> :call <SID>qf_loc_quit('qf')<CR>

" <F6> for location list
nmap <F6><F6> <Plug>(qf_loc_toggle)
nmap <S-F6> <Plug>(qf_loc_switch)
nmap <silent> <F6>r :call <SID>qf_loc_reload_list('loc')<CR>
nmap <silent> <F6>l :call <SID>qf_loc_set_files_only('loc')<CR>
nnoremap <silent> <F6>[ :call <SID>qf_loc_history_navigate('lolder')<CR>
nnoremap <silent> <F6>] :call <SID>qf_loc_history_navigate('lnewer')<CR>
nmap <silent> <leader><F6> :call <SID>qf_loc_quit('loc')<CR>

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
nnoremap <silent> ]l :<C-u>call <SID>qf_loc_list_navigate("lnext")<CR>
nnoremap <silent> [l :<C-u>call <SID>qf_loc_list_navigate("lprev")<CR>
nnoremap <silent> ]L :<C-u>call <SID>qf_loc_list_navigate("llast")<CR>
nnoremap <silent> [L :<C-u>call <SID>qf_loc_list_navigate("lfirst")<CR>
nnoremap <silent> ]<C-l> :<C-u>call <SID>qf_loc_list_navigate("lnfile")<CR>
nnoremap <silent> [<C-l> :<C-u>call <SID>qf_loc_list_navigate("lpfile")<CR>

" Remove single item from quickfix/loc list using conditional '-' key mapping
nnoremap <Plug>QfRemoveCurrentItem :<C-U>call <SID>qf_loc_remove_current_item('qf')<CR>
nnoremap <Plug>LocRemoveCurrentItem :<C-U>call <SID>qf_loc_remove_current_item('loc')<CR>
nmap <silent> <expr> - qf#IsLocWindowOpen(0) ? '<Plug>LocRemoveCurrentItem'
      \ : qf#IsQfWindowOpen() ? '<Plug>QfRemoveCurrentItem' : '-'

augroup aug_quickfix_list
  au!

  " Remember cursor position before running quickfix cmd
  " Disable folding
  autocmd QuickFixCmdPre [^l]* set nofoldenable | normal mQ
  autocmd QuickFixCmdPre    l* set nofoldenable | normal mL
augroup END

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
  " Restore folding back
  set foldenable

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

" Build new derived qf/loc list which contains only filenames
function s:qf_loc_set_files_only(list_type)
  if a:list_type ==# 'qf'
    let files = s:qf_loc_get_files(getqflist())
    call s:set_qf_list_with_files(files, 'Files Only')
  else
    let files = s:qf_loc_get_files(getloclist(0))
    call s:set_loc_list_with_files(files, 'Files Only')
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

" Create new quickfix list with a list of files
function s:set_qf_list_with_files(files, title)
  " Map file names to format, as understood by 'errorformat' (similar to grepformat)
  cexpr map(a:files, 'v:val . ":1:" . fnamemodify(v:val, ":t")')

  " Set QF window title
  if !empty(a:title)
    call setqflist([], 'r', { 'title': a:title })
  endif
endfunction

" Create new location list with a list of files
function s:set_loc_list_with_files(files, title)
  " Map file names to format, as understood by 'errorformat' (similar to grepformat)
  lexpr map(a:files, 'v:val . ":1:" . fnamemodify(v:val, ":t")')

  " Set location list window title
  if !empty(a:title)
    call setloclist(0, [], 'r', { 'title': a:title })
  endif
endfunction

" Get unique list of file names in a quick list
function s:qf_loc_get_files(list)
  return map(uniq(map(a:list, 'v:val["bufnr"]')), 'bufname(v:val)')
endfunction

" }}}

" {{{ Args list

" Navigation over args list
nnoremap <silent> ]a :next<CR>
nnoremap <silent> [a :prev<CR>
nnoremap <silent> ]A :last<CR>
nnoremap <silent> [A :first<CR>

function s:args_get_files()
  let i = 0
  let files = []
  while i < argc()
    call add(l:files, argv(i))
    let i = i + 1
  endwhile

  return l:files
endfunction

" Populate args with a list of files
function s:set_args_list_with_files(files, should_edit_first_arg)
  %argdelete
  for l:file in a:files
    exe "argadd " . l:file
  endfor

  if a:should_edit_first_arg
    argument 1
  else
    echo "Args list is set"
  endif
endfunction

" }}}

" {{{ QF vs Buffer vs Args conversion

" Convert between quickfix list <-> scratch buffer <-> args list
command -nargs=0 Buffer2Qf call <SID>convert_buffer_to_quickfix()
command -nargs=0 Buffer2Args call <SID>convert_buffer_to_args()
command -nargs=0 Qf2Buffer call <SID>convert_quickfix_to_buffer()
command -nargs=0 Qf2Args call <SID>convert_quickfix_to_args()
command -nargs=0 Args2Qf call <SID>convert_args_to_quickfix()
command -nargs=0 Args2Buffer call <SID>convert_args_to_buffer()

function s:convert_buffer_to_quickfix()
  let lines = getline(1, '$')
  let title = bufname('%')
  bdelete
  call s:set_qf_list_with_files(lines, title)
endfunction

function s:convert_buffer_to_args()
  let lines = getline(1, '$')
  bdelete
  call s:set_args_list_with_files(lines, 0)
endfunction

function s:convert_quickfix_to_buffer()
  let files = s:qf_loc_get_files(getqflist())
  call s:new_scratch_buffer(files, 'From Quickfix', 'rightbelow new')
  call qf#toggle#ToggleQfWindow(0)
endfunction

function s:convert_quickfix_to_args()
  let files = s:qf_loc_get_files(getqflist())
  call s:set_args_list_with_files(files, 0)
endfunction

function s:convert_args_to_buffer()
  let files = s:args_get_files()
  call s:new_scratch_buffer(files, 'From Args', 'rightbelow new')
endfunction

function s:convert_args_to_quickfix()
  let files = s:args_get_files()
  call s:set_qf_list_with_files(files, 'From Args')
endfunction

" }}}

" Misc{{{

" Check if files are changed outside and prompt to reload
" noremap <F5> :checktime<cr>
" inoremap <F5> <esc>:checktime<cr>

" Expand '%%' for directory of current file in command line mode
cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>

" Apply '.' repeat command for selected each line in visual mode
vnoremap . :normal .<CR>

" Shortcut command to 'vim-scripts/SyntaxAttr.vim'
command ViewSyntaxAttr call SyntaxAttr()

" Get visually selected text
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
let airline#extensions#tagbar#enabled = 0

" 'obsession' extension
function! GetObsessionStatus()
  return ObsessionStatus('ⓢ' . s:spc, '')
endfunction

call airline#parts#define_function('_obsession', 'GetObsessionStatus')
call airline#parts#define_accent('_obsession', 'bold')

" 'gutentags' extensions
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

" Diff or merge indicator
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

function! AirlineAutosavePart()
  return s:get_var('auto_save', 0) ? '' . s:spc : ''
endfunction

call airline#parts#define_function('_autosave', 'AirlineAutosavePart')

" Modified indicator
" Show only modified [+] indicator colored, not the whole file name
call airline#parts#define_raw('modified', '%m')
call airline#parts#define_accent('modified', 'orange')

" 'ffenc' extension
" Do not show default encoding. Show only when does not match given string
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'

" hunks' extension
let g:airline#extensions#hunks#non_zero_only = 1

" buffer number, show only for diff windows
" NOTE: use define_function() instead of define_raw() because raw does not work with condition
function! AirlineBufnrPart()
  return bufnr('') . ':'
endfunction

call airline#parts#define_function('bufnr', 'AirlineBufnrPart')
call airline#parts#define_condition('bufnr', "&diff")

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

" Do not show live word count
let g:airline#extensions#wordcount#enabled = 0

" Whitespace extension
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
let NERDTreeWinSize=40

" Automatically delete buffer when file is deleted from the tree explorer
let NERDTreeAutoDeleteBuffer=1

" Toggle tree visibility
noremap <F2> :NERDTreeToggle<CR>

" Locate current file in a tree
noremap  <S-F2> :NERDTreeFind<CR>
inoremap <S-F2> <esc>:NERDTreeFind<CR>

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
  autocmd FileType nerdtree setlocal nocursorline
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

" Plugin 'tiagofumo/vim-nerdtree-syntax-highlight'
" Adds syntax highlighting for common filie extensions
" Works with devicons to highlight only icons

" We can highlight folders
" let g:NERDTreeHighlightFolders = 0 " enables folder icon highlighting using exact match
" let g:NERDTreeHighlightFoldersFullName = 0 " highlights the folder name
" let g:NERDTreeExactMatchHighlightColor = {} " this line is needed to avoid error
" let g:NERDTreeExactMatchHighlightColor['tmp'] = "689FB6"
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
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Add namespace for fzf.vim exported commands
let g:fzf_command_prefix = 'Fzf'

" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

" File path completion in Insert mode using fzf
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-buffer-line)

" Open directory explorer at cwd
nmap <silent> <leader>O :edit .<CR>

nnoremap <silent> <expr> <leader>o (expand('%') =~ 'NERD_tree' ? "\<C-w>\<C-w>" : '').":FzfFiles\<CR>"
cnoremap <silent> <C-p>  :FzfHistory:<CR>
cnoremap <silent> <C-_> <ESC>:FzfHistory/<CR>
nnoremap <silent> <leader>b  :FzfBuffers<CR>
nnoremap <silent> <leader>`  :FzfMarks<CR>
nnoremap <silent> <F1> :FzfHelptags<CR>
inoremap <silent> <F1> <ESC>:FzfHelptags<CR>
noremap <silent> <leader>; :FzfCommands<CR>
nnoremap <silent> <leader>l :FzfBLines<CR>
inoremap <silent> <F3> <ESC>:FzfSnippets<CR>

" fzf.Tags uses existing 'tags' file or generates it otherwise
nnoremap <silent> <leader>t :FzfTags<CR>
xnoremap <silent> <leader>t "zy:FzfTags <C-r>z<CR>

" fzf.BTags generate tags on-fly for current file
nnoremap <silent> <leader>T :FzfBTags<CR>
xnoremap <silent> <leader>T "zy:FzfBTags <C-r>z<CR>

" Show list of change in fzf
" Some code is borrowed from ctrlp.vim and tweaked to work with fzf
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

command FzfChanges call s:fzf_changes()
nnoremap <silent> <leader>f; :FzfChanges<CR>


" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'
" }}}

" PLUGIN: vim-figutive{{{
augroup aug_vim_figutive
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
" FIXME: only at the beginning of the line
" cnoreabbrev gd Gdiff
" cnoreabbrev gc Gcommit -v -a
" cnoreabbrev ge Gedit
" cnoreabbrev gl Glog
" cnoreabbrev gr Ggrep
" cnoreabbrev go Git<Space>checkout

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

" PLUGIN: vim-gitgutter{{{

let g:gitgutter_terminal_reports_focus=0
let g:gitgutter_enabled = 1

nnoremap <silent> <F4> :GitGutterFold<CR>

" Use 'd' as a motion for hunks, instead of default 'c'
" Use '[d' and ']d' to move between hunks in regular files and in diff mode
" It's easier to use 'do' and 'dp' when a finger is already on 'd' key
nmap <expr> ]d &diff ? ']c' : '<Plug>GitGutterNextHunk'
nmap <expr> [d &diff ? '[c' : '<Plug>GitGutterPrevHunk'
omap id <Plug>GitGutterTextObjectInnerPending
omap ad <Plug>GitGutterTextObjectOuterPending
xmap id <Plug>GitGutterTextObjectInnerVisual
xmap ad <Plug>GitGutterTextObjectOuterVisual

" }}}

" PLUGIN: vim-smooth-scroll {{{
noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 20, 2)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 20, 2)<CR>
noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 20, 4)<CR>
noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 20, 4)<CR>
" }}}

" PLUGIN: vim-commentary{{{
augroup aug_commentary
  au!
  au FileType vim setlocal commentstring=\"\ %s
augroup end

cnoreabbrev cm Commetary

nmap <silent> <leader>c <Plug>CommentaryLine :normal j<CR>
xmap <leader>c <Plug>Commentary
" }}}

" PLUGIN: bronson/vim-trailing-whitespace{{{

" bronson/vim-trailing-whitespaces is used for highlighting
" we use custom routines to strip whitespaces
let g:extra_whitespace_ignored_filetypes = ['fugitive', 'markdown', 'diff', 'qf', 'help', 'gitcommit']

" Strips trailing whitespace
" Remoces extra newlines at EOF
function! s:StripWhitespace(line1, line2)
  let l:save_cursor = getpos(".")

  " Strip trailing whitespaces
  silent! execute ':' . a:line1 . ',' . a:line2 . 's/\\\@<!\s\+$//'

  " Remote extra newlines at EOF
  if a:line2 >= line('$')
    let nl = &ff == 'dos' ? '\r\n' : '\n'
    silent execute '%s/\('.nl.'\)\+\%$//e'
  endif

  call setpos('.', l:save_cursor)
endfunction

" Automatically strips whitespace on save after checks
function! s:StripWhitespaceOnSave()
  if index(g:extra_whitespace_ignored_filetypes, &ft) != -1
        \ || &buftype == 'nofile'
        \ || get(b:, '_disable_strip_whitespace_on_save', 0)
    return
  endif

  call s:StripWhitespace(1, line('$'))
endfunction

augroup aug_trailing_whitespaces
  au!

  " Highlight space characters that appear before or in-between tabs
  au BufRead,BufNew * 2match ExtraWhitespace / \+\ze\t/

  " Strip whitespaces automatically on save
  au BufWritePre * call <SID>StripWhitespaceOnSave()

  " Disable Airline whitespace detection for ignored filetypes
  for wifile in g:extra_whitespace_ignored_filetypes
    execute "au FileType " . wifile . " let b:airline_whitespace_disabled = 1"
  endfor
augroup END

" Commands and mappings
command -range=% -nargs=0 StripWhitespace call <SID>StripWhitespace(<line1>,<line2>)

nnoremap <localleader>w :StripWhitespace<CR>
vnoremap <localleader>w :StripWhitespace<CR>

" }}}

" PLUGIN: rhysd/clever-f.vim{{{

" Add highlighting for f/t searches
" Uses f/t to advance to next match instead of using ';' and ','
let g:clever_f_ignore_case = 1
let g:clever_f_smart_case = 1

" Use same highlighting group as a normal search
let g:clever_f_mark_char_color = 'IncSearch'
" }}}

" PLUGIN: majutsushi/tagbar{{{
nnoremap <silent> <F9> :TagbarToggle<CR>
let g:tagbar_autoclose = 0
let g:tagbar_autofocus = 1
let g:tagbar_compact = 1
let g:tagbar_foldlevel = 1
let g:tagbar_indent = 1
let g:tagbar_iconchars = ['▸', '▾']
let g:tagbar_silent = 1
" }}}

" PLUGIN: Valloric/ListToggle{{{
let g:lt_location_list_toggle_map = ',l'
let g:lt_quickfix_list_toggle_map = ',q'
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
nnoremap <silent> <F11> :GutentagsToggle<CR>

" Let user decide when to generate tags file for the project
" Don't do it automatically for any VCS repo
let g:gutentags_generate_on_missing = 0
let g:gutentags_generate_on_new = 0
" }}}

" PLUGIN: Raimondi/delimitMate{{{

let delimitMate_autoclose = 1
let g:delimitMate_expand_cr = 2
let g:delimitMate_expand_space = 1
let g:delimitMate_jump_expansion = 1
let g:delimitMate_balance_matchpairs = 1
let g:delimitMate_matchpairs = "(:),[:],{:}"
" Indeed we are going to exclude Comment and String syntax group names
" But turns out this plugin relies upon highlight groups rather than syntax group names
" So we have to use linked Dracula highlight groups instead
" NOTE: If you change current theme, this code should be updated as well
" https://github.com/Raimondi/delimitMate/issues/277#issuecomment-466780034
let g:delimitMate_excluded_regions = "DraculaYellow,DraculaComment"
" }}}

" PLUGIN: SirVer/ultisnips{{{
" SirVer/ultisnips is only the snippet engine
" For snippet definitions, see 'honza/vim-snippets'

" Do not let UltiSnips set <Tab> mapping, as we're going to provide own implementation
" Also we don't need snippet listing, as we're using fzf for this purpose
let g:UltiSnipsExpandTrigger="<NUL>"
let g:UltiSnipsListSnippets="<NUL>"
let g:UltiSnipsEditSplit = 'context'
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

" File types{{{
augroup ft_gitcommit
  au!

  " TODO: change syntax match whenever syntax is applied
  " Highlight summary line when exceeds 72 columns, not 50 as a default
  au FileType gitcommit syn clear gitcommitSummary
  au FileType gitcommit syn match gitcommitSummary "^.\{0,72\}" contained containedin=gitcommitFirstLine nextgroup=gitcommitOverflow contains=@Spell

  " Do not use folds
  " Use spell checking
  au FileType gitcommit setlocal foldmethod=manual spell

  " Automatically start insert mode for commit messages
  au BufEnter COMMIT_EDITMSG startinsert
augroup END

augroup ft_vim
  au!

  " Automatically source vimrc on change
  au BufWritePost $MYVIMRC source $MYVIMRC

  au FileType vim setlocal foldmethod=marker
augroup END

augroup ft_help
  au!

  " Close Help window using just 'q' keystroke
  autocmd FileType help nnoremap <buffer> <silent> q :quit<CR>

  " If current tab has the only window, open help of the rightmost side
  autocmd BufWinEnter *.txt if winnr('$') == 2 && &buftype == 'help' | wincmd L | endif
augroup END

augroup ft_markdown
  au!

  " Enable spell checking and auto-save
  au FileType markdown setlocal spell |
        \ let b:auto_save = 1 |
        \ setlocal synmaxcol=500
augroup END

" }}}
