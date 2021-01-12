" "git" ft represents 'vim-fugitive' buffers
" whereas "b:fugitive_type" indicates different types of fugitive buffers (index, blob, tree, commit)

" Blob or Tree file type
if get(b:, 'fugitive_type', '') =~# '^\%(tree\|blob\)$'
  " Use g.. to navigate up in Git tree, or from blob back to the containing tree
  nnoremap <buffer> g.. :edit %:h<CR>
endif

if get(b:, 'fugitive_type', '') =~# 'commit'
  " Open snapshot of file under the cursor. Equivalent to ":Gedit <commit>:<file>"
  " NOTE: only when cursor is placed over file diff row in a commit buffer
  nnoremap <buffer> ge :call _#fugitive#OpenFileSnapshotInCommitBuffer()<CR>

  " Redefine mappings to jump between files
  nmap <buffer> ]f ]m
  nmap <buffer> [f [m
endif

