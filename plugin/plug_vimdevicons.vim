if exists("g:__loaded_plug_vimdevicons")
  finish
endif
let g:__loaded_plug_vimdevicons = 1

" Enable for NERDTree
let g:webdevicons_enable_nerdtree = 1

" Do not to show the nerdtree brackets around flags
let g:webdevicons_conceal_nerdtree_brackets = 1

" Show icons for directories
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:WebDevIconsUnicodeGlyphDoubleWidth = 0

" Use different icons for opened and closed folder
let g:DevIconsEnableFoldersOpenClose = 1

" Do not put extra whitespace before icon
let g:WebDevIconsNerdTreeBeforeGlyphPadding=''

" Report OS to set an icon for unix fileformat (not defined by default)
" This is useful for avoiding unnecessary system() call.
let g:WebDevIconsOS = 'Darwin'

if exists("g:loaded_webdevicons")
  call webdevicons#refresh()
endif
