" Do not use folds
setlocal foldmethod=manual

" Use spell checking
setlocal spell

augroup ft_gitcommit
  au! * <buffer>
  au! BufEnter COMMIT_EDITMSG

  " Automatically start insert mode for commit messages
  au BufEnter COMMIT_EDITMSG startinsert
augroup END
