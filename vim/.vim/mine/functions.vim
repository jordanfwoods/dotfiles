"" guifont updates
function! FontChange(...)
  let g:fontsize = g:fontsize + a:1
  if g:fontsize < 1
    let g:fontsize = 1
  endif
  execute "set guifont=Consolas_NF:h" . g:fontsize . ":cANSI:qDRAFT"
endfunction

"" To-do Function " manage check boxes
let g:chr = -1
function! TodoFunc()
  let pos = col(".")
  if line(".") == a:firstline
     echo "Options: 1:√ i:I u:↑ x:X c:_ n:[ ] d:D"
     let g:chr = getchar()
  endif
  call TodoFuncInt(tolower(nr2char(g:chr)))
endfunction

"" To-do Function " manage check boxes
function! TodoFuncInt(...)
  let pos = col(".")
  execute "normal! ^"
  if getline(".")[col(".")-1] != "[" | execute "normal! f[" | endif
  if getline(".")[col(".")-1] == "["
    if     a:1 ==# "1" | execute "normal! lr√f]"
    elseif a:1 ==# "i" | execute "normal! lrIf]"
    elseif a:1 ==# "u" | execute "normal! lr↑f]"
    elseif a:1 ==# "x" | execute "normal! lrXf]"
    elseif a:1 ==# "c" | execute "normal! lr f]"
    elseif a:1 ==# "d" | execute "normal! da]dw" | let pos = pos-4
    endif
  endif
  if a:1 ==# "n" | execute "normal! ^i[ ] " | let pos = pos+4 | endif
  if a:lastline == a:firstline | call cursor(line("."),pos) | endif
  if a:lastline != a:firstline
    +1
  endif
endfunction

" Re-numbers alpha-numeric lists '1. ...\n 2. \n ...'
function! ReNumberList()
  let l:orig = line(".")
  let l:loop = l:orig - 1
  let l:col  = match(getline(l:orig),"\\w\\+\\. ")
  let l:off  = 0
  set nrformats+=alpha
  while l:loop > 1
     let l:off = 0
     if (stridx(getline(l:loop),'√') != -1 && stridx(getline(l:orig),'√') == -1)
        let l:off = 2
     endif
     if (stridx(getline(l:loop),'√') == -1 && stridx(getline(l:orig),'√') != -1)
        let l:off = -2
     endif
     if (l:col == -1)
        if (match(getline(l:loop),"\\w\\+\\. ") != -1)
           silent! exe "silent! normal ^iQ. \<ESC>" . l:loop . "G^t.yiw"
           break
        endif
     elseif (match(getline(l:loop),"\\w\\+\\. ") == l:col+l:off) ||
          \ (match(getline(l:loop),"\\w\\+\\. ") == l:col+l:off+1)
        if (foldclosed(l:loop) < 0)
           silent! exe "silent! normal " . l:loop . "G^t.yiw"
        else
           silent! exe "silent! normal " . l:loop . "Gza^t.yiwza"
        endif
        break
     endif
     let l:loop -= 1
  endwhile
  if (@0 != 'X')
     silent! exe "silent! normal ".l:orig."G^t.ciw\<C-R>0\<ESC>\<C-A>"
  else
     silent! exe "silent! normal ".l:orig."G^t.ciw1\<ESC>"
  endif
  +1
  set nrformats-=alpha
endfunction

