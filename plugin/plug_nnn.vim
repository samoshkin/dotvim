if exists("g:__loaded_plug_nnn")
  finish
endif
let g:__loaded_plug_nnn = 1

" Disable default mappings
let g:nnn#set_default_mappings = 0

" Open nnn in a current window like netrw, replacing the current buffer
let g:nnn#layout = 'enew'
" NOTE: bug when opening nnn in a popup window. Characters in termanil are getting messed up
" let g:nnn#layout = { 'window': { 'width': 1, 'height': 0.7, 'yoffset': 0, 'border': 'bottom', 'highlight': 'VertSplit' } } " use vim window popup

" Disable nnn own status line customizations
let g:nnn#statusline = 0

" Use same shortcuts as for 'fzf' popups
" NOTE: <c-t> hides "Toggle sort" nnn's action, but it's rarely used
let g:nnn#action = {
      \ '<c-q>': function('_#qfloc#build_quickfix_list'),
      \ '<c-t>': 'tab split',
      \ '<c-s>': 'split',
      \ '<c-v>': 'vsplit' }

" Start nnn in the current file's directory, or without any args (uses persistent session as defined in .zshenv)
nnoremap <silent> <leader>n :NnnPicker %:p:h<CR>
" Start nnn in persistent session mode (nnn -S)
nnoremap <silent> <leader>N :NnnPicker<CR>
