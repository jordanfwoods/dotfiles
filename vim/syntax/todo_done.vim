" Vim syntax file
" Language:    .todo and .done files
" Maintainer:  Jordan Woods
" Originator:  Josep M. Bach <josep.m.bachNOSPAN@gmail.com>
" Last Change: 02/01/2023

if exists("b:current_syntax")
  finish
endif

syntax case ignore
set foldmethod=marker

" Date And TimeStamps
syn match   toDate    "\<\(sun\|mon\|tue\|wed\|thu\|fri\|sat\), \(1[0-9]\|2[0-9]\|3[0-1]\|0\?[1-9]\)\s\w*\s\(\d\d\d\d\|\d\d\)\>"
syn match   toDate    "\<\(1[0-9]\|2[0-9]\|3[0-1]\|0\?[1-9]\)\s\w*\s\(\d\d\d\d\|\d\d\)\>"
syn match   toDate    "\<\(0\?[1-9]\|1[0-2]\)[/]\(1[0-9]\|2[0-9]\|3[0-1]\|0\?[1-9]\)\(/\d\d\d\d\>\|/\d\d\>\)\?"
syn match   toTime24  "\<\(0\?[0-9]\|1[0-9]\|2[0-3]\):\([0-5][0-9]\)\>"
syn match   toTime12  "\<\(0\?[0-9]\|1[0-2]\):\([0-5][0-9]\)\s*\([ap]m\>\)*"
syn match   toTime12  "\<\(0\?[0-9]\|1[0-2]\)\s*\([ap]m\)"
syn match   toTime12  "\<XX[:\.]XX\>"

" Allow for good looking timekeeping in to-done lists.
syn match   toTCard   "([0-9]\?[0-9]\(:[0-5]\|\.[0-9]\)[0-9])" contains=toTCFrame
syn match   toTCard   "(XX[:\.]XX)" contains=toTCFrame
syn match   toTCFrame "("
syn match   toTCFrame ")"

" Vital Keywords...
syn keyword toVital   vital important today tomorrow urgent nextgroup=toImp
syn match   toImp     /:\s\+/ contained
syn keyword toKeyWord contained TODO FIXME

" Cluster the things to still display within comments, etc.
syn cluster toContain contains=toTCard,toTCFrame,toDate,toTime12,toTime24,toVital,toKeyword,@Spell

" Block Comment with {#...#}. Regular comment with # ...
syn region  toComBlck start="{#" end="#}" contains=@toContain
syn match   toComment "#.*"               contains=@toContain

" Colorize the title / section titles...
syn match   toProjTag /^\s*=\+\s/ nextgroup=toProj skipwhite
syn match   toProjEnd /\s\+=\+$/
syn match   toProj    /.\+/ contained contains=@toContain,toComment,toProjEnd
syn match   toProj    /^WEEK\s\+.*/ contains=@toContain,toComment
syn match   toProj    /^\s*to\s\?do.\+/ contains=toContain

" Uncompleted = [ ], Completed = [√], In Progress = [I], Ignore = [X]
" Colorize the checkbox: [√]...
syn match   toOkValue /√/ contained
syn region  toOk      start=/\[/ end=/\]/ oneline contains=toOkValue nextgroup=toDone
syn match   toEmpty   /\[\s\]/
syn match   toInProg  /\[I\]/ nextgroup=toCurrent
syn match   toIgnore  /\[X\]/ nextgroup=toDone

" Comment out entry that is completed.
syn match   toDone    /.\+/ contained contains=toComBlck,@toContain
" Re-highlight entry that is in progress.
syn match   toCurrent /.\+/ contained contains=toCurBlck,@toContain
" Use similar highlighting on other lines when using: {"..."} or " ...
syn region  toCurBlck start="{\"" end="\"}" contains=@toContain
syn match   toCurrent /^\s*\".*/            contains=@toContain

" Use < > to highlight an important note, i.e. customer, etc. (Gets greyed out with comment)
syn match   toParens  /<.\+>/

" Make it beautiful. Note that I used 'gruvbox' for determining the colors.
hi link     toOkValue Special
hi link     toOk      Special
hi link     toTime12  Special
hi link     toTime24  toTime12
hi link     toTCard   toTime12
hi link     toDate    Number
hi link     toEmpty   Statement
hi link     toVital   Statement
hi link     toImp     toVital
hi link     toProj    Identifier
hi link     toComment Comment
hi link     toComBlck toComment
hi link     toDone    toComment
hi link     toIgnore  toComment
hi link     toParens  Type
hi link     toInProg  String
hi link     toCurrent String
hi link     toCurBlck toCurrent

" name the syntax
let b:current_syntax = "todo_done"
"_black vim: ts=8 sw=2
