" Use prettier for formatter tool
exe "setlocal formatprg=" . GetPrettierAsFormatPrg()
let b:ale_fixers = ['prettier']
