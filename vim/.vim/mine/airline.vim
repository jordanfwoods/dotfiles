""""""""""""""""""""""""""""""""
"" AIR-LINE (STATUS LINE)
""""""""""""""""""""""""""""""""
" Make Airline file path relative based on the directory that I opened vim from...
function! MyRelativePath()
  if     (stridx(expand('%:p'),'/home/jwoods/[[SCRATCH]]') > -1) | return "[[SCRATCH]]"
  elseif (stridx(expand('%:p'),$PWD.'/') > -1) | return substitute(expand('%:p'), $PWD.'/','','')
  else                                         | return substitute(expand('%:p'),$HOME,'~','') | endif
endfunction
if has('gui_running') " Use relative filepath (with autochdir enabled), %F is default
  let g:airline_section_c = '%<%f%m %#__accent_red#'
else " Use the Function above
  let g:airline_section_c = '%<%{MyRelativePath()}%m %#__accent_red#'
endif
" Use these all the time (for readonly, changes made, etc.)
let g:airline_section_c .= '%{airline#util#wrap(airline#parts#readonly(),0)}'
let g:airline_section_c .= '%#__restore__#%#__accent_bold#%#__restore__#%#__accent_bold#%#__restore__#'

" Make Airline File Type not abbreviate.
function! MyFixedFileType()
  " return (airline#util#winwidth() < 5 && strlen(&filetype) > 3)
  "       \ ? matchstr(&filetype, '...'). (&encoding is? 'utf-8' ? '…' : '>')
  "       \ : &filetype
  return &filetype
endfunction
let g:airline_section_x = '%#__accent_bold#%#__restore__#'
for item in range(1,5) | let g:airline_section_x .= '%{airline#util#prepend("",0)}' | endfor
let g:airline_section_x .= '%{airline#util#wrap(MyFixedFileType(),0)}'

let g:airline_theme='gruvbox'
let g:airline_skip_empty_sections = 1
if !exists('g:airline_symbols') | let g:airline_symbols = {} | endif

if &encoding == 'utf-8'
   " let g:airline_detect_modified = 1
   let g:airline_powerline_fonts   = 1
   let g:airline_left_sep          = ''
   let g:airline_right_sep         = ''
   let g:airline_left_alt_sep      = ''
   let g:airline_right_alt_sep     = ''
   let g:airline_symbols.linenr    = ' :'
   let g:airline_symbols.colnr     = ' ℅:'
   let g:airline_symbols.branch    = ''
   let g:airline_symbols.readonly  = ''
   let g:airline_symbols.maxlinenr = ' '
   " other powerline symbols:� █       
endif
