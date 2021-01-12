if exists("g:__loaded_statusline")
  finish
endif
let g:__loaded_statusline = 1

" Do not show default '--INSERT--' status
set noshowmode

" Display uncompleted keystrokes in the status line
set showcmd

" Always show status line, even when 1 window is opened
set laststatus=2

" Configure lightline components and layout
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'relativepath'],
      \             [ 'current_symbol' ]],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'fileformat', 'fileencoding', 'filetype', 'format_settings', 'tabspaces'],
      \              [ 'coc_status'],
      \              [ 'mixed_whitespace' ],
      \              [ 'flags' ]]
      \ },
      \ 'inactive': {
      \   'left': [ ['filename'] ],
      \   'right': [ [], ['filetype'] ]
      \ },
      \ 'component': {
      \   'flags': '%<%#LightlineFlagBlue#%( %{LightlineFlagAutosave()} %)%( %{LightlineFlagSession()} %)%( %{LightlineFlagTags()} %)%#LightlineRight_normal_3#'
      \ },
      \ 'component_expand': {
      \   'mixed_whitespace': 'LightlineMixedWhitespace',
      \   'coc_status': 'LightlineCocStatus'
      \ },
      \ 'component_type': {
      \   'mixed_whitespace': 'warning',
      \   'coc_status': 'warning'
      \ },
      \ 'component_raw': {
      \   'flags': 1
      \ },
      \ 'component_function' : {
      \   'tabspaces': 'LightlineTabSpaces',
      \   'gitbranch': 'LightlineGitbranch',
      \   'filetype': 'LightlineFiletype',
      \   'filename': 'LightlineFilename',
      \   'relativepath': 'LightlineRelativepath',
      \   'mode': 'LightlineMode',
      \   'fileformat': 'LightlineFileformat',
      \   'fileencoding': 'LightlineFileencoding',
      \   'format_settings': 'LightlineFormatSettings',
      \   'current_symbol': 'LightlineCurrentSymbol',
      \   'percent': 'LightlinePercent',
      \   'lineinfo': 'LightlineLineinfo'
      \ },
      \ 'enable': {
      \   'statusline' : 1,
      \   'tabline': 1
      \ }
      \ }

