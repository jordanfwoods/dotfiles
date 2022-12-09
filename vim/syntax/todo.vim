" Vim syntax file
" Language:    .todo files
" Maintainer:  Jordan Woods
" Originator:  Josep M. Bach <josep.m.bachNOSPAN@gmail.com>
" Last Change: 11/03/2022

if exists("b:current_syntax")
  finish
endif

syntax case ignore
set foldmethod=marker
syn match   todoDate    "\(sun\|mon\|tue\|wed\|thu\|fri\|sat\), \(1[0-9]\|2[0-9]\|3[0-1]\|0\?[1-9]\)\s\w*\s\(\d\d\d\d\|\d\d\)"
syn match   todoDate    "\(1[0-9]\|2[0-9]\|3[0-1]\|0\?[1-9]\)\s\w*\s\(\d\d\d\d\|\d\d\)"
syn match   todoDate    "\(0\?[1-9]\|1[0-2]\)[-/]\(1[0-9]\|2[0-9]\|3[0-1]\|0\?[1-9]\)[-/]\?\(\d\d\d\d\|\d\d\)\?"
syn match   todoVital   "vital"     nextgroup=todoImp
syn match   todoVital   "important" nextgroup=todoImp
syn match   todoVital   "today"     nextgroup=todoImp
syn match   todoVital   "tomorrow"  nextgroup=todoImp
syn match   todoVital   "urgent"    nextgroup=todoImp
syn match   todoImp     /:\s\+/ contained
syn match   todoTime24  "\<\(0\?[0-9]\|1[0-9]\|2[0-3]\):\([0-5][0-9]\)"
syn match   todoTime12  "\<\(0\?[0-9]\|1[0-2]\):\([0-5][0-9]\)\s*\([ap]m\)*"
syn match   todoTime12  "\<\(0\?[0-9]\|1[0-2]\)\s*\([ap]m\)"
syn keyword todoKeyWord contained TODO FIXME
syn region  todoComment start="\"\*" end="\*\"" contains=todoVital,todoDate,todoTime12,todoTime24,todoKeyword,@Spell
syn match   todoComment       "\".*"            contains=todoVital,todoDate,todoTime12,todoTime24,todoKeyword,@Spell
syn match   todoDone    /.\+/ contained         contains=todoVital,todoDate,todoTime12,todoTime24,todoKeyword,@Spell,todoParens
syn match   todoCurrent /.\+/ contained         contains=todoVital,todoDate,todoTime12,todoTime24,todoKeyword,@Spell,todoParens
syn match   todoCurrent /^\s*#.*/               contains=todoVital,todoDate,todoTime12,todoTime24,todoKeyword,@Spell

syn match   todoProjTag /=\+\s/ nextgroup=todoProj skipwhite
syn match   todoProj    /.\+/ contained contains=todoComment

syn match   todoOkValue /√/ contained

syn region  todoOk      start=/\[/ end=/\]/ contains=todoOkValue nextgroup=todoDone
syn match   todoIgnore  /\[X\]/ nextgroup=todoDone
syn match   todoInProg  /\[I\]/ nextgroup=todoCurrent
syn match   todoInProg  /\[C\]/ nextgroup=todoCurrent
syn match   todoEmpty   /\[\s\]/
syn match   todoTitle   /^\s*TODO.\+/ contains=todoDate,todoTime12,todoTime24
syn match   todoParens  /<.\+>/

hi link     todoOkValue Special
hi link     todoOk      Special
hi link     todoTime12  Special
hi link     todoTime24  Special
hi link     todoInProg  Type
hi link     todoCurrent Type
hi link     todoDate    Number
hi link     todoEmpty   Statement
hi link     todoVital   Statement
hi link     todoImp     Statement
hi link     todoTitle   Identifier
hi link     todoProj    Identifier
hi link     todoComment Comment
hi link     todoDone    Comment
hi link     todoIgnore  Comment
hi link     todoParens  String

let b:current_syntax = "todo"

"_black vim: ts=8 sw=2