" Make the Todo list auto fold
function! TodoFold(lnum)
   let l:line = getline(a:lnum)
   let l:indent = &shiftwidth
   let l:indent = indent(a:lnum) / l:indent
   if     l:line[0:11] ==# "======= Year" | return 1
   elseif l:line[0:3]  ==# "====" | return 4
   elseif l:line[0:2]  ==# "==="  | return 3
   elseif l:line[0:1]  ==# "=="   | return 2
   elseif l:line[0]    ==# "="    | return 1
   elseif l:line[indent(a:lnum)] ==# "["
     let l:loop = a:lnum-1
     while l:loop > 1
        if (getline(l:loop)[0] ==# "=")
           return TodoFold(l:loop)+l:indent
        endif
        let l:loop -= 1
     endwhile
   elseif getline(a:lnum+1)[0:11] ==# "======= Year" | return 0
   elseif getline(a:lnum+1)[0:3]  ==# "====" | return 3
   elseif getline(a:lnum+1)[0:2]  ==# "==="  | return 2
   elseif getline(a:lnum+1)[0:1]  ==# "=="   | return 1
   elseif getline(a:lnum+1)[0]    ==# "="    | return 0 | endif
   return "="
endfunction

" Incrementally add 'MARK_DEBUG' to verilog / vhdl files
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

" Globally remove 'MARK_DEBUG' from verilog / vhdl files
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

" Allows to see diff between current file and git
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

" Make a Scratch Buffer
function! ScratchBuffer()
  vnew | exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=todo_done"
   if !has('win32')
     let l:scratch = 0
     let l:filename = '[ Scratch ]'
     let l:try = 1
     while l:try == 1
        let l:try = 0
        for i in filter(range(1, bufnr('$')), 'bufexists(v:val)')
           if bufname(i) ==# l:filename
              let l:scratch +=1
              let l:filename = '[ Scratch '.l:scratch.' ]'
              let l:try = 1
           endif
        endfor
     endwhile
     exe "file ".l:filename
  endif
endfunction

" Insert VHDL Examples / Templates
function! VHDLExamples()
   if has('win32') | let l:dir = "~\\vimfiles\\templates\\vhdl\\"
   else            | let l:dir = "~/.vim/templates/vhdl/" | endif
   echo "Options: aAbBcCefFhHipPw"
   let chr = getchar()
   let help = "This Function dumps VHDL templates to the current file\nh = print this help\n" .
         \ "a  = Architecture\n"   . "A  = asynchronous Assignments\n" . " = Attributes\n" .
         \ "b  = Package Body\n"   . "B  = Block\n" .
         \ "c  = case statement\n" . "C  = Component\n" . "e  = Entity\n" .
         \ "f  = for loop\n"       . "F  = function\n" .
         \ "H  = Header\n"         . "i  = if-elsif-else\n" .
         \ "p  = Process\n"        . "P  = Package\n" .
         \ " = procedure\n"      . "w  = while loop"
   if     nr2char(chr) ==# 'a'  | let l:dir .="architecture.vhd"
   elseif nr2char(chr) ==# 'A'  | let l:dir .="assign.vhd"
   elseif nr2char(chr) ==# '' | let l:dir .="attributes.vhd"
   elseif nr2char(chr) ==# 'b'  | let l:dir .="package_body.vhd"
   elseif nr2char(chr) ==# 'B'  | let l:dir .="block.vhd"
   elseif nr2char(chr) ==# 'c'  | let l:dir .="case.vhd"
   elseif nr2char(chr) ==# 'C'  | let l:dir .="component.vhd"
   elseif nr2char(chr) ==# 'e'  | let l:dir .="entity.vhd"
   elseif nr2char(chr) ==# 'f'  | let l:dir .="for.vhd"
   elseif nr2char(chr) ==# 'F'  | let l:dir .="function.vhd"
   elseif nr2char(chr) ==# 'h'  | echo help
   elseif nr2char(chr) ==# 'H'  | let l:dir .="header.vhd"
   elseif nr2char(chr) ==# 'i'  | let l:dir .="if.vhd"
   elseif nr2char(chr) ==# 'p'  | let l:dir .="process.vhd"
   elseif nr2char(chr) ==# 'P'  | let l:dir .="package.vhd"
   elseif nr2char(chr) ==# '' | let l:dir .="procedure.vhd"
   elseif nr2char(chr) ==# 'w'  | let l:dir .="while.vhd"
   endif
   sil! exe "-1r " . l:dir
endfunction
