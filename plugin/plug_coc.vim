if exists("g:__loaded_plug_coc")
  echom "already loaded"
  finish
endif
let g:__loaded_plug_coc = 1

" COC extensions are declared in coc-extensions.json file. Install as follows:
" $ ln -sf "$HOME/.vim/coc-extensions.json" "$HOME/.config/coc/extensions/package.json"
" $ cd ~/.config/coc/extensions
" $ yarn install

" Set coc.nvim log level. Use :CocInfo to view logs
" let $NVIM_COC_LOG_LEVEL='debug'

"  Refactoring {{{
nmap <leader>cr <Plug>(coc-rename)
nmap <leader>cR <Plug>(coc-refactor)

" Organize imports
command! -nargs=0 OrganizeImports :call CocAction('runCommand', 'editor.action.organizeImport')

" Rename current file
command! -nargs=0 RenameFile :CocCommand workspace.renameCurrentFile
" }}}

" Selection {{{

" Expand/shrink selection. In visual mode only
xmap <silent> <C-l> <Plug>(coc-range-select)
xmap <silent> <C-h> <Plug>(coc-range-select-backward)

" }}}


" Folding {{{
nmap <silent> <leader>cz :call CocAction("fold")<CR>
" }}}

" Text objects {{{

" Use K to show documentation
nnoremap <silent> K :call <SID>ShowDocumentation()<CR>

" Pick color, when LSP has documentColor feature
nmap <silent> <leader>gc :<C-u>call CocActionAsync('pickColor')<CR>

" Navigate through occurrences of highlighted symbol
nnoremap <silent> ]s :<C-u>CocCommand document.jumpToNextSymbol<CR>
nnoremap <silent> [s :<C-u>CocCommand document.jumpToPrevSymbol<CR>

" Go to definion, references, implementations
nmap <silent> <leader>gd :call <SID>GoToDefinition() <bar> norm zz<CR>
nmap <silent> <leader>gt <Plug>(coc-type-definition)
nmap <silent> <leader>gi <Plug>(coc-implementation)
nmap <silent> <leader>gr <Plug>(coc-references)

" Show definition in preview (peek into definition)
" Depends on Coc location list running in auto-preview mode by default
nnoremap <silent> <leader>gp :<C-u>call CocAction('jumpDefinition', v:false)<CR>

" Smart "go to definition". Try coc/LSP followed by ctags as a fallback
" Or use CocTagFunc to make "C-]" respect the same fallback chain: coc/LSP -> tags
function! s:GoToDefinition()
  if CocAction('jumpDefinition')
    return v:true
  endif

  execute("silent! normal \<C-]>")
endfunction

function! s:ShowDocumentation()
  if (index(['help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" }}}

" Lists {{{

" Show CocCommands list
nnoremap <silent> <leader>c;  :<C-u>CocList commands<CR>

" Show workspace symbols
nnoremap <silent> <leader>I :<C-u>CocList -I symbols<CR>
" Symbols of current document, provided by language server or ctags
nnoremap <silent> <leader>i :<C-u>CocList outline<CR>

" Resume and close last coc list
nnoremap <silent> <leader>cs  :<C-u>CocListResume<CR>
nnoremap <silent> <leader>cc  :<C-u>CocListCancel<CR>

" Navigate through items in a last CocList and execute default action
" Does not open list if it's closed
nnoremap <silent> ]c :<C-u>CocNext<CR>
nnoremap <silent> [c :<C-u>CocPrev<CR>
nnoremap <silent> ]C :<C-u>CocLast<CR>
nnoremap <silent> [C :<C-u>CocFirst<CR>

" Show Vim commands (in addition to FzfCommands)
nnoremap <silent> <leader>c: :<C-u>CocList vimcommands<CR>

" Windows in current tab
nnoremap <silent> <leader>cw :<C-u>CocList windows<CR>

" Similar to fzf-mru
nnoremap <silent> <leader>cp : <C-u>CocList mru<CR>

" Quickfix and location list analogues
nnoremap <silent> <leader>cl :<C-u>CocList locationlist<CR>
nnoremap <silent> <leader>cq :<C-u>CocList quickfix<CR>

" }}}

" Feature detect {{{

" Detect if Coc/LSP provides particular feature, and apply some config
augroup aug_coc_featuredetect
  autocmd!

  " Disable Coc if file with size > 1MB
  autocmd BufAdd * if getfsize(expand('<afile>')) > 1024*1024 |
        \ let b:coc_enabled=0 |
        \ endif

  autocmd BufEnter * call timer_start(1000, 'DetectCocFeatures')
augroup end

function DetectCocFeatures(timer)
  " If LSP has "definition" support, bridge Coc symbols and Vim tags
  " Use C-] to navigate to symbol definition, same as you do for tags
  if CocHasProvider("definition")
    try
      setl tagfunc=CocTagFunc
    catch /E48/
      " E48: not allowed in a sandbox: tagfunc=CocTagFunc
    endtry
  endif

  " If has "declaration" provider, overwrite Vim's "gd" mapping
  if CocHasProvider("declaration")
    nmap <buffer> gd <Plug>(coc-declaration)
  endif
endfunction

" }}}

