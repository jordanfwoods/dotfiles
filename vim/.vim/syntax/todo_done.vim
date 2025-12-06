" Vim syntax file
" Language:    .todo and .done files
" Maintainer:  Jordan Woods
" Originator:  Josep M. Bach <josep.m.bachNOSPAN@gmail.com>
" Last Change: 02/01/2023

if exists("b:current_syntax")
  finish
endif

syn case ignore " I am fine with everything being case insensitive
" set foldmethod=marker " fold with { { { #
" set foldlevelstart=3 " Nice place to start the folds
" set foldmethod=expr
" set foldexpr=TodoFold(v:lnum)
syn sync fromstart

" Date Coloring
syn match   toDate         "\<\(sun\|mon\|tue\|wed\|thu\|fri\|sat\), \(1[0-9]\|2[0-9]\|3[0-1]\|0\?[1-9]\)\s\w*\s\(\d\d\d\d\|\d\d\)\>"
syn keyword toDate         sunday monday tuesday wednesday thursday friday saturday
" syn match   toDate         "\<\(1[0-9]\|2[0-9]\|3[0-1]\|0\?[1-9]\)\s\w*\s\(\d\d\d\d\|\d\d\)\>"
syn match   toDate         "\<\(0\?[1-9]\|1[0-2]\)[/]\(1[0-9]\|2[0-9]\|3[0-1]\|0\?[1-9]\)\(/\d\d\d\d\>\|/\d\d\>\)\?"
syn match   toDate         "\<ww\(20\)\?[2-9][3-9][0-5][0-9]\.[1-5]"
" syn match   toDate         "\<\(January\|February\|March\|April\|May\|June\)\s\+\(\d\d\d\d\|\d\d\)\>"
" syn match   toDate         "\<\(July\|August\|September\|October\|November\|December\)\s\+\(\d\d\d\d\|\d\d\)\>"
" syn match   toDate         "\<\(Jan\|Feb\|Mar\|Apr\|May\|June\)\s\+\(\d\d\d\d\|\d\d\)\>"
syn keyword toMonth        January February March April May June July August September October November December nextgroup=toMonthYear
syn keyword toMonth        Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec nextgroup=toMonthYear
syn match   toMonthYear    /\s\+\(\d\d\d\d\|\d\d\)/ contained

" Time Coloring
syn match   toTime24       "[~<>]\?\<\(0\?[0-9]\|1[0-9]\|2[0-3]\):\([0-5][0-9]\)\>"
syn match   toTime12       "[~<>]\?\<\(0\?[0-9]\|1[0-2]\):\([0-5][0-9]\)\s*\([ap]m\>\)"
syn match   toTime12       "[~<>]\?\<\(0\?[0-9]\|1[0-2]\)\([0-5][0-9]\)\s*\([ap]m\>\)"
syn match   toTime12       "[~<>]\?\<\(0\?[0-9]\|1[0-2]\)\s*\([ap]m\)"
syn match   toTimeHr       "[~<>]\?\<[0-9]*\(.[0-9]*\)\?+\?\s*hr\>"
syn match   toTimeMin      "[~<>]\?\<[0-9]*\(.[0-9]*\)\?+\?\s*min\>"
" Allow for good looking timekeeping in to-done lists.
syn match   toTimeCard     "(\(XX\|[0-9]\?[0-9]\)\(:[0-5][0-9]\|\.[0-9][0-9]\|:XX\|.XX\))" contains=toTimeCFrame
syn match   toTimeCFrame   "\(XX\|[0-9]\?[0-9]\)\(:[0-5][0-9]\|\.[0-9][0-9]\|:XX\|.XX\)" contained

" Vital Keywords...
syn keyword toVital        important today tomorrow urgent cancelled missed  nextgroup=toImp
syn keyword toVital        help current currently vital wait cancel miss OOO nextgroup=toImp
syn keyword toVital        hold tbd support unblock nextgroup=toOn,toImp
syn match   toOn           /\s\+on/ contained  nextgroup=toImp
syn match   toImp          /:/ contained
syn keyword toKeyWord      contained TODO FIXME

" Cluster the things to still display within comments, etc.
syn cluster toContain      contains=toFold,toTimeCard,toMonth,toDate,toTime12,toTime24,toTimeHr,toTimeMin,toVital,toKeyword,@Spell,toParens
syn cluster toBlocks       contains=toCommentBlock,toCurrentBlock,toComment

" Block Comment with {#...#}. Regular comment with # ...
syn region  toCommentBlock start="{#" end="#}" contains=@toContain
syn match   toComment      "#.*"               contains=@toContain,@toBlocks
syn match   toFold         "{{{\d\+"           nextgroup=toDone
syn match   toFold         "\d\+}}}"           nextgroup=toDone

" Colorize the title / section titles...
syn region  toBox          start="│" end="│" oneline contains=toInBox,toTEMP
syn region  toBox          start="┌" end="┐" oneline contains=toInBox,toTEMP
syn region  toBox          start="└" end="┘" oneline contains=toInBox,toTEMP
syn match   toInBox        /to\s\?do.\+\s/  contained contains=@toContain,toComment,toProjEnd
syn match   toInBox        /week\(ly\)\?\s\+.*\s/ contained contains=@toContain,toComment
syn match   toInBox        /daily\s\+.*\s/ contained contains=@toContain,toComment
syn match   toInBox        /note\(s\)\?\(:\)\?\s\+.*\s/ contained contains=@toContain,toComment
syn match   toProjTag      /^\s*=\+\s/ nextgroup=toProj skipwhite
syn match   toProjEnd      /\s\+=\+\(\s*{{{\d\+\)\?\s*$/ contains=toFold
syn match   toProj         /.\+/ contained contains=@toContain,toComment,toProjEnd
syn match   toProj         /^week\(ly\)\?\s\+.*/ contains=@toContain,toComment
syn match   toProj         /^daily\s\+.*/ contains=@toContain,toComment
syn match   toProj         /^to\s\?do.\+/ contains=toContain,toComment
syn match   toProj         /^\d\d\d\d\s\+.*/ contains=@toContain,toComment

if &encoding == 'utf-8'
  " Uncompleted = [ ], Completed = [√], In Progress = [I], Ignore = [X]
  " Colorize the checkbox: [√]...
  syn match   toOkValue      /√/ contained
  syn match   toOk           /\[√\]/ contains=toOkValue nextgroup=toDone
  syn match   toAbove        /\[↑\]/ nextgroup=toAfterAbove
  syn match   toIgnore       /\[X\]/ nextgroup=toDone
else
  " Colorize the checkbox: [x]...
  syn match   toOkValue      /x/ contained
  syn match   toOk           /\[x\]/ contains=toOkValue nextgroup=toDone
  syn match   toAbove        /\[T\]/ nextgroup=toAfterAbove
  syn match   toIgnore       /\[Y\]/ nextgroup=toDone
endif

syn match   toEmpty        /\[\s\]/
syn match   toInProg       /\[I\]/ nextgroup=toCurrent

" Comment out entry that is completed.
syn match   toDone         /.\+/ contained contains=@toBlocks,toResponse,@toContain
" syn match   toResp         / : / contained contains=@toBlocks,@toContain conceal
" syn region  toResponse     start="{" end="}" oneline contains=toResp
syn region  toResponse     start="{" end="}" oneline
" Re-highlight entry that is in progress.
syn match   toCurrent      /.\+/ contained contains=@toBlocks,@toContain
syn match   toAfterAbove   /.\+/ contained contains=@toBlocks,@toContain
" Use similar highlighting on other lines when using: {"..."} or lines that start with: " ...
syn region  toCurrentBlock start="{\"" end="\"}" contains=@toContain
syn match   toCurrent      /^\s*\".*/            contains=@toContain,@toBlocks

" Use < > to highlight an important note, i.e. customer, etc. (Gets greyed out with comment)
syn region  toParens       start="<" end=">" oneline
syn region  toQuotes       start=/"/ end=/"/ oneline
syn region  toQuotes       start=/'/ end=/'/ oneline

" Make it beautiful. Note that I used 'gruvbox' for determining the colors.
hi link     toTimeCard     Normal
hi link     toKeyword      Normal
hi link     toBox          toKeyword
hi link     toOkValue      Special
hi link     toOk           Special
hi link     toResponse     toOk
hi link     toTime12       Special
hi link     toTime24       toTime12
hi link     toTimeCFrame   toTime12
hi link     toTimeHr       toTime12
hi link     toTimeMin      toTime12
hi link     toDate         Number
hi link     toMonth        toDate
hi link     toMonthYear    toDate
hi link     toEmpty        Statement
hi link     toVital        Statement
hi link     toOn           toVital
hi link     toImp          toVital
hi link     toProj         Identifier
hi link     toInBox        toProj
hi link     toAbove        Identifier
hi link     toAfterAbove   toAbove
hi link     toComment      Comment
hi link     toCommentBlock toComment
hi link     toDone         toComment
hi link     toIgnore       toComment
hi link     toFold         toComment
hi link     toParens       Type
hi link     toQuotes       String
hi link     toInPar        toParens
hi link     toInProg       PreProc
hi link     toCurrent      toInProg
hi link     toCurrentBlock toInProg

" name the syntax
let b:current_syntax = "todo_done"
"_black vim: ts=8 sw=2
