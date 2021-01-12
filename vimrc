" TODO: mergetool
" TODO: hex editor

" Should be first, use vim settings rather than vi settings
" Enable loading plugins
set nocompatible

" Disable some Vim's native plugins. Do it before 'filetype plugin' command
" Do not load matchparens (higlight matching pairs)
" Do not load matchit (improves % motion to find matching words besides matching parens)
" Native Vim's "matchparen" is slow and cause lags during scrolling
" 'andymass/vim-matchup' is used instead
let g:loaded_matchit = 1
let g:loaded_matchparen = 1

" Turns on:
" - detection of filetype based on extensions or file content (runtime/filetype.vim, ftdetect/xxx)
" - once file type is detected, read per-filetype commands from 'ftplugin/<type>.vim'
" - once file type is detected, read indentation expression from 'indent/<type>.vim'
" See ":h :filetype-overview" for more info
filetype plugin indent on

" Plugin: sheerun/vim-polyglot
" Disable default settings (a.k.a normalize) from 'tpope/vim-sensible'
" NOTE: this should come before plug#begin section
let g:polyglot_disabled = ['sensible', 'markdown']

" Vim plugins
" NOTE: make sure plugin versions are pinned for repeatable installs and overall stability
" TODO (consider): update dependencies
call plug#begin('~/.vim/plugged')

Plug 'junegunn/fzf', { 'do': { -> fzf#install() }, 'commit': '8c533e3' }
Plug 'junegunn/fzf.vim', { 'commit': '811b860' }
Plug 'pbogut/fzf-mru.vim', { 'commit': 'c0a6bda' }
Plug 'vim-scripts/SyntaxAttr.vim', { 'commit': '8debed4' }
Plug 'tpope/vim-repeat', { 'commit': 'c947ad2' }
Plug 'bronson/vim-trailing-whitespace', { 'commit': '05f068e' }
Plug 'morhetz/gruvbox', { 'commit': 'bf2885a' }
Plug 'romainl/vim-qf', { 'commit': '23c9d67' }
Plug 'tpope/vim-commentary', { 'commit': 'f8238d7' }
Plug '907th/vim-auto-save', { 'commit': '8c1d5dc' }
Plug 'neoclide/coc.nvim', { 'branch' : 'release', 'commit': '891c73f' }
Plug 'tpope/vim-obsession', { 'commit': '96a3f83' }
Plug 'farmergreg/vim-lastplace', { 'commit': '48ba343' }
Plug 'terryma/vim-smooth-scroll', { 'commit': '0eae236' }
Plug 'honza/vim-snippets', { 'commit': '6fe515e' }
Plug 'tpope/vim-surround', { 'commit': 'f51a26d' }
Plug 'rhysd/clever-f.vim', { 'commit': '5822b5f' }
Plug 'preservim/nerdtree', { 'commit': '14af897' }
Plug 'ryanoasis/vim-devicons', { 'commit': '0d0bd57' }
Plug 'vim-scripts/CursorLineCurrentWindow', { 'commit': 'b4eeea9' }
Plug 'mcchrish/nnn.vim', { 'commit': '12a3766' }
Plug 'editorconfig/editorconfig-vim', { 'commit': '047c4b4' }
Plug 'airblade/vim-gitgutter', { 'commit': '512e299' }
Plug 'tmux-plugins/vim-tmux-focus-events', { 'commit': 'a568192' }
Plug 'itchyny/lightline.vim', { 'commit': '709b2d8' }
Plug 'tpope/vim-fugitive', { 'commit': '7afa1cf' }
Plug 'sbdchd/neoformat', { 'commit': '7e458da' }
Plug 'andymass/vim-matchup', { 'commit': '24407e2' }
Plug 'MarcWeber/vim-addon-local-vimrc', { 'commit': '6a27f95' }
Plug 'Raimondi/delimitMate', { 'commit': '537a1da' }
Plug 'liuchengxu/vista.vim', { 'commit': 'c5a49cb', 'on': ['Vista'] }
Plug 'ludovicchabant/vim-gutentags', { 'commit': '50705e8' }
Plug 'AndrewRadev/sideways.vim', { 'commit': '19c5a21' }
Plug 'tommcdo/vim-exchange', { 'commit': '17f1a2c' }
Plug 'AndrewRadev/splitjoin.vim', { 'commit': '91ba14b' }
Plug 'airblade/vim-rooter', { 'commit': '45ea40d' }

" Markdown
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug'], 'commit': 'e1b8ec4' }
Plug 'junegunn/limelight.vim', { 'commit': '4412a84' }
Plug 'plasticboy/vim-markdown', { 'commit': '8e5d86f' }

" Languages
Plug 'sheerun/vim-polyglot', { 'commit': '73c5187' }

" Clipboard
Plug 'svermeulen/vim-yoink', { 'commit': 'b973fce' }
Plug 'svermeulen/vim-cutlass', { 'commit': '7afd649' }
Plug 'svermeulen/vim-subversive', { 'commit': '5695f97' }

" Text objects
Plug 'kana/vim-textobj-user', { 'commit': '41a675d' }
Plug 'rhysd/vim-textobj-anyblock', { 'commit': 'a8517f7' }
Plug 'kana/vim-textobj-entire', { 'commit': '64a856c' }
Plug 'kana/vim-textobj-fold', { 'commit': '78bfa22' }
Plug 'kana/vim-textobj-indent', { 'commit': 'deb7686' }
Plug 'kana/vim-textobj-line', { 'commit': '0a78169' }
Plug 'beloglazov/vim-textobj-quotes', { 'commit': 'cca9686' }
Plug 'kana/vim-textobj-syntax', { 'commit': 'a0167c2' }
Plug 'jceb/vim-textobj-uri', { 'commit': 'c5b977a' }
Plug 'Julian/vim-textobj-variable-segment', { 'commit': '78457d4' }

call plug#end()
syntax off

" Built-in plugin to filter quickfix/location lists.
" Then you can use the following commands to filter a quickfix/location list: >
" :Cfilter[!] /{pat}/
" :Lfilter[!] /{pat}/
" See ":h cfilter-plugin"
packadd! cfilter

" <leader> key setup
nnoremap <Space> <Nop>
let mapleader=" "
let maplocalleader=","

" Add "node_modules/.bin" to the PATH (assuming we're inside JS project)
" This is to put locally installed CLI utilities on PATH
" NOTE: this changes PATH only within Vim, and does not affect shell env
" PATH changes are applied to all and every directory, be it JS project or not
" If you don't like such unconditional behavior, use per-project 'local vimrc' or 'direnv' (to change PATH on the shell level)
let $PATH .= ':' . $PWD . '/node_modules/.bin'

" Shared settings
" "bronson/vim-trailing-whitespaces" plugin is used only to highlighting whitespaces
let g:extra_whitespace_ignored_filetypes = ['fugitive', 'markdown', 'diff', 'qf', 'help', 'make']
