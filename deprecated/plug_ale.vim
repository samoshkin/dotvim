" NOTE: not using ALE in favor of Coc.nvim

" " Commands
" nmap <leader>te <Plug>(ale_toggle_buffer)
" nmap <leader>eF <Plug>(ale_fix)
" nmap <leader>ec <Plug>(ale_reset)
" nmap <leader>ep <Plug>(ale_detail)

" " Navigate through diagnostic issues
" nmap <silent> ]e <Plug>(ale_next)
" nmap <silent> [e <Plug>(ale_previous)
" nmap <silent> ]E <Plug>(ale_last)
" nmap <silent> [E <Plug>(ale_first)

" " Open list of errors in loclist
" nnoremap <silent> <leader>ce :lopen<CR>

" " Always enabled
" let g:ale_enabled = 0

" " How to report errors
" let g:ale_set_loclist = 1
" let g:ale_open_list = 0
" let g:ale_set_highlights = 1
" let g:ale_set_signs = 1
" let g:ale_sign_highlight_linenrs = 0
" let g:ale_echo_cursor = 1
" let g:ale_cursor_detail = 0
" let g:ale_echo_delay = 50

" " How ofter to trigger linting
" let g:ale_lint_on_text_changed = 'always'
" let g:ale_lint_on_insert_leave = 1
" let g:ale_lint_on_enter = 1
" let g:ale_lint_on_save = 1
" let g:ale_lint_on_filetype_changed = 1

" let g:ale_lint_delay = 400
" let g:ale_close_preview_on_insert = 1

" " Since we already using CoC + LSP
" let g:ale_disable_lsp = 1

" " Error message format
" let g:ale_echo_msg_format = '[%linter%%: code%] %s'
" let ale_loclist_msg_format = '[%linter%%: code%] %s'

" " Sign column
" let g:ale_sign_column_always = 1
" let g:ale_sign_highlight_linenrs = 0
" " let g:ale_sign_error = ""
" " let g:ale_sign_warning = ""
" " let g:ale_sign_info = ""

" " Do not lint files greather than 1Mb
" let g:ale_maximum_file_size = 1048576

" " ESlint integration
" " Do not report errors when there's no .eslintrc config file
" " Do not report errors for files which are ignored by .eslintignore
" let g:ale_javascript_eslint_suppress_missing_config = 1
" let g:ale_javascript_eslint_suppress_eslintignore = 1

" " Configure linters per file type, per glob pattern
" let g:ale_linters = {
"       \ 'javascript': ['eslint']
"       \ }
" let g:ale_linters_ignore = {
"       \ 'javascipt': ['prettier'],
"       \ 'css': ['prettier']
"       \ }

" " Configure linters based on glob patters
" let g:ale_pattern_options = {
"       \ '\.min.js': { 'ale_enabled': 0 },
"       \ '\.min.css': { 'ale_enabled': 0 }
"       \ }

" " Do not warn about trailing whitespaces, as we highlight them manually
" " NOTE: errors comes from selected linter program, and are not produced by ALE itself
" " let g:ale_warn_about_trailing_whitespace = 0
" " let g:ale_warn_about_trailing_blank_lines = 1

" " Fixers
" let g:ale_fix_on_save = 0
" let g:ale_fixers = {
"       \   '*': ['trim_whitespace', 'remove_trailing_lines'],
"       \   'css': ['stylelint', 'csslint'],
"       \   'javascript': ['eslint', 'flow'],
"       \   'typescript': ['tslint', 'eslint'],
"       \   'sh': ['shellcheck'],
"       \   'scss': ['stylelint', 'sasslint', 'scsslint'],
"       \   'sass': ['stylelint', 'sasslint'],
"       \   'less': ['stylelint'],
"       \
