if exists("g:__loaded_plug_gutentags")
  finish
endif
let g:__loaded_plug_gutentags = 1

let g:gutentags_define_advanced_commands = 1

" Only git repos are considered as a project root
" TODO (consider): always enable gutentags, but only in whitelisted projects (beneath
" ~/projects or ~ dir). Implement via custom root finder and vim-rooter
" For now, enable gutentags explicitly, or use project-local vimrc to enable it per project
let g:gutentags_project_root = ['.git']

" Let git provide a list of files to create tags for
let g:gutentags_file_list_command = {
      \ 'markers': {
      \   '.git': 'git ls-files -c -m -o --exclude-standard',
      \ },
      \ }

" Keep tags file in a dedicated cache dir
let g:gutentags_cache_dir="~/.cache/ctags"

" Disabled by default
let g:gutentags_enabled = 0

" Toggle tag generation manually
command! GutentagsToggle :call <SID>GutentagsToggle()
nnoremap <silent> <leader>tt :GutentagsToggle<CR>

function s:GutentagsToggle()
  GutentagsToggleEnabled

  " When enabled, force update tags file for all project
  if g:gutentags_enabled
    echo "[Tags generate]: ON"
    GutentagsUpdate!
  else
    echo "[Tags generate]: OFF"
  endif
endfunction

