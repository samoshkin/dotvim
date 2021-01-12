if exists("did_load_filetypes")
  finish
endif

augroup filetypedetect
  au BufRead,BufNewFile .eslintignore setf gitignore
  au BufRead,BufNewFile .eslintrc setf json
augroup END
