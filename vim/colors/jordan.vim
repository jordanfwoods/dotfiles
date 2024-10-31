" Vim color file
" Maintainer:  Hans Fugal <hans@fugal.net>
" Last Change: $Date: 2004/06/13 19:30:30 $
" Last Change: $Date: 2004/06/13 19:30:30 $
" URL:      http://hans.fugal.net/vim/colors/desert.vim
" Version:  $Id: desert.vim,v 1.1 2004/06/13 19:30:30 vimboss Exp $

" cool help screens
" :he group-name
" :he highlight-groups
" :he cterm-colors
" echo synIDattr(synIDtrans(hlID('StatusLine')),'fg')

set background=dark
if version > 580
    " no guarantees for version 5.8 and below, but this makes it stop
    " complaining
    hi clear
    if exists("syntax_on")
   syntax reset
    endif
endif
let g:colors_name="jordan"

if &t_Co == 256
" Eventually re-write for non-256 colors, too.
endif

"jfw
hi Normal                  guifg=Grey80      guibg=black
"jfwhi Normal              guifg=White       guibg=grey20
" highlight groups
hi Cursor                  guifg=grey80   guibg=cyan4

"hi CursorIM
"hi Directory
"hi DiffAdd
"hi DiffChange
"hi DiffDelete
"hi DiffText
"hi ErrorMsg
hi VertSplit      gui=none guifg=grey50      guibg=#c2bfa5
hi Folded                  guifg=gold        guibg=grey30
hi FoldColumn              guifg=tan         guibg=grey30
hi IncSearch               guifg=slategrey   guibg=khaki
"hi LineNr
hi ModeMsg                 guifg=goldenrod
hi MoreMsg                 guifg=SeaGreen
hi Question                guifg=springgreen
hi Search                  guifg=slategrey   guibg=khaki
" I Like RoyalBlue1
hi SpecialKey              guifg=yellowgreen
hi StatusLine     gui=none guifg=black       guibg=#c2bfa5
hi StatusLineNC   gui=none guifg=grey50      guibg=#c2bfa5
hi Title                   guifg=indianred
"jfw
hi Visual         gui=reverse term=reverse  guibg=Black
"jfw hi Visual    gui=none guifg=khaki guibg=olivedrab
"jfw
hi MatchParen     term=reverse guibg=goldenrod
" hi MatchParen     term=reverse guibg=goldenrod242
"hi VisualNOS
hi WarningMsg              guifg=salmon
"hi WildMenu
"hi Menu
"hi Scrollbar
"hi Tooltip

" syntax highlighting groups
hi Comment                 guifg=SkyBlue
hi Constant                guifg=#ffa0a0
hi Identifier              guifg=PaleGreen3
hi Statement               guifg=khaki
hi PreProc                 guifg=indianred
hi Type                    guifg=OliveDrab4
hi Special                 guifg=navajowhite
"hi Underlined
hi Ignore                  guifg=grey40
"hi Error
hi Todo                    guifg=orangered guibg=black
" jfw guibg=yellow2
" jfw
hi Directory               guifg=SkyBlue2

" jfw added update to Popup Menu
hi Pmenu                   guifg=#ebdbb2     guibg=#504945
  " Popup menu: selected item
hi PmenuSel       gui=bold guifg=#504945     guibg=#83a598
  " Popup menu: scrollbar
hi PmenuSbar               guifg=NONE        guibg=#504945
  " Popup menu: scrollbar thumb
hi PmenuThumb              guifg=NONE        guibg=#7c6f64

" When I press <F11>, EOL's are NonText, spaces are special key
hi NonText        gui=bold guifg=LightBlue guibg=Grey30
hi SpecialKey              guifg=yellowgreen

""""""""""""""""""""""""""""""""
"" CTERM Equivalent
""""""""""""""""""""""""""""""""

" " syntax highlighting groups
" " SkyBlue      = 117?
" " #ffa0a0
" " PaleGreen3   = 77 / 114?
" " khaki        = 185?
" " indianred    =131
" " OliveDrab4   =3?
" " navajowhite
" " grey40       =242
" " orangered    =202
" " black        =0
" " SkyBlue2     =111
" " #ebdbb2
" " #504945
" " #83a598
" " #7c6f64
"  hi Normal                  ctermfg=252       ctermbg=16
"  "jfwhi Normal              ctermfg=White       ctermbg=grey20
"  " highlight groups
""  hi Cursor                  ctermfg=grey80   ctermbg=cyan4
"  
"  "hi CursorIM
"  "hi Directory
"  "hi DiffAdd
"  "hi DiffChange
"  "hi DiffDelete
"  "hi DiffText
"  "hi ErrorMsg
"  hi VertSplit      term=none ctermfg=244      ctermbg=145
"  hi Folded                  ctermfg=220        ctermbg=239

" hi StatusLineTermNC  term=reverse ctermfg=0 ctermbg=10 guifg=bg guibg=LightGreen
" hi TabLine           term=underline cterm=underline ctermfg=15 ctermbg=8
" hi TabLine           gui=underline guibg=DarkGrey guifg=NONE
" hi TabLineFill       term=reverse cterm=reverse gui=reverse guifg=NONE
" hi TabLineFill       guibg=NONE ctermfg=NONE ctermbg=NONE
" hi TabLineSel        term=bold cterm=bold gui=bold guifg=NONE guibg=NONE
" hi TabLineSel        ctermfg=NONE ctermbg=NONE
" hi Todo              term=standout ctermfg=0 ctermbg=14
" hi ToolbarButton     cterm=bold ctermfg=0 ctermbg=7 gui=bold guifg=Black
" hi ToolbarButton     guibg=LightGrey
" hi ToolbarLine       term=underline ctermbg=8 guibg=Grey50 guifg=NONE
" hi ToolbarLine       ctermfg=NONE
" hi Underlined        term=underline gui=underline guifg=#80a0ff
" hi VertSplit         term=reverse ctermbg=NONE ctermfg=NONE
" "hi Visual            ctermbg=NONE ctermfg=NONE
" "hi VisualNOS         term=bold,underline gui=bold,underline ctermbg=NONE
" "hi VisualNOS         guifg=NONE ctermfg=NONE
" hi WildMenu          term=standout guifg=Black guibg=Yellow

highlight link QuickFixLine Search
highlight link EndOfBuffer  NonText

"vim: sw=4
