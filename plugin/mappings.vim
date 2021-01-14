if exists("g:__loaded_mappings")
  finish
endif
let g:__loaded_mappings = 1

" Timeout settings
" Eliminating ESC delays in vim - Metaserv - https://meta-serv.com/article/vim_delay
" Delayed esc from insert mode caused by cursor-shape terminal sequence - Vi and Vim Stack Exchange - https://vi.stackexchange.com/questions/15633/delayed-esc-from-insert-mode-caused-by-cursor-shape-terminal-sequence
" Wait forever until I recall mapping
" Don't wait to much for keycodes send by terminal, so there's no delay on <ESC>
set notimeout
set timeoutlen=2000
set ttimeout
set ttimeoutlen=30

" Additional <ESC> mappings:
" <C-c>, I'm so used to it in a shell environment
inoremap <C-C> <ESC>
noremap <C-C> <ESC>
vnoremap <C-C> <ESC>
snoremap <C-C> <ESC>

" key bindings - How to map Alt key? - Vi and Vim Stack Exchange - https://vi.stackexchange.com/questions/2350/how-to-map-alt-key
" https://vim.fandom.com/wiki/Mapping_fast_keycodes_in_terminal_Vim
if !has("gui_running")
  " Tell vim what escape sequence to expect for various keychords
  " This is needed for terminal Vim to regognize Meta and Shift modifiers
  execute "set <A-w>=\ew"
  execute "set <A-k>=\ek"
  execute "set <A-j>=\ej"
  execute "set <A-,>=\e,"
  execute "set <M-n>=\en"
  execute "set <M-e>=\ee"
  execute "set <M-p>=\ep"

  " <C-arrow>, <S-arrow> does not work when vim is running inside tmux (TERM=screen-256color), because terminfo database lacks these keys for screen* term
  " To make this work, ensure that tmux is configured with xterm-keys "on", e.g:
  " set -wg xterm-keys on
  " See: https://superuser.com/questions/401926/how-to-get-shiftarrows-and-ctrlarrows-working-in-vim-in-tmux
  if &term =~ '^screen'
    " tmux will send xterm-style keys when its xterm-keys option is on
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
  endif

  " NOTE: not portable solution, but I need <S-CR> so much
  " I configured iTerm to send '[13;2u' escape sequence for <S-CR>, so I can map it in Vim
  " Map terminal key code to Vim keycode first (pick up any <F13> to <F37>)
  " <F20> would be <S-CR>
  " <F21> would be <C-CR>
  " See:
  " - https://stackoverflow.com/questions/16359878/how-to-map-shift-enter
  " - https://vim.fandom.com/wiki/Mapping_fast_keycodes_in_terminal_Vim
  execute "set <F20>=\e[13;2u"
  execute "set <F21>=\e[13;5u"

  " Change cursor shape in Normal, Insert, Replace modes
  " These escape sequences are interpreted by your terminal to change the cursor shape
  " Vim only sends them to the underlying terminal
  " NOTE: it's not possible to change cursor color in iTerm2
  let &t_SI="\<Esc>[6 q"
  let &t_SR="\<Esc>[4 q"
  let &t_EI="\<Esc>[2 q"

  " I've failed to map <Home> and <End> keys when vim runs inside tmux
  " Although <Home> and <End> move cursor, Vim does not recognize them as <Home>/<End> in mappings
  " The root cause is that tmux reports itself as "xterm-256color", which is wrong,
  " And Vim expects \EOH and \EOF sequences for Home and End keys, whereas \E[1~ and \E[4~ are actually send
  " The right solution is make tmux to report itself as "screen-256color" or "tmux-256color"
endif
