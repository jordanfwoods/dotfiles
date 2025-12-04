" local syntax file - set colors on a per-machine basis:
" vim: tw=0 ts=4 sw=4
" Vim color file
" Maintainer:	Jordan Woods <jordan.f.woods@gmail.com>
" Last Change:	2021 April 05

set background=dark
hi clear
if exists("syntax_on")
  syntax reset
endif
let g:colors_name = "jordan_old"
hi Normal		guifg=Grey80	guibg=black
hi NonText		guifg=yellow guibg=#303030
hi comment		guifg=#80a0ff
hi constant		guifg=cyan	gui=bold
hi identifier	guifg=cyan	gui=NONE
hi statement	guifg=lightblue	gui=NONE
hi preproc		guifg=Pink2
hi type			guifg=seagreen	gui=bold
hi special		guifg=yellow
hi ErrorMsg		guifg=Black	guibg=Red
hi WarningMsg	guifg=Black	guibg=Green
hi Error		guibg=Red
hi Todo			guifg=Black	guibg=orange
hi Cursor		guibg=#60a060 guifg=#00ff00
hi Search		guibg=darkgray guifg=black gui=bold
hi IncSearch	gui=NONE guibg=steelblue
hi LineNr		guifg=darkgrey
hi title		guifg=darkgrey
hi ShowMarksHL ctermfg=cyan ctermbg=lightblue cterm=bold
hi ShowMarksHL   guifg=yellow guibg=black       gui=bold
hi StatusLineNC	gui=NONE guifg=lightblue guibg=darkblue
hi StatusLine	gui=bold	guifg=cyan	guibg=blue
hi label		guifg=gold2
hi operator		guifg=orange
hi clear Visual
hi Visual		term=reverse cterm=reverse gui=reverse
hi DiffChange   guibg=darkgreen
hi DiffText		guibg=olivedrab
hi DiffAdd		guibg=slateblue
hi DiffDelete   guibg=coral
hi Folded		guibg=gray30
hi FoldColumn	guibg=gray30 guifg=white
hi cIf0			guifg=gray
hi diffOnly	guifg=red gui=bold

" New JFW Additions
hi ColorColumn  term=reverse ctermbg=1 guibg=Grey16
"
" Color Terminal
" Visit https://jonasjacek.github.io/colors/ for details regarding color number scheme
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
