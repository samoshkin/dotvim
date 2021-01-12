if exists("g:__loaded_spell")
  finish
endif
let g:__loaded_spell = 1

" Use .vim dir for now. Later use dropbox dir to share spellfile between machines
let g:spelldir=expand('~/.vim/tmp/spell')

if !isdirectory(g:spelldir)
  call mkdir(g:spelldir, 'p', 0700)
endif

" Used for <C-x><C-k> completion in insert mode
" Not used for spellcheck purposes
set dictionary=/usr/share/dict/words

" Disable spell checking by default
set nospell

set spelllang=en

" Dict with words marked as good/wrong
set spellfile=~/.vim/tmp/spell/dict.utf-8.add

" In Insert mode automatically fix last misspelled word by picking first suggestion
inoremap <C-s>f <C-G>u<Esc>[s1z=gi<C-G>u

" In insert mode, select previous misspelled word, and drop in Select mode
" In insert mode, we usually don't care about next misspelled word
inoremap <C-s>s <Esc>[sve<C-G>

