if exists("g:__loaded_plug_editorconfig")
  finish
endif
let g:__loaded_plug_editorconfig = 1

let g:EditorConfig_exclude_patterns = ['fugitive://.*']

" Highlights when line exceeds allowed length (column 80 marker)
let g:EditorConfig_max_line_indicator = 'exceeding'
let g:EditorConfig_preserve_formatoptions = 1
