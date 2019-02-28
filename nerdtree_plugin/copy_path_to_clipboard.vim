" Inspired by https://github.com/mortonfox/nerdtree-clip

" Add submenu containing copy file path operations
let submenu = NERDTreeAddSubmenu({
      \ 'text': 'Copy (f)ile path to clipboard',
      \ 'shortcut': 'f' })
call NERDTreeAddMenuSeparator()

" Copy file basename only
" Copy full file path
" Copy file's dirname
call NERDTreeAddMenuItem({
      \ 'text': 'file (n)ame',
      \ 'shortcut': 'n',
      \ 'parent': submenu,
      \ 'callback': '_CopyFileName' })
call NERDTreeAddMenuItem({
      \ 'text': 'file (p)ath',
      \ 'shortcut': 'p',
      \ 'parent': submenu,
      \ 'callback': '_CopyFilePath' })
call NERDTreeAddMenuItem({
      \ 'text': 'file (d)irname',
      \ 'shortcut': 'd',
      \ 'parent': submenu,
      \ 'callback': '_CopyDirName' })

function _CopyFileName()
  call _CopyToClipboard(':t')
endfunction

function _CopyFilePath()
  call _CopyToClipboard(':p:~')
endfunction

function _CopyDirName()
  call _CopyToClipboard(':p:~:h')
endfunction

function _CopyToClipboard(modifiers)
  let node = g:NERDTreeFileNode.GetSelected()
  let result = fnamemodify(node.path.str(), a:modifiers)

  let @+ = result
  redraw
  echomsg 'Copied to clipboard: ' . result
endfunction

