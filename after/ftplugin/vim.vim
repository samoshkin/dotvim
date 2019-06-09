setlocal foldmethod=marker

augroup ft_vim
  au! * <buffer>
  au! BufWritePost $MYVIMRC

  " Automatically source vimrc on change
  au BufWritePost $MYVIMRC source $MYVIMRC
augroup END
