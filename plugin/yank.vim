if exists("g:__loaded_yank")
  finish
endif
let g:__loaded_yank = 1

" Extend built-in clipboard functionality with these plugins:
" - https://github.com/svermeulen/vim-cutlass
" - https://github.com/svermeulen/vim-subversive
" - https://github.com/svermeulen/vim-yoink

" always use system clipboard as unnamed register
" Detect when system clipboard changes and sync it with yank unnamed register
set clipboard=unnamed,unnamedplus

" Normalize Y behavior to yank till the end of line
nnoremap Y y$

"  https://github.com/svermeulen/vim-cutlass {{{

" Cutlass overrides the delete operations to actually just delete and not affect the current yank.
" Use 'x' as cut operation instead
" All other actions, like d, c, s will delete without storing in clipboard
nnoremap x d
nnoremap xx dd
nnoremap X D
xnoremap x d

" }}}

" https://github.com/svermeulen/vim-yoink {{{

" Normally cursor remains in place during paste
" Move it to the end, so it's easy to start editing
let g:yoinkMoveCursorToEndOfPaste=1

" Every time the yank history changes the numbered registers 1 - 9 will be updated to sync with the first 9 entries in the yank history
let g:yoinkSyncNumberedRegisters = 1

" Auto formatting on paste, and be able to toggle formatting on/off
" Replaces the need for 'vim-pasta' plugin
" Formatting is handled via '='(reindent) rather than 'gq' (smarter formatting)
let g:yoinkAutoFormatPaste = 1
nmap <leader>= <plug>(YoinkPostPasteToggleFormat)

" For integration with 'svermeulen/cutclass', so 'cut'/x operator will be added to the yank history
let g:yoinkIncludeDeleteOperations=1

" Do not put yanks for named register inside yank ring
let g:yoinkIncludeNamedRegisters = 0

" Navigation through yank ring
nmap <C-p> <plug>(YoinkPostPasteSwapBack)
nmap <C-n> <plug>(YoinkPostPasteSwapForward)

" Map p and P keys to notify yoink that paste has occurred so we can further traverse yank ring with <c-n> and <c-p>
" NOTE: vim-yoink does not supports swapping when doing paste in visual mode, so we don't add "xmap p" here
" this feature is handled separately by vim-subversive
nmap p <plug>(YoinkPaste_p)
nmap P <plug>(YoinkPaste_P)

" Preserve cursor position after yank operation
nmap y <plug>(YoinkYankPreserveCursorPosition)
xmap y <plug>(YoinkYankPreserveCursorPosition)

" }}}

" https://github.com/svermeulen/vim-subversive {{{

" Store text that being substituted in register 'r'
let g:subversiveCurrentTextRegister='r'

" Do not move cursor after substitutions are applied
let g:subversivePreserveCursorPosition = 1

" 'Use 's' as 'cut & replace' action, not as a shortcut to 'change' action
nmap s <plug>(SubversiveSubstitute)
nmap ss <plug>(SubversiveSubstituteLine)
nmap S <plug>(SubversiveSubstituteToEndOfLine)
xmap s <plug>(SubversiveSubstitute)

" In visual mode, regular 'put' operation actually does a substitution
" After remapping we can cycle through yank ring provided by 'vim-yoink' with <C-p> and <C-n>
" complements "svermeulen/vim-yoink"
xmap p <plug>(SubversiveSubstitute)
xmap P <plug>(SubversiveSubstitute)

" Substitute operation performed multiple times for a given text range
" Common usage is to replace same word in a paragraph or sentence
" First motion: what to replace, second motion - where to replace: <leader>s{iw}{ip}
nmap <leader>s <plug>(SubversiveSubstituteRange)
nmap <leader>ss <plug>(SubversiveSubstituteWordRange)
xmap <leader>s <plug>(SubversiveSubstituteRange)

" }}}
