" Add support for comments
" By default JSON cannot have comments, so it override JsonCommentAsError from "vim-polyglot"
syntax match Comment +\/\/.\+$+

