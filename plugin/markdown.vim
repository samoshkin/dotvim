" Generate TOC for current markdown file (using 'doctoc' package)
" You have to install 'https://www.npmjs.com/package/doctoc' first
" Alternative solution #1: to use Vim plugin: 'mzlogin/vim-markdown-toc'
" Alt solution #2: Use :InsertToc from "plasticboy/vim-markdown" plugin
command -nargs=* MarkdownToc :silent !doctoc <args> % >/dev/null

" PLUGIN: plasticboy/vim-markdown
" ===============================
" Features:
" - Folding based on MD headers
" - syntax
" - syntax concealing
" - fenced code block languages
" - "ge" to open anchor in Vim, "gx" to open in a browser
" - new list item indentation
" - navigation back and forth between headers
" - generate TOC, show drawer with TOC
let g:vim_markdown_folding_style_pythonic = 0
let g:vim_markdown_folding_level = 1
let g:vim_markdown_folding_disabled = 1

" Do not require .md extensions for Markdown links
let g:vim_markdown_no_extensions_in_markdown = 1

" Disable character conceal
let g:vim_markdown_conceal = 0

" Allows the "ge" command to follow named anchors in links of the form file#anchor or just #anchor
let g:vim_markdown_follow_anchor = 1

" Do not automatically indent nested list items
let g:vim_markdown_new_list_item_indent = 0
let g:vim_markdown_auto_insert_bullets = 1

" Disable auto write/save, since we have general non-markdown specific mechanism
let g:vim_markdown_autowrite = 0


" PLUGIN: iamcco/markdown-preview.nvim
" =====================================
" Live markdown preview (Github flavored markdown) + support for sequence-diagrams, flowchart, mermaid, toc
" Use explicit :MarkdownPreview, :MarkdownPreviewStop commands
let g:mkdp_auto_start = 0

" Do not automatically close preview in a browser when leaving .md file for another buffer
let g:mkdp_auto_close = 0

" Refresh markdown when save the buffer or leave from insert mode
let g:mkdp_refresh_slow = 1

" Print URL of the preview page after :MarkdownPreview command
let g:mkdp_echo_preview_url = 1


" PLUGIN: junegunn/limelight.vim
" ===============================
" Dims all paragraphs in a file except the current one
" Use :Limelight!! command to toggle it
" NOTE: You can use it outside Markdown files as well
let g:limelight_default_coefficient = 0.7
let g:limelight_priority = -1
