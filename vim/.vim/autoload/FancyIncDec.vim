"""""""""""""""""""""""""""""""""""""""""""""""
"" Originator       : Jordan Woods          \""
"" Last Modified By : $Author::           $ \""
"" Last Modified    : $Date::             $ \""
"" SVN Revision     : $Rev::              $ \""
"""""""""""""""""""""""""""""""""""""""""""""""
""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" <Module Name> = <Basic Description>                                        \""
"" This module does the following:                                            \""
"" 1) TODO: Fix Searchpos bug. Do VHDL Incrementing. Replace Underscores.     \""
""                                                                            \""
"" Manual Revision History                                                    \""
"" 05/01/23 - JFW - Initial Release                                           \""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" ROI_START_ADDR_o[1] <=32'b11111111     /* 0x"0000_0000" */;
" ROI_START_ADDR_o[1] <=32'h0123456fe  /* 0x"0001_0000" */;
" ROI_START_ADDR_o[1] <=32'o01234567    /* 0x"0001_0000" */;
" ROI_START_ADDR_o[1] <=32'b1111 4'b0001 /* 0x"0000_0000" */;
" ROI_START_ADDR_o[1] <=32'b0111 4'b0010 /* 0x"0000_0000" */;
" ROI_START_ADDR_o[1] <=32'b0011 4'b0100 /* 0x"0000_0000" */;

function! FancyIncDec(...)
  set nrformats+=octal
  let pos = col(".")
" [10] <= 32'habd_12399 /* 0x"0000_0000" */;
" [10] <= 32'h1234_abdf /* "0002_0000" */;
  " echo "current position: " . string(getpos('.')) . " search: " . expand('<cWORD>') . " loc: " . string(searchpos(expand('<cWORD>'),'c',line(".")))
  " call cursor(line("."),searchpos(expand('<cWORD>'),'cn',0)[1])
  " echo "current position: " . string(getpos('.'))
  let Ver = s:checkHexVerilog()
  let Vhd = s:checkHexVHDL()
  let Nor = s:checkNormal()
  " echo "Ver: " . Ver . " VHDL: " . Vhd . " Nor: " . Nor
  if Ver <= Nor && Ver != 0
    " call cursor(line("."),Ver)
    let unders = s:RemoveUnderscores()
    call s:VerilogIncDec(a:1,Ver)
    call s:ReplaceUnderscores(unders)
    echo "Selected Verilog Increment at " . Ver
  elseif Vhd <= Nor && Vhd != 0
    " call cursor(line("."),Vhd)
    let unders = s:RemoveUnderscores()
    call s:VerilogIncDec(a:1,Ver)
    call s:ReplaceUnderscores(unders)
    echo "Selected VHDL Increment at " . Vhd
  elseif Nor != 0
    call s:IncDec(a:1)
    echo "Selected Normal Increment at " . Vhd
  else
    call cursor(line("."),pos)
    echo "Nothing to increment"
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
  return searchpos('\d','cn',getpos('.')[1])[1]
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
    call s:IncDecBinary(a:1)
  elseif getline('.')[col('.')-1] ==? 'o'
    exe "normal! a~0"
    call s:IncDec(a:1)
    exe "normal! F~2x"
  endif
  " call cursor(line("."),a:2)
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
  " call cursor(line("."),pos)
  return unders
endfunction

function! s:ReplaceUnderscores(...)
endfunction

function! s:IncDecBinary(...)
  let s:string = split(getline('.')[col('.'):])[0]
  let s:len = 8
  exe "normal! l"
  if len(s:string) < 8
    let s:len = len(s:string)
    for i in range(len(s:string)+1,8) | let s:string = "0" . s:string | endfor
  elseif len(s:string) > 8
    for i in range(8+1, len(s:string)) | exe "normal! l" | endfor
    let s:string = s:string[-8:]
  endif
  let s:index  = index(g:BinaryList,s:string)
  if a:1 == 1
    if s:index == 255
      exe "normal! R" . get(g:BinaryList,        0)[-s:len :] . "\<Esc>"
    else
      exe "normal! R" . get(g:BinaryList,s:index+1)[-s:len :] . "\<Esc>"
    endif
  else
    if s:index == 0
      exe "normal! R" . get(g:BinaryList,      255)[-s:len :] . "\<Esc>"
    else
      exe "normal! R" . get(g:BinaryList,s:index-1)[-s:len :] . "\<Esc>"
    endif
  endif
