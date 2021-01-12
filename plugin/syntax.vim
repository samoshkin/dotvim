" Declare syntax groups common to all file types
function s:OnSyntax()
  syn match MyTodo /\v<(TODO|FIXME|BUG):/ containedin=.*Comment,vimCommentTitle
  syn match MyNote /\v<(NOTE):/ containedin=.*Comment,vimCommentTitle
endfunction

" Turn on syntax
syntax on

" For files that don't have filetype-specific syntax rules
call s:OnSyntax()

augroup aug_syntax
  au!

  " For files that do have filetype-specific syntax rules
  au Syntax * call <SID>OnSyntax()

  " In addition to 'bronson/vim-trailing-whitespace', highlight mixed tabs and spaces
  au BufRead,BufNew * 2match ExtraWhitespace / \+\ze\t/

  " Disable syntax highlighting for large files (>1Mb)
  au BufReadPost * if getfsize(expand("%")) > 1048576 | echom "Clear" | syntax clear | endif
augroup END

" Setup links between syntax matches and highlight groups
hi def link MyTodo Todo
hi def link MyNote Note

" Shortcut command to 'vim-scripts/SyntaxAttr.vim'
" Displays the syntax highlighting attributes of the character under the cursor, including syntax group
command SyntaxAttr call SyntaxAttr()

" Toggle syntax buffer-local
command ToggleSyntax exe "set syntax=".(&syntax == 'off' ? 'on' : 'off')
nnoremap <leader>ts :ToggleSyntax<CR>