" Detect special buffers and tell their type
function LightlineDetectBufferKind(timer)
  let b:buffer_kind = &buftype == 'terminal' ? 'terminal' :
        \ exists("b:NERDTree") && &ft ==# 'nerdtree' ? 'nerdtree' :
        \ (&ft ==# 'vista' || &ft ==# 'vista_kind' || &ft ==# 'vista_markdown') ? 'vista' :
        \ (&ft == 'list' && expand('%') =~ '^list:///') ? 'coclist' :
        \ (&ft ==# 'help') ? 'help' :
        \ (get(b:, 'fugitive_type', '') != '') ? 'fugitive' :
        \ 'regular'
endfunction

function s:GetBufferKind()
  return get(b: , 'buffer_kind', '')
endfunction

" Mode: INSERT | NORMAL | ...
" Do not show for some plugin windows, and for narrow windows
function! LightlineMode()
  let bufferKind = s:GetBufferKind()
  return bufferKind != 'regular' ? toupper(bufferKind) :
        \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

" Filename only
function! LightlineFilename()
  return LightlinePath('%:t')
endfunction

" Relative filepath
function! LightlineRelativepath()
  return LightlinePath('%')
endfunction

" File type + devicons
function! LightlineFiletype()
  if s:GetBufferKind() != 'regular' | return '' | endif

  return strlen(&filetype) ? WebDevIconsGetFileTypeSymbol() . ' '. &filetype : 'no ft'
endfunction

" File path
" Show only filename for narrow windows, detect Scratch windows, show buffer
" number in diff mode, append '+' modified sign
function LightlinePath(expand)
  let bufferKind = s:GetBufferKind()
  if index(['regular', 'help', 'fugitive', 'terminal'], bufferKind) < 0 | return '' | endif

  let l:expand = a:expand
  if (bufferKind == 'help' || winwidth(0) < 60)
    let l:expand = "%:t"
  endif

  let l:isScratch = &buftype ==# 'nofile' && (&bufhidden ==# 'wipe' || &bufhidden ==# 'delete') && !buflisted(bufnr('%'))

  let l:filename = expand(l:expand) !=# '' ? expand(l:expand) :
        \ l:isScratch ? '[Scratch]' : '[No Name]'

  " When browsing Git objects, strip off "fugitive:///" leading part
  if bufferKind == 'fugitive'
    let filename_git_path = matchstr(l:filename, '\v/\zs.git/.*\ze')
    let l:filename = filename_git_path != '' ? filename_git_path : l:filename
  endif

  " Make sure path does not become too long in narrow windows
  if winwidth(0) < 70 && strlen(l:filename) > 40
    let l:filename = _#util#shorten_file_path(l:filename)
  endif

  let l:modified = LightlineModified()
  if l:modified !=# ''
    let l:filename .= l:modified
  endif

  return l:filename
endfunction

" Show icon when auto save is ON
function! LightlineFlagAutosave()
  if s:GetBufferKind() != 'regular' | return '' | endif

  return _#util#get_var('auto_save', 0) ? '' : ''
endfunction

" Show icon when tags are generated automatically (by gutentags)
function! LightlineFlagTags()
  if s:GetBufferKind() != 'regular' | return '' | endif

  return get(g:, 'gutentags_enabled', 0) ? '' : ''
endfunction

" Show icons when session is loaded and tracked (by vim-obsession)
function! LightlineFlagSession()
  if s:GetBufferKind() != 'regular' | return '' | endif

  return ObsessionStatus('ⓢ', '')
endfunction

" Show current git branch
function! LightlineGitbranch()
  if winwidth(0) < 70 || s:GetBufferKind() !~ '^\(regular\|fugitive\)$' || !exists('*FugitiveHead')
    return ''
  endif

  let branch = s:cached_git_branch()
  if branch ==# ''
    return ''
  endif

  return ' '.branch
endfunction

" Cache git branch calculation, because FugitiveHead() is quite heavy operation
function! s:cached_git_branch()
  if get(b:, 'old_changedtick_2', 0) == b:changedtick && exists('b:_cached_git_branch')
    return b:_cached_git_branch
  endif

  let b:_cached_git_branch = FugitiveHead(7)
  let b:old_changedtick_2 = b:changedtick

  return b:_cached_git_branch
endfunction

" Show tab vs spaces settings
function! LightlineTabSpaces()
  if s:GetBufferKind() != 'regular' | return '' | endif

  if &expandtab
    return 'sw='.&shiftwidth
  elseif &tabstop == &shiftwidth
    return 'ts='.&tabstop
  else
    return 'sw='.&shiftwidth.',ts='.&tabstop
  endif
endfunction

" Show '+' and '-' signs for modified and nonmodifiable buffers
function! LightlineModified()
  if s:GetBufferKind() != 'regular' | return '' | endif

  return &modified ? '+' : &modifiable ? '' : '-'
endfunction

" Hide fileformat for narrow windows, and when it's 'unix'
function! LightlineFileformat()
  if s:GetBufferKind() != 'regular' | return '' | endif

  if winwidth(0) < 70 || &fileformat == 'unix'
    return ''
  endif

  return &fileformat
endfunction

" Hide file encoding for narrow windows, and when it's 'utf-8'
function! LightlineFileencoding()
  if s:GetBufferKind() != 'regular' | return '' | endif

  let l:enc = &fenc !=# '' ? &fenc : &enc

  if winwidth(0) < 70 || l:enc == 'utf-8'
    return ''
  endif

  return l:enc
endfunction

" Show line:col info
function! LightlineLineinfo()
  let bufferKind = s:GetBufferKind()
  if bufferKind != 'regular' && bufferKind != 'help'  | return '' | endif

  return printf("%3d:%-2d", line('.'), col('.'))
endfunction

" Relative position of the cursor in percents
function! LightlinePercent()
  let bufferKind = s:GetBufferKind()
  if bufferKind != 'regular' && bufferKind != 'help'  | return '' | endif

  return (100 * line('.') / line('$')) . '%'
endfunction

" Show line number of inconsistent whitespace issues
function! LightlineMixedWhitespace()
  if s:GetBufferKind() != 'regular' | return '' | endif

  let whitespace_issues = _#mixedwhitespace#check()
  let first_occurence = min(filter(whitespace_issues, 'v:val > 0'))
  if first_occurence > 0
    return printf('WS:%d', first_occurence)
  endif

  return ''
endfunction

" Show format options: format on save, format on insert leave, use of lang server
function! LightlineFormatSettings()
  if s:GetBufferKind() != 'regular' | return '' | endif

  let l:fmt_use_lang_server = _#util#get_var('fmt_use_lang_server', 0)
  let l:fmt_use_neoformat = _#util#get_var('fmt_use_neoformat', 0)
  let l:fmt_on_save = _#util#get_var('fmt_on_save', 0)
  let l:fmt_on_insert_leave = _#util#get_var('fmt_on_insert_leave', 0)

  let status = ''
  if l:fmt_use_lang_server
    let status .= 'L'
  elseif l:fmt_use_neoformat
    let status .= 'N'
  endif

  if l:fmt_on_save
    let status .= ':S'
  endif

  if l:fmt_on_insert_leave
    let status .= ':I'
  endif

  if !empty(status)
    let status = ' '.status
  endif

  return status
endfunction

" Report diagnostic issues from coc.nvim
function! LightlineCocStatus()
  if s:GetBufferKind() != 'regular' | return '' | endif

  let diaginfo = get(b:, 'coc_diagnostic_info', {})
  let errors = get(diaginfo, 'error', 0)
  let warnings = get(diaginfo, 'warning', 0)
  let info = get(diaginfo, 'information', 0)

  if (errors == 0) && (warnings == 0) && (info == 0)
    return ''
  endif

  return ' '.errors.':'.warnings.(info == 0 ? '' : ':'.info)
endfunction

" Show current symbol under the cursor (function or method)
" Tracked and reported by 'liuchengxu/vista.vim'
" TODO (consider): do we need it?
function! LightlineCurrentSymbol()
  " if s:GetBufferKind() != 'regular' | return '' | endif

  " let symbol = get(b:, 'vista_nearest_method_or_function', '')
  " if symbol == ''
  "   return ''
  " endif

  " return ' '.symbol
  return ""
endfunction

" Refresh lightline, only when there're new changes
function! s:lightline_whitespace_refresh()
  if get(b:, 'old_changedtick_1', 0) == b:changedtick
    return
  endif
  call lightline#update()
  let b:old_changedtick_1 = b:changedtick
endfunction

augroup aug_lightline
  autocmd!

  autocmd BufEnter,FileType,BufRead * call timer_start(50, 'LightlineDetectBufferKind')

  autocmd CursorHold,BufWritePost * call s:lightline_whitespace_refresh()
  autocmd user CocStatusChange,CocDiagnosticChange call lightline#update()
augroup END

" Tweak 'powerline' colorscheme
let p = g:lightline#colorscheme#powerline#palette

" Do not hightlight middle section in insert mode
let p.insert.middle = p.normal.middle

" Modify warning and error sections to match Gruvbox theme
" Introduce warning_inverse and error_inverse sections
let p.normal.warning = [ ['#262626', '#fe8019', 235, 208 ] ]
let p.normal.warning_inverse = [ ['#fe8019', '#262626', 208, 235 ] ]
let p.normal.error = [ ['#262626', '#fb4934', 235, 167 ] ]
let p.normal.error_inverse = [ ['#fb4934', '#262626', 167, 235 ] ]
let p.terminal = {}

" gray8, gray2
let p.tabline.middle = [['#9e9e9e', '#303030', 247, 236]]
" gray8, gray2
let p.tabline.left = [['#9e9e9e', '#303030', 247, 236]]
" white, 240
let p.tabline.tabsel = [['#ffffff', '#585858', 231, 240]]
" gray8, gray3
let p.tabline.right = [['#9e9e9e', '#4e4e4e', 247, 239]]

let p.terminal.left = [['#000000', '#c57bdb', 16, 98, 'bold'], ['#ffffff', '#303030', 231, 236]]
let p.terminal.middle = p.normal.middle
let p.terminal.right = [['#9e9e9e', '#303030', 247, 236], ['#9e9e9e', '#303030', 247, 236], ['#9e9e9e', '#303030', 247, 236]]

let g:lightline#colorscheme#powerline#palette = p
" let g:lightline#colorscheme#powerline#palette = lightline#colorscheme#fill(p)

" Disable whitespace checking in these filetypes
let g:whitespace#skip_check_ft = g:extra_whitespace_ignored_filetypes

