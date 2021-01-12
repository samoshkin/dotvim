if exists("g:__loaded_plug_exchange")
  finish
endif
let g:__loaded_plug_exchange = 1

let g:exchange_no_mappings = 1

" Text exchange operator
" On the first use of "xc", define the first {motion} to exchange.
" On the second use of "xc", define the second {motion} and perform the exchange.
nmap xc <Plug>(Exchange)
xmap <leader>x <Plug>(Exchange)
nmap xcx <Plug>(ExchangeClear)
nmap xcc <Plug>(ExchangeLine)

