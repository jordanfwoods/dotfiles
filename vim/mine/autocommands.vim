""""""""""""""""""""""""""""""""
"" AUTO COMMANDS
""""""""""""""""""""""""""""""""
" VIM Commentary doesn't have my filetype defaults the way I like.
autocmd FileType verilog_systemverilog setlocal commentstring=//\ %s
autocmd FileType c                     setlocal commentstring=//\ %s
autocmd FileType cpp                   setlocal commentstring=//\ %s
autocmd FileType vhdl                  setlocal commentstring=--\ %s
autocmd FileType xdc                   setlocal commentstring=#\ %s
autocmd FileType matlab                setlocal commentstring=%\ %s
autocmd FileType todo_done             setlocal commentstring=#\ %s

" Reliably prompt for file changes upon changing buffers.
au FocusGained,BufEnter     * :silent! checktime
au CursorHold,CursorHoldI   * :silent! checktime
let v:fcs_choice="ask"

" To-do List filetype
autocmd BufRead,BufNewFile *.done,TODO,todo,*.todo setlocal filetype=todo_done

