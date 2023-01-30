" Vim syntax file
" Language:    .todo and .done files
" Maintainer:  Jordan Woods
" Originator:  Josep M. Bach <josep.m.bachNOSPAN@gmail.com>
" Last Change: 11/03/2022

if exists("b:current_syntax")
  finish
endif

syntax case ignore
set foldmethod=marker

" Allow for good looking timekeeping in to-done lists.
syn match   toTCard   "([0-9]\?[0-9]\(:[0-5]\|\.[0-9]\)[0-9])" contains=toTCFrame
syn match   toTCard   "(XX[:\.]XX)" contains=toTCFrame
syn match   toTCFrame "("
syn match   toTCFrame ")"

" Date And TimeStamps
syn match   toDate    "\<\(sun\|mon\|tue\|wed\|thu\|fri\|sat\), \(1[0-9]\|2[0-9]\|3[0-1]\|0\?[1-9]\)\s\w*\s\(\d\d\d\d\|\d\d\)\>"
syn match   toDate    "\<\(1[0-9]\|2[0-9]\|3[0-1]\|0\?[1-9]\)\s\w*\s\(\d\d\d\d\|\d\d\)\>"
syn match   toDate    "\<\(0\?[1-9]\|1[0-2]\)[/]\(1[0-9]\|2[0-9]\|3[0-1]\|0\?[1-9]\)\(/\d\d\d\d\>\|/\d\d\>\)\?"
syn match   toTime24  "\<\(0\?[0-9]\|1[0-9]\|2[0-3]\):\([0-5][0-9]\)\>"
syn match   toTime12  "\<\(0\?[0-9]\|1[0-2]\):\([0-5][0-9]\)\s*\([ap]m\>\)*"
syn match   toTime12  "\<\(0\?[0-9]\|1[0-2]\)\s*\([ap]m\)"
syn match   toTime12  "\<XX[:\.]XX\>"

" Vital Keywords...
syn keyword toVital   vital important today tomorrow urgent nextgroup=toImp
syn match   toImp     /:\s\+/ contained
syn keyword toKeyWord contained TODO FIXME

" Cluster the things to display within comments
syn cluster toContain contains=toTCard,toDate,toTime12,toTime24,toVital,toKeyword,@Spell

" Block Comment with {"..."}. Regular comment with " ...
syn region  toComment start="{\"" end="\"}" contains=@toContain
syn match   toComment "\".*"                contains=@toContain

" Make Normal Quotes Great Again...
syn region  toQuote   oneline keepend start=/"/ end=/"/

" Effectively these are Title Groupings...
syn match   toProjTag /^\s*=\+\s/ nextgroup=toProj skipwhite
syn match   toProjEnd /\s\+=\+/
syn match   toProj    /.\+/ contained contains=@toContain,toComment,toProjEnd
syn match   toProj    /^WEEK\s\+.*/ contains=@toContain,toComment

" Other Highlights to hide when commented out...

" To-Do list is centered around the check box...
syn match   toOkValue /√/ contained
" Uncompleted: [ ], Completed box = [√], In Progress = [I], Ignore = [X]
syn region  toOk      start=/\[/ end=/\]/ contains=toOkValue nextgroup=toDone
syn match   toEmpty   /\[\s\]/
syn match   toIgnore  /\[X\]/ nextgroup=toDone
syn match   toInProg  /\[I\]/ nextgroup=toCurrent
" Comment out entry that is completed.
syn match   toDone    /.\+/ contained contains=@toContain
" Highlight out entry that is in progress.
syn match   toCurrent /.\+/ contained contains=@toContain
" Use similar highlighting when using: # ...
syn match   toCurrent /^\s*#.*/           contains=@toContain
syn region  toCurrent start="{#" end="#}" contains=@toContain

" Make a Main To-Do List Title
syn match   toTitle   /^\s*to\s\?do.\+/ contains=toContain
" Use < > to highlight an important note, i.e. customer, etc.
syn match   toParens  /<.\+>/

" Make it beautiful. Note that I used 'gruvbox' for determining the colors.
hi link     toOkValue Special
hi link     toOk      Special
hi link     toTime12  Special
hi link     toTime24  Special
hi link     toTCard   Special
hi link     toDate    Number
hi link     toEmpty   Statement
hi link     toVital   Statement
hi link     toImp     Statement
hi link     toTitle   Identifier
hi link     toProj    Identifier
hi link     toComment Comment
hi link     toDone    Comment
hi link     toIgnore  Comment
hi link     toParens  Type
hi link     toInProg  String
hi link     toCurrent String

" name the syntax
let b:current_syntax = "todo_done"
"_black vim: ts=8 sw=2
