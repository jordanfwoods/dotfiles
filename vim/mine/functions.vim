" Make Airline do what I want
function! MyRelativePath()
  if (stridx(expand('%:p'),$PWD) > -1) | return substitute(expand('%:p'), $PWD,'.','')
  else                                 | return substitute(expand('%:p'),$HOME,'~','') | endif
endfunction

"" To-do Function " manage check boxes
function! TodoFunc(...)
  let pos = col(".")
  execute "normal! ^"
  if getline(".")[col(".")-1] != "[" | execute "normal! f[" | endif
  if getline(".")[col(".")-1] == "["
    if     a:1 == "1" | execute "normal! lr√f]"
    elseif a:1 == "2" | execute "normal! lrIf]"
    elseif a:1 == "3" | execute "normal! lrXf]"
    elseif a:1 == "4" | execute "normal! lr f]"
    elseif a:1 == "6" | execute "normal! da]x" | let pos = pos-4
    endif
  endif
  if a:1 == "5" | execute "normal! ^i[ ] " | let pos = pos+4 | endif
  if a:lastline == a:firstline | call cursor(line("."),pos) | endif
  if a:lastline != a:firstline
    +1
  endif
endfunction

function! MarkDebug()
  if &filetype =~ "verilog"
    execute "normal! ^"
    if     expand("<cWORD>") ==? "reg"    | exe "normal! i(* MARK_DEBUG = \"TRUE\" *) "
    elseif expand("<cWORD>") ==? "wire"   | exe "normal! i(* MARK_DEBUG = \"TRUE\" *) "
    elseif expand("<cWORD>") ==? "input"  | exe "normal! i(* MARK_DEBUG = \"TRUE\" *) "
    elseif expand("<cWORD>") ==? "output" | exe "normal! i(* MARK_DEBUG = \"TRUE\" *) "
    endif
    +1
  elseif &filetype =~ "vhdl"
    execute "normal! ^"
    if     expand("<cWORD>") ==? "signal" | exe "normal! yypciwattribute mark_debug off:lC signal is \"true\";"
    endif
    +1
  endif
endfunction

function! UnmarkDebug()
  let l:pos = getcurpos()
  if &filetype =~ "verilog"
    silent g/(\* mark_debug = "true" \*)\s/normal! f(da)x<C-o>
  elseif &filetype =~ "vhdl"
    silent g/^\s*attribute\smark_debug\s.*$/normal! dd
  endif
  call cursor(l:pos[1:3])
endfunction

"" Vim Diff Stuff
" Allows to see diff in current file before saving with :diffSaved
function! s:DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
  wincmd R
endfunction
com! Diff call s:DiffWithSaved()

" Allows to see diff between current file and svn
function! s:DiffWithSVNCheckedOut()
  let filetype=&ft
  diffthis
  vnew | exe "%!svn cat " . fnameescape( expand("#:p") )
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
  wincmd R
endfunction
com! SvnDiff call s:DiffWithSVNCheckedOut()

function! s:DiffWithGITCheckedOut()
  let filetype=&ft
  diffthis
  vnew | exe "%!git diff " . fnameescape( expand("#:p") ) . " | patch -p 1 -Rs -o -"
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
  diffthis
  wincmd R
endfunction
com! GitDiff call s:DiffWithGITCheckedOut()

" Only for GVIM
" Toggle gvim Menu / Scrollbars See <F12> above for shortcut
function! ToggleGUIOpts()
  if &guioptions=='i'
    exec('set guioptions=imTrL')
  else
    exec('set guioptions=i')
  endif
endfunction