endfunction

" Hardcoded Binary list from 1-255 {{{1
let g:BinaryList = ["00000000", "00000001", "00000010", "00000011", "00000100", "00000101", "00000110", "00000111",
                 \  "00001000", "00001001", "00001010", "00001011", "00001100", "00001101", "00001110", "00001111",
                 \  "00010000", "00010001", "00010010", "00010011", "00010100", "00010101", "00010110", "00010111",
                 \  "00011000", "00011001", "00011010", "00011011", "00011100", "00011101", "00011110", "00011111",
                 \  "00100000", "00100001", "00100010", "00100011", "00100100", "00100101", "00100110", "00100111",
                 \  "00101000", "00101001", "00101010", "00101011", "00101100", "00101101", "00101110", "00101111",
                 \  "00110000", "00110001", "00110010", "00110011", "00110100", "00110101", "00110110", "00110111",
                 \  "00111000", "00111001", "00111010", "00111011", "00111100", "00111101", "00111110", "00111111",
                 \  "01000000", "01000001", "01000010", "01000011", "01000100", "01000101", "01000110", "01000111",
                 \  "01001000", "01001001", "01001010", "01001011", "01001100", "01001101", "01001110", "01001111",
                 \  "01010000", "01010001", "01010010", "01010011", "01010100", "01010101", "01010110", "01010111",
                 \  "01011000", "01011001", "01011010", "01011011", "01011100", "01011101", "01011110", "01011111",
                 \  "01100000", "01100001", "01100010", "01100011", "01100100", "01100101", "01100110", "01100111",
                 \  "01101000", "01101001", "01101010", "01101011", "01101100", "01101101", "01101110", "01101111",
                 \  "01110000", "01110001", "01110010", "01110011", "01110100", "01110101", "01110110", "01110111",
                 \  "01111000", "01111001", "01111010", "01111011", "01111100", "01111101", "01111110", "01111111",
                 \  "10000000", "10000001", "10000010", "10000011", "10000100", "10000101", "10000110", "10000111",
                 \  "10001000", "10001001", "10001010", "10001011", "10001100", "10001101", "10001110", "10001111",
                 \  "10010000", "10010001", "10010010", "10010011", "10010100", "10010101", "10010110", "10010111",
                 \  "10011000", "10011001", "10011010", "10011011", "10011100", "10011101", "10011110", "10011111",
                 \  "10100000", "10100001", "10100010", "10100011", "10100100", "10100101", "10100110", "10100111",
                 \  "10101000", "10101001", "10101010", "10101011", "10101100", "10101101", "10101110", "10101111",
                 \  "10110000", "10110001", "10110010", "10110011", "10110100", "10110101", "10110110", "10110111",
                 \  "10111000", "10111001", "10111010", "10111011", "10111100", "10111101", "10111110", "10111111",
                 \  "11000000", "11000001", "11000010", "11000011", "11000100", "11000101", "11000110", "11000111",
                 \  "11001000", "11001001", "11001010", "11001011", "11001100", "11001101", "11001110", "11001111",
                 \  "11010000", "11010001", "11010010", "11010011", "11010100", "11010101", "11010110", "11010111",
                 \  "11011000", "11011001", "11011010", "11011011", "11011100", "11011101", "11011110", "11011111",
                 \  "11100000", "11100001", "11100010", "11100011", "11100100", "11100101", "11100110", "11100111",
                 \  "11101000", "11101001", "11101010", "11101011", "11101100", "11101101", "11101110", "11101111",
                 \  "11110000", "11110001", "11110010", "11110011", "11110100", "11110101", "11110110", "11110111",
                 \  "11111000", "11111001", "11111010", "11111011", "11111100", "11111101", "11111110", "11111111"]
