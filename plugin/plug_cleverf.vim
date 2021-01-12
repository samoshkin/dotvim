if exists("g:__loaded_plug_cleverf")
  finish
endif
let g:__loaded_plug_cleverf = 1

" Add highlighting for f/t searches
" Uses f/t to advance to next match instead of using ';' and ','
let g:clever_f_ignore_case = 1
let g:clever_f_smart_case = 1

" Use same highlighting group as a normal search
let g:clever_f_mark_char_color = 'IncSearch'

" Use ; character as a placeholder for any sign characters: {, (, "
let g:clever_f_chars_match_any_signs = ';'

" Always want to search forward with f and always want to search backward with F
let g:clever_f_fix_key_direction = 1

