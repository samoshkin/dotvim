" Bracketed paste wraps any text you paste via Cmd+V in '\e[200~' and '\e[201~' escape sequences
" This way Vim can distinguish pasted text from normal user input typed manually
" and do not interpret it as an editing commands (e.g. disable auto indentation for every new line)
" See: https://vi.stackexchange.com/questions/25311/how-to-activate-bracketed-paste-mode-in-gnome-terminal-for-vim-inside-tmux/25315
" See: https://cirw.in/blog/bracketed-paste
" See: https://stackoverflow.com/questions/5585129/pasting-code-into-terminal-window-into-vim-on-mac-os-x

" Code from:
" NOTE: borrowed from https://github.com/ConradIrwin/vim-bracketed-paste
" http://stackoverflow.com/questions/5585129/pasting-code-into-terminal-window-into-vim-on-mac-os-x
" then https://coderwall.com/p/if9mda
" and then https://github.com/aaronjensen/vimfiles/blob/59a7019b1f2d08c70c28a41ef4e2612470ea0549/plugin/terminaltweaks.vim
" to fix the escape time problem with insert mode.
"
" Docs on bracketed paste mode:
" http://www.xfree86.org/current/ctlseqs.html
" Docs on mapping fast escape codes in vim
" http://vim.wikia.com/wiki/Mapping_fast_keycodes_in_terminal_Vim
" See also: https://cirw.in/blog/bracketed-paste

" NOTE: bracketed-paste mode is enabled in `nvim` by default as soon as underlying terminal supports it

if exists("g:__loaded_bracketed_paste")
  finish
endif
let g:__loaded_bracketed_paste = 1

" When Vim starts terminal is switched to/from the alternate screen (t_ti, t_te)j
" Tell vim to enable/disable bracketed paste mode in that case
" NOTE: seems to have no effect, since bracketed paste mode is always enabled in a terminal
" NOTE: no need to turn it on/off when Vim starts (e.g. Terminal enters an alternate screen)
" let &t_ti .= "\<Esc>[?2004h"
" let &t_te = "\e[?2004l" . &t_te

function! XTermPasteBegin(ret)
  echom "paste begin"
  set pastetoggle=<f29>
  set paste
  return a:ret
endfunction

" When Vim detects start of a paste escape sequence, enable Paste mode (:set paste) and enter insert mode
" When it receives enf od a paste escape sequence, disable paste mode (pastetoggle) and remain in an insert mode
map <expr> <f28> XTermPasteBegin("i")
imap <expr> <f28> XTermPasteBegin("")
vmap <expr> <f28> XTermPasteBegin("c")
cmap <f28> <nop>
cmap <f29> <nop>
