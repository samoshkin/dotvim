augroup ft_vim
  autocmd! * <buffer>

  " If current tab has the only window, open help of the rightmost side
  autocmd BufWinEnter <buffer> if winnr('$') == 2 | wincmd L | endif
augroup END
