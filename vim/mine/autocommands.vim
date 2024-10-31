""""""""""""""""""""""""""""""""
"" AUTO COMMANDS
""""""""""""""""""""""""""""""""
" VIM Commentary doesn't have my filetype defaults the way I like.
autocmd FileType verilog_systemverilog setlocal commentstring=//\ %s
autocmd FileType systemrdl             setlocal commentstring=//\ %s
autocmd FileType c                     setlocal commentstring=//\ %s
autocmd FileType cpp                   setlocal commentstring=//\ %s
autocmd FileType vhdl                  setlocal commentstring=--\ %s
autocmd FileType xdc                   setlocal commentstring=#\ %s
autocmd FileType matlab                setlocal commentstring=%\ %s
autocmd FileType todo_done             setlocal commentstring=#\ %s
autocmd FileType todo_done             setlocal foldlevelstart=1
autocmd FileType todo_done             setlocal foldmethod=expr
autocmd FileType todo_done             setlocal foldexpr=TodoFold(v:lnum)
autocmd FileType vim                   setlocal commentstring=\"\ %s
autocmd FileType vim                   setlocal foldmethod=marker

" Reliably prompt for file changes upon changing buffers.
au FocusGained,BufEnter     * :silent! checktime
au CursorHold,CursorHoldI   * :silent! checktime
let v:fcs_choice="ask"

" To-do List filetype
autocmd BufRead,BufNewFile *.done,TODO,todo,*.todo setlocal filetype=todo_done
autocmd BufRead,BufNewFile *.rdl                   setlocal filetype=systemrdl
autocmd BufRead,BufNewFile *.xci                   setlocal filetype=xml

" Xilinx Template files
autocmd BufRead,BufNewFile *.veo                   setlocal filetype=verilog_systemverilog
autocmd BufRead,BufNewFile *.vho                   setlocal filetype=vhdl

augroup dateformats
   autocmd!
   " Remove Roman Numerals
   autocmd VimEnter * silent execute 'SpeedDatingFormat! %^v'
   autocmd VimEnter * silent execute 'SpeedDatingFormat! %v'
   " Add Custom Dating Formats
   autocmd VimEnter * silent execute '1SpeedDatingFormat %a, %d %b %Y'
   autocmd VimEnter * silent execute '1SpeedDatingFormat %m/%d/%Y'
   autocmd VimEnter * silent execute '1SpeedDatingFormat %-I:%M %P'
augroup END
