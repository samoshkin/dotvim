if exists("g:__loaded_plug_findfiles")
  finish
endif
let g:__loaded_plug_findfiles = 1


" TODO: Rely on fd respecting .gitignore
let g:search_ignore_dirs = ['.git', 'node_modules']

function s:findprg_compose_ignoredir_args(backend, ignore_dirs)
  if empty(a:ignore_dirs)
    return ""
  endif

  let args = []
  if a:backend ==# 'fd'
    for l:dir in a:ignore_dirs
      call add(args, '-E ' . shellescape(printf('%s/', l:dir)))
    endfor
    return join(args)
  else
    for l:dir in a:ignore_dirs
      call add(args, '-path ' . shellescape(printf('*/%s/*', l:dir)))
    endfor
    return "\\( " . join(args) . " \\) -prune -o"
  endif
endfunction

" Similar to built-in grepprg, makeprg
if executable('fd')
  let g:find_files_findprg = printf("fd --hidden --follow %s $* $d", s:findprg_compose_ignoredir_args("fd", g:search_ignore_dirs))
else
  let g:find_files_findprg = printf("find $d %s ! -type d $* -print", s:findprg_compose_ignoredir_args("find", g:search_ignore_dirs))
endif

