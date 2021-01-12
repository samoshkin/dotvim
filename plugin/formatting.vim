if exists("g:__loaded_formatting")
  finish
endif
let g:__loaded_formatting = 1

" Whitespace and tabs
" - tabstop, width of a tab chracter
" - expandtab, cause spaces to be used instead of tabs
" - softtabstop, number of spaces inserted by Tab when expandtab is on.
" - shiftwidth, number of spaces to insert/remove for indentation at the BOL (only used for >>)
" Local ftplugin settings usually override these global ones
set tabstop=2 shiftwidth=2 softtabstop=-1 expandtab

" <Tab> in front of a line inserts blanks according to shiftwidth
set smarttab

" Auto indentation
" Preserve the same level of indentation each time we create a new line in Insert mode.
" Also, do smart autoindenting when starting a new line.
set autoindent
set smartindent

" Experimental. Round indent to multiple of 'shiftwidth'.
set shiftround

" Use soft wraps
" Limitation: you cannot have soft wrap at specified line width (textwidth is responsible for hard wraps). The only workaround is to limit the width of the window using "set columns = 80"
set wrap

" Toggle wrap
nnoremap <leader>tw :<C-u>setl wrap!<CR>

" no octal numbering for <C-A> and <C-X>
set nrformats-=octal

" Use lang servers via coc.nvim, or formatting via Neoformat/CLI utilities (e.g. prettier, stylefmt)
let g:fmt_use_lang_server = 0
let g:fmt_use_neoformat = 1
" Whether to automatically format file on save. You may override it on a buffer level
let g:fmt_on_save = 0
" Whether to automatically format on insert leave. You may override it on a buffer level
let g:fmt_on_insert_leave = 0

" Per-language settings
let g:neoformat_enabled_javascript = ['prettier']
let g:neoformat_enabled_css = ['stylefmt', 'stylelint', 'prettier']
let g:neoformat_enabled_scss = ['stylefmt', 'stylelint', 'prettier']
let g:neoformat_enabled_less = ['stylefmt', 'stylelint', 'prettier']
let g:neoformat_enabled_html = ['htmlbeautify', 'tidy', 'prettydiff']

" Use Vim's 'formatprg' when set
let g:neoformat_try_formatprg = 1

" Fallback when file type is not backed by any CLI formatting utility
" Do not use these fallbacks
let g:neoformat_basic_format_align = 0
let g:neoformat_basic_format_retab = 0
let g:neoformat_basic_format_trim = 0

" Stop at first successful formatter
let g:neoformat_run_all_formatters = 0

augroup aug_formatting
  autocmd!

  " Format on save if configured so
  autocmd BufWritePre * if _#util#get_var("fmt_on_save", 0) | silent! undojoin | call <SID>DoFormat() | endif

  " Format when leaving insert mode. Use this only when lang server is not used
  " Lang server is fully capable of formatting a range or just current line.
  " CLI formatting utilities (e.g prettier, js_beautify, stylefmt) have
  " incomplete support of range formatting, and might produce incorrect results,
  " therefore the whole buffer is being formatted
  autocmd InsertLeave * if _#util#get_var("fmt_on_insert_leave", 0) | silent! undojoin | call <SID>DoFormat() | endif

  " Explicitly tell which filetypes should be formatted using LSP
  " Other file types are handled by Neoformat
  autocmd FileType javascript,javascriptreact,typescript,typescriptreact,html,json let b:fmt_use_lang_server = 1

  " Format options
  " Remove most related to hard wrapping
  " Use autocommand to override defaults from $VIMRUNTIME/ftplugin
  " Do not define on our own, rely on vim-polyglot and other language-specific plugins to properly set formatoptions
  " -t, Don't use hard wraps for normal text
  " +c, Use hard wrapping for comments
  " +v, hard-wrap only at a blank, not in-between a word (use it for comments
  " hard-wrapping)

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
  " l - Long lines are not broken in insert mode
  " au FileType * setlocal formatoptions=roql
  au FileType * setlocal formatoptions-=t formatoptions+=v formatoptions+=c formatoptions+=n
augroup end

" Format range normal and visual modes.
" Range formatting is only supported by COC/LSP
xmap <silent> <expr> <leader>gq _#util#get_var("fmt_use_lang_server", 0) ? "<Plug>(coc-format-selected)" : ""
nmap <silent> <expr> <leader>gq _#util#get_var("fmt_use_lang_server", 0) ? "<Plug>(coc-format-selected)" : ""

" Format whole file
nmap <silent> <leader>gQ :call <SID>DoFormat()

" Toggle "format on save", "format on insert", "format using lang server" on a buffer level
nmap <silent> <leader>tfs :<C-u>let b:fmt_on_save = _#util#get_var('fmt_on_save', 0) ? 0 : 1<CR>
nmap <silent> <leader>tfi :<C-u>let b:fmt_on_insert_leave = _#util#get_var('fmt_on_insert_leave', 0) ? 0 : 1<CR>
nmap <silent> <leader>tfl :<C-u>let b:fmt_use_lang_server = _#util#get_var('fmt_use_lang_server', 0) ? 0 : 1<CR>
nmap <silent> <leader>tfn :<C-u>let b:fmt_use_neoformat = _#util#get_var('fmt_use_neoformat', 0) ? 0 : 1<CR>

" Format whole file, format text region in norm and visual modes
command! -nargs=0 Format call <SID>DoFormat()

" Remove trailing whitespace and new lines
command! FixTrailingLines :call <SID>FixTrailingLines()
command! -range=% FixTrailingWhitespace call <SID>FixTrailingWhitespace(<line1>,<line2>)

" Change between tabs and spaces
" Borrowed from https://vim.fandom.com/wiki/Super_retab
" Retab executes Space2Tab (if 'expandtab' is set), or Tab2Space (otherwise).
" Use this command instead of :retab built-in. It affects only ading tab/spaces
command! -nargs=? -range=% Space2Tab call IndentConvert(<line1>,<line2>,0,<q-args>)
command! -nargs=? -range=% Tab2Space call IndentConvert(<line1>,<line2>,1,<q-args>)
command! -nargs=? -range=% Retab call IndentConvert(<line1>,<line2>,&et,<q-args>)

function s:DoFormat()
  if _#util#get_var("fmt_use_lang_server", 0)
    call CocAction('format')
  elseif _#util#get_var("fmt_use_neoformat", 0)
    Neoformat
  else
  endif

  " Always remove trailing whitespace and lines at EOF
  " despite whether formatting was or was not handled by LSP/Neoformat
  FixTrailingWhitespace
  FixTrailingLines
endfunction

function! s:FixTrailingWhitespace(line1, line2)
  let l = line(".")
  let c = col(".")
  execute ":keeppatterns " . a:line1 . ',' . a:line2 . 's/\s\+$//e'
  call cursor(l, c)
endfunction

function! s:FixTrailingLines()
  let l = line(".")
  let c = col(".")
  " remove trailing new lines
  keeppatterns keepjumps %s#\($\n\)\+\%$##e
  " add extra LF at the end of file
  " keeppatterns keepjumps %s#\%$#\r#e
  call cursor(l, c)
endfunction

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
