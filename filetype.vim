if exists("did_load_filetypes")
  finish
endif

augroup filetypedetect
  au BufRead,BufNewFile .gitignore,.eslintignore set filetype=ignorefile
augroup END
