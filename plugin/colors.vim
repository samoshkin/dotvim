" Run 'after/colors/{colorscheme}.vim' for color scheme configuration
" This file would run after "colorscheme <scheme>" command
autocmd ColorScheme * execute 'runtime after/colors/'. expand('<amatch>') .'.vim'

if &t_Co > 2 || has("gui_running")
  set guifont=DroidSansMono\ Nerd\ Font\ Mono:h14
endif

" Enable italic text
if &t_Co >= 256 || has("gui_running")
  let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
endif

" Use 24-bit true colors
if (has("termguicolors"))
  set termguicolors
endif

if &term =~ '256color'
  " disable Background Color Erase (BCE) so that color schemes
  " render properly when inside 256-color tmux and GNU screen.
  " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_ut=
endif
