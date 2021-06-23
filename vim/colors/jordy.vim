" Vim color file
" Maintainer: Jordan Woods {jordan.woods@ngc.com}
" Last Change:s2021 Jan 04
" grey on black
" Optimized for: me :)

hi clear
if exists("syntax_on")
  syntax reset
endif
set background=dark
let g:colors_name = "jordy"

" hardcoded colors :
" GUI Comment : #80a0ff = Light blue

" GUI
hi Normal     guifg=Grey80   guibg=Black
hi Search     guifg=Black    guibg=Red   gui=bold
hi Visual     guifg=#404040              gui=bold
hi Cursor     guifg=Black    guibg=Green gui=bold
hi Special    guifg=Orange
hi Comment    guifg=#80a0ff
hi StatusLine guifg=blue     guibg=white
hi Statement  guifg=Yellow               gui=NONE
hi Type       gui=NONE

" Color Terminal
" Visit https://jonasjacek.github.io/colors/ for details
" regarding color number scheme
"        hi link x y -> X copies the attributes of Y
"        echo synIDattr(synIDtrans(hlID('StatusLine')),'fg')
hi Normal       ctermfg=248 ctermbg=16
hi Search       ctermfg=16  ctermbg=130 cterm=NONE
hi Visual       ctermbg=16              cterm=reverse
hi Cursor       ctermfg=16  ctermbg=10  cterm=NONE
hi StatusLine   ctermfg=249 ctermbg=238 cterm=NONE
hi StatusLineNC ctermfg=235 ctermbg=249 cterm=NONE
hi VertSplit    ctermfg=255 ctermbg=238 cterm=NONE
" hi WildMenu   ctermfg=248 ctermbg=16 cterm=NONE
hi CursorLineNr ctermfg=178             cterm=NONE
hi LineNr       ctermfg=178             cterm=NONE
hi TabLineFill  ctermfg=235 ctermbg=249 cterm=NONE
hi TabLine      ctermfg=235 ctermbg=249 cterm=NONE
hi TabLineSel   ctermfg=249 ctermbg=238 cterm=NONE
hi Title        ctermfg=249 ctermbg=238 cterm=NONE
hi Question     ctermfg=71              cterm=NONE
hi MoreMsg      ctermfg=71              cterm=NONE 
hi Identifier   ctermfg=6               cterm=NONE
hi PreProc      ctermfg=6               cterm=NONE
" hi NonText    ctermfg=250

" *Comment
"
" Comments
" HiLink vhdlComment   Comment
hi Comment    ctermfg=12

" *Constant
"  String
"  Character
"  Number
"  Boolean
"  Float
"
" All VHDL numbers and values Belong to type String
hi Constant   ctermfg=13

" *Identifier
"  Function
"
" *Statement
"  Conditional
"  Repeat
"  Label
"  Operator
"  Keyword
"  Exception
"
" generate, architecture, etc. 11
hi Statement  ctermfg=178 cterm=NONE

" *PreProc
"  Include
"  Define
"  Macro
"  PreCondit
"
" *Type
"  StorageClass
"  Structure
"  Typedef
" std logic, =, <, :, 'range
" HiLink vhdlType      Type
" HiLink vhdlOperator  Type
" HiLink vhdlAttribute Type
"                 121
hi Type       ctermfg=71 cterm=NONE
" *Special
"  SpecialChar
"  Tag
"  Delimiter
"  SpecialComment
"  Debug
"
" VHDL commas, semi-colons, etc.
" HiLink vhdlSpecial   Special
hi Special    ctermfg=166
