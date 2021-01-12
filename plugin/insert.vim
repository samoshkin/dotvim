if exists("g:__loaded_insert")
  finish
endif
let g:__loaded_insert = 1

" When pasting from clipboard, Vim acts as though each character has been typed by hand.
" "set paste" option turns off Insert mode mappings and autoindentation, so text is pasted verbatim, and is not reindented. No formatting is done
nnoremap <silent> <leader>tp :set paste!<CR>
set pastetoggle=<F11>

" Allow Backspace to work over indent, line endings, and start of insert. By default Backspace works only against inserted text
set backspace=indent,eol,start

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

" Do not insert first suggestion
set completeopt=menu,menuone,preview,noinsert

" Like smartcase, but for completion
set infercase

" Drop into insert mode on Backspace
nnoremap <BS> i<BS>

" In Insert mode, treat paste as a separate undoable operation
" Which can be undone with '<C-o>u'
inoremap <C-r> <C-g>u<C-r>

" <C-v>v, paste verbatim, by entering Paste mode
" Treat paste as a separate undoable operation
imap <C-v>v <C-g>u<F11><C-r>*<F11>

" <C-v>p, paste with formatting, due to 'g:yoinkAutoFormatPaste=1'
inoremap <C-v>p <ESC>pi
inoremap <C-v>P <ESC>Pi

" Retain original <C-v> behavior, insert character by code
" 'c' for character
inoremap <C-v>c <C-v>

" Insert digraph, 'd' for digraph
inoremap <C-v>d <C-k>

" Shift-Enter(remapped as <F20>) to start editing new line below without splitting the current one
" Ctrl-Enter(remapped as <F21>) to start editing new line above
" Respects 'smartindent' setting, new lines get properly indented
inoremap <F20> <C-o>o
inoremap <F21> <C-o>O

" Make delete commands resemble their shell counterparts
" <C-w>, delete word backwards
" <C-u>, delete from the cursor to the begginning
" <C-k>, delete from the cursor to the end
inoremap <C-k> <C-o>D

" Remove whole line
inoremap <C-l> <C-o>dd

" Smart <CR> logic
inoremap <silent> <expr> <CR> <SID>SmartCR()

function s:SmartCR()
  if pumvisible()
    return "\<C-y>"
  endif

  if delimitMate#WithinEmptyPair()
    call feedkeys("\<Plug>delimitMateCR")
    return ""
  endif

  " Notify coc.nvim that `<enter>` has been pressed.
  " Used for the format on type and improvement of brackets
  return "\<CR>\<C-r>=coc#on_enter()\<CR>"
endfunction

" Manually trigger insert completion using <C-space>
" In terminals <C-space> usually produces <NUL> character
inoremap <silent><expr> <NUL> coc#refresh()

" Arrow navigation in insert mode
" <Home> moves cursor to the first non-blank character, like '^' does
inoremap <silent> <expr> <Up> pumvisible() ? "<Up>" : "\<C-o>gk"
inoremap <silent> <expr> <Down> pumvisible() ? "<Down>" : "\<C-o>gj"
inoremap <silent> <Home> <C-o>g^
inoremap <silent> <End> <C-o>g$

" TODO: <C-s> to surround current word in insert mode

" Smart <Tab> logic
" let g:coc_snippet_next = '<Tab>'
let g:coc_snippet_prev = '<S-Tab>'

" TODO: when I'm inside last placeholder of expanded snippet, next <TAB> should
" drop be out of SELECT mode back into the INSERT mode
inoremap <silent><expr> <Tab>
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ pumvisible() ? "\<C-y>" :
      \ "\<Tab>"
