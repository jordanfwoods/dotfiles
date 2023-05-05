""""""""""""""""""""""""""""""""
"" AIR-LINE (STATUS LINE)
""""""""""""""""""""""""""""""""
" Make Airline do what I want
function! MyRelativePath()
  if (stridx(expand('%:p'),$PWD) > -1) | return substitute(expand('%:p'), $PWD,'.','')
  else                                 | return substitute(expand('%:p'),$HOME,'~','') | endif
endfunction

let g:airline_theme='gruvbox'
let g:airline_skip_empty_sections = 1
if !exists('g:airline_symbols') | let g:airline_symbols = {} | endif
let g:airline_symbols.maxlinenr = '≡ '
let g:airline_symbols.linenr = ' № '
let g:airline_symbols.colnr = '℅:'
let g:airline_section_c =  '%<%{MyRelativePath()}%m %#__accent_red#'
let g:airline_section_c .= '%{airline#util#wrap(airline#parts#readonly(),0)}'
let g:airline_section_c .= '%#__restore__#%#__accent_bold#%#__restore__#%#__accent_bold#%#__restore__#'
" let g:airline_powerline_fonts = 1
" let g:airline_detect_modified=1
" let g:airline_left_sep = '▶'
" let g:airline_right_sep = '◀'

