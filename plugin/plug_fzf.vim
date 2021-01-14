if exists("g:__loaded_plug_fzf_vim")
  finish
endif
let g:__loaded_plug_fzf_vim = 1

" Use vim window popup
let g:fzf_layout = { 'window': { 'width': 1, 'height': 0.8, 'yoffset': 0, 'border': 'bottom', 'highlight': 'Todo' } }
" let g:fzf_layout = { 'down': '~40%' } " use terminal window
" let g:fzf_layout = { 'window': 'enew' } " use vim window

let $FZF_DEFAULT_OPTS = '--layout=reverse --preview-window="noborder:wrap" --info=inline --multi --bind="f2:toggle-preview,ctrl-w:toggle-preview-wrap,ctrl-d:half-page-down,ctrl-u:half-page-up,ctrl-l:clear-query"'

" Ctrl-q allows to select multiple elements an open them in quick list
let g:fzf_action = {
      \ 'ctrl-q': function('_#qfloc#build_quickfix_list'),
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-s': 'split',
      \ 'ctrl-v': 'vsplit' }

" Prefix all fzf.vim exported commands with "Fzf"
let g:fzf_command_prefix = 'Fzf'

" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

" Preview window options
let g:fzf_preview_window = ['right:50%:wrap']

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'

" "pbogut/fzf-mru.vim" settings
" MRU cache location is: "echo fzf_mru#mrufiles#cachefile()"
" Store only files relative to cwd, we don't care about files outside the workspace
let g:fzf_mru_relative = 1

" Regex pattern to exclude files from MRU list (if you need it)
" let g:fzf_mru_exclude = ''
"
" Keep up to 20 items in MRU
let g:fzf_mru_max = 20

" File path completion in Insert mode using fzf
" Enhance native <C-x> insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-buffer-line)

" Mappings
nnoremap <silent> <leader>o :FzfFiles<CR>
nnoremap <silent> <leader>O :FzfFiles /<CR>
nnoremap <silent> <leader>p :FzfMru<CR>
nnoremap <silent> <leader>b  :FzfBuffers<CR>
nnoremap <silent> <leader>gl :FzfBLines<CR>
nnoremap <silent> <leader>`  :FzfMarks<CR>
nnoremap <silent> <leader>; :FzfCommands<CR>
" NOTE: BTags generates tags for the current buffer on a fly despite having project-wide "tags"
nnoremap <silent> <leader>] :FzfBTags<CR>
nnoremap <silent> <leader>} :FzfTags<CR>
nnoremap <silent> <F1> :FzfHelptags<CR>
inoremap <silent> <F1> <ESC>:FzfHelptags<CR>
cnoremap <silent> <expr> <C-p> getcmdtype() == ":" ? "<C-u>:FzfHistory:\<CR>" : "\<ESC>:FzfHistory/\<CR>"
cnoremap <silent> <C-_> <C-u>:FzfCommands<CR>

" MRU files. Adopted from 'pbogut/fzf-mru.vim'
" Native's "v:oldfiles" does not work, since v:oldfiles is read only on Vim startup
command! FzfMru call fzf#run(fzf#wrap(fzf#vim#with_preview({
      \ 'source':  fzf_mru#mrufiles#source(),
      \ 'options': ['--preview-window', 'noborder', '-m', '--prompt', 'MRU> ', '+s', '--preview-window', 'right:50%' ] })))
command! -nargs=0 RefreshFzfMru call fzf_mru#mrufiles#refresh()

" Override 'FzfCommands' command to fuzzy search only by 2nd column (command name)
" <Enter> to pick command but not execute, <C-x> to execute immediately
command! -nargs=0 FzfCommands call fzf#vim#commands({ 'options': ['--nth', '2'] })

