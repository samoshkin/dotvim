if exists("g:__loaded_git")
  finish
endif
let g:__loaded_git = 1

" Customize the options used by 'git log':
let g:fzf_commits_log_options = '--graph --color=always --format="%C(yellow)%h%C(reset) %C(cyan)%d%C(reset) %s %C(240)%cr%C(reset)"'
let g:__fzf_commits_log_options = g:fzf_commits_log_options

" Redefine these fzf commands to make wider preview window
command! -bang FzfCommits    call fzf#vim#commits({ "options": ["--preview-window", "right:60%"] }, <bang>0)
command! -bang FzfBCommits   call fzf#vim#buffer_commits({ "options": ["--preview-window", "right:60%"] }, <bang>0)
command! -bang FzfGitStatus  call fzf#vim#gitfiles('?', { "placeholder": "", "options": ["--preview-window", "right:60%"] }, <bang>0)

" Open diffs in a new tab
" NOTE: this overwrites old deprecated :Gdiff command from vim-fugitive
command! -nargs=* Gdiff tabedit % | Gvdiffsplit <args>
command! -nargs=* GdiffUpstream tabedit % | exe "Gdiffsplit ".system("git merge-base HEAD $REVIEW_UPSTREAM")

" Git status
nnoremap <silent> <leader>Gs :Git<CR>
nnoremap <silent> <leader>GS :FzfGitStatus<CR>

" Git log (reachable from HEAD, --all commits, only commits that affect current file)
nnoremap <silent> <leader>Glo :FzfCommits<CR>
nnoremap <silent> <leader>Gla :call <SID>FzfAllCommits()<CR>
nnoremap <silent> <leader>Glb :FzfBCommits<CR>

" Load file snapshots from previous revisions into a loclist
nnoremap <silent> <leader>Gh :0Gclog<CR>
vnoremap <silent> <leader>Gh :Gclog<CR>

" Return to working tree version from blob/blame/log
" Toggle between index and working tree version
nnoremap <silent> <leader>Ge :Gedit<CR>

" Git blame
nnoremap <silent> <leader>Gb :Git blame<CR>

" Diff (vs working tree, vs ancestor commit, vs HEAD)
" NOTE: use :Gedit | GdiffTab HEAD, to compare index vs HEAD
nnoremap <silent> <leader>Gdw :Gdiff<CR>
nnoremap <silent> <leader>Gd~ :Gdiff !~<CR>
nnoremap <silent> <leader>Gdh :Gdiff HEAD<CR>

" Undo changes in working tree
nnoremap <silent> <leader>Gu :Gread<CR>

augroup aug_git_integration
  au!

  " Show Fugitive status window in separate tab
  autocmd BufEnter */.git/index
        \ if !exists('b:created') && get(b:, 'fugitive_type', '') == 'index' |
        \   let b:created = 1 |
        \   wincmd T |
        \ endif

  " Collapse status window when viewing diff or editing commit message
  autocmd BufLeave */.git/index call _#fugitive#OnStatusBufferEnterOrLeave(0)
  autocmd BufEnter */.git/index call _#fugitive#OnStatusBufferEnterOrLeave(1)

  " Delete fugitive buffers automatically on leave
  autocmd BufReadPost fugitive://* set bufhidden=wipe
augroup END

" Show all commits (e.g git log --all) by changing log options for the duration of the command
function! s:FzfAllCommits()
  let g:fzf_commits_log_options .= ' --all'
  FzfCommits
  let g:fzf_commits_log_options = g:__fzf_commits_log_options
endfunction

" PLUGIN: vim-gitgutter
let g:gitgutter_enabled = 1

" Do not echo messages when navigating hunks
let g:gitgutter_show_msg_on_hunk_jumping = 0

" Use quickfix list when gathering all hunks
let g:gitgutter_use_location_list = 0

" Do not allow gitgutter clobber other signs (e.g ALE or coc.nvim)
let g:gitgutter_sign_allow_clobber = 0

" Gitgutter signs should have least priority (Vim's default = 10)
let g:gitgutter_sign_priority = 9

nnoremap <silent> <leader>df :GitGutterFold<CR>
nnoremap <silent> <leader>dq :GitGutterAllChanges<CR>
nnoremap <silent> <leader>td :GitGutterBufferToggle<CR>

" View all hunks/changes project-wide in a quickfix list
command! -nargs=0 GitGutterAllChanges GitGutterQuickFix | exe "norm mQ" | copen

" " Use 'd' as a motion for hunks, instead of default 'c'
" " Use '[d' and ']d' to move between hunks in regular files and in diff mode
" " It's easier to use 'do' and 'dp' when a finger is already on 'd' key
nmap ]d <Plug>(GitGutterNextHunk)zz
nmap [d <Plug>(GitGutterPrevHunk)zz

" Undo and stage diff hunks in normal mode
nmap <silent> <leader>du <Plug>(GitGutterUndoHunk)
nmap <silent> <leader>ds <Plug>(GitGutterStageHunk)
nmap <silent> <leader>dp <Plug>(GitGutterPreviewHunk)

" Text objects for diff hunks
omap id <Plug>(GitGutterTextObjectInnerPending)
omap ad <Plug>(GitGutterTextObjectOuterPending)
xmap id <Plug>(GitGutterTextObjectInnerVisual)
xmap ad <Plug>(GitGutterTextObjectOuterVisual)
