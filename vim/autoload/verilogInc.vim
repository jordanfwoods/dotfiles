""""""""""""""""""""""""""""""""""""""""""""""
"" Originator       : Jordan Woods          \""
"" Last Modified By : $Author::           $ \""
"" Last Modified    : $Date::             $ \""
"" SVN Revision     : $Rev::              $ \""
""""""""""""""""""""""""""""""""""""""""""""""
""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" <Module Name> = <Basic Description>                                        \""
"" This module does the following:                                            \""
"" 1) TBD                                                                     \""
""                                                                            \""
"" Manual Revision History                                                    \""
"" <>/<>/<> - JFW - Initial Release                                           \""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! FancyIncDec(...)
  set nrformats+=octal
  let pos = col(".")
  call cursor(searchpos(expand('<cWORD>'),'cn',0))
  let Ver = s:checkHexVerilog()
  let Vhd = s:checkHexVHDL()
  let Nor = s:checkNormal()
  if Ver <= Nor && Ver != 0
    call cursor(line("."),Ver)
    echo "Selected Verilog Increment at " . Ver
    let unders = s:RemoveUnderscores()
    call s:VerilogIncDec(a:1,Ver)
    call s:ReplaceUnderscores(unders)
  elseif Vhd <= Nor && Vhd != 0
    call cursor(line("."),Vhd)
    echo "Selected VHDL Increment at " . Vhd
    let unders = s:RemoveUnderscores()
    call s:VerilogIncDec(a:1,Ver)
    call s:ReplaceUnderscores(unders)
  elseif Nor != 0
    echo "Selected Normal Increment at " . a:1
    call s:IncDec(a:1)
  else
    echo "Nothing to increment"
    call cursor(line("."),pos)
  endif
  set nrformats-=octal
endfunction

function! s:checkHexVerilog()
  return searchpos('\<\d\+''[dhbo][0-9a-fA-F_]\+\>','cn',getpos('.')[1])[1]
endfunction

function! s:checkHexVHDL()
  return searchpos('\<0x"[0-9a-fA-F_]\+\>','cn',getpos('.')[1])[1]
endfunction

function! s:checkNormal()
  return searchpos('\d\+','cn',getpos('.')[1])[1]
endfunction

function! s:IncDec(...)
  if a:1 == 1 | exe "normal \<c-a>" | else | exe "normal \<c-x>" | endif
endfunction

function! s:VerilogIncDec(...)
  exe "normal! f'l"
  if     getline('.')[col('.')-1] ==? 'h'
    exe "normal! a0x"
    call s:IncDec(a:1)
    exe "normal! Fxh2x"
  elseif getline('.')[col('.')-1] ==? 'd'
    call s:IncDec(a:1)
  elseif getline('.')[col('.')-1] ==? 'b'
    echo "can't do binary yet... no nrformat option"
  elseif getline('.')[col('.')-1] ==? 'o'
    exe "normal! a~0"
    call s:IncDec(a:1)
    exe "normal! F~2x"
  endif
  call cursor(line("."),a:2)
endfunction

function! s:VHDLIncDec(...)
endfunction

function! s:RemoveUnderscores(...)
  let  string = split(getline('.')[col('.')-1:])[0]
  let unders = []
  let base = 0
  let pos = col(".")
  for i in range(0,split(getline('.')[col('.')-1:])[0])
    if string[i] == "_"
      let base = i-base
      call cursor(line("."),pos+i-len(unders))
      exe "normal! x"
      let unders += [i]
    endif
  endfor
  call cursor(line("."),pos)
  return unders
endfunction

" ROI_START_ADDR_o[1] <=32'h01_23456_FF /* 0x"0000_0000" */;
" ROI_START_ADDR_o[1] <=32'o0123_4570   /* 0x"0000_0000" */;
function! s:ReplaceUnderscores(...)
endfunction

