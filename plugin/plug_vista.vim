if exists("g:__loaded_plug_vista")
  finish
endif
let g:__loaded_plug_vista = 1

nnoremap <silent> <leader>[ :Vista!!<CR>

let g:vista_sidebar_width = 40
let g:vista_sidebar_keepalt = 1

" Do not show any feedback when navigating between symbols in Vista buffer
let g:vista_echo_cursor = 0
let g:vista_echo_cursor_strategy=''

" Compact view using minimal icons
let g:vista_icon_indent = ["▸ ", ""]

" Disable blinking
let g:vista_blink = [0, 0]
let g:vista_top_level_blink = [0, 0]

" Universal ctags should be installed, not exuberant-ctags
" A maintained ctags implementation https://github.com/universal-ctags/ctags
" Use ctags provider by default, use 'coc/LSP' for a subset of file types
let g:vista_default_executive = "ctags"
let g:vista_executive_for = {
      \ 'javascript': 'coc',
      \ 'typescript': 'coc',
      \ 'javascriptreact': 'coc',
      \ 'typescriptreact': 'coc',
      \ 'json': 'coc',
      \ 'vim': 'coc'
      \ }

" Backend fallbacks, only for 'Vista finder'
let g:vista_finder_alternative_executives = ['coc', 'ctags']

" Delays
let g:vista_cursor_delay = 400
let g:vista_floating_delay = 400
let g:vista_find_nearest_method_or_function_delay = 400

augroup aug_vista
  " Vista buffer local mappings:
  " - <leader>/ - search for symbols/tags
  autocmd FileType vista,vista_kind nnoremap <buffer> <nowait> <silent> <leader>/ :<c-u>Vista! <bar> call vista#finder#fzf#Run()<CR>

  " Exit vim when the only buffer remaining is Vista
  autocmd BufEnter * if winnr("$") == 1 && (&ft ==# 'vista' || &ft ==# 'vista_kind') | q | endif

  " Track symbol under the cursor to show it in a status line
  " TODO (consider): do we need it?
  " autocmd VimEnter * call vista#RunForNearestMethodOrFunction()
augroup END
