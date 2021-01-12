" This code is put in "after/" directory to be run any code in vimrc + "plugin/"

set background=dark

" Make sign column look like line number column
let g:gruvbox_sign_column="dark0_hard"
" Use a bit darker background color
let g:gruvbox_contrast_dark="hard"

" Apply a particular color scheme
" This triggers "autocmd ColorScheme" and sourcing of 'after/colors/{scheme}.vim'
colorscheme gruvbox
