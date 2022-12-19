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
" Date And TimeStamps
syn match   todoDate    "\<\(sun\|mon\|tue\|wed\|thu\|fri\|sat\), \(1[0-9]\|2[0-9]\|3[0-1]\|0\?[1-9]\)\s\w*\s\(\d\d\d\d\|\d\d\)"
syn match   todoDate    "\<\(1[0-9]\|2[0-9]\|3[0-1]\|0\?[1-9]\)\s\w*\s\(\d\d\d\d\|\d\d\)"
syn match   todoDate    "\<\(0\?[1-9]\|1[0-2]\)[-/]\(1[0-9]\|2[0-9]\|3[0-1]\|0\?[1-9]\)[-/]\?\(\d\d\d\d\|\d\d\)\?"
syn match   todoTime24  "\<\(0\?[0-9]\|1[0-9]\|2[0-3]\):\([0-5][0-9]\)"
syn match   todoTime12  "\<\(0\?[0-9]\|1[0-2]\):\([0-5][0-9]\)\s*\([ap]m\)*"
syn match   todoTime12  "\<\(0\?[0-9]\|1[0-2]\)\s*\([ap]m\)"

" Vital Keywords...
syn keyword todoVital   vital important today tomorrow urgent nextgroup=todoImp
syn match   todoImp     /:\s\+/ contained
syn keyword todoKeyWord contained TODO FIXME

" Cluster the things to display within comments
syn cluster todoContain contains=todoDate,todoTime12,todoTime24,todoVital,todoKeyword,@Spell

" Block Comment with {"..."}. Regular comment with " ...
syn region  todoComment start="{\"" end="\"}" contains=@todoContain
syn match   todoComment "\".*"                contains=@todoContain

" Make Normal Quotes Great Again...
syn region  todoQuote   oneline keepend start=/"/ end=/"/

" Effectively these are Title Groupings...
syn match   todoProjTag /^\s*=\+\s/ nextgroup=todoProj skipwhite
syn match   todoProj    /.\+/ contained contains=@todoContain,todoComment

" Other Highlights to hide when commented out...

" To-Do list is centered around the check box...
syn match   todoOkValue /√/ contained
" Uncompleted: [ ], Completed box = [√], In Progress = [I], Ignore = [X]
syn region  todoOk      start=/\[/ end=/\]/ contains=todoOkValue nextgroup=todoDone
syn match   todoEmpty   /\[\s\]/
syn match   todoIgnore  /\[X\]/ nextgroup=todoDone
syn match   todoInProg  /\[I\]/ nextgroup=todoCurrent
" Comment out entry that is completed.
syn match   todoDone    /.\+/ contained contains=@todoContain
" Highlight out entry that is in progress.
syn match   todoCurrent /.\+/ contained contains=@todoContain
" Use similar highlighting when using: # ...
syn match   todoCurrent /^\s*#.*/           contains=@todoContain
syn region  todoCurrent start="{#" end="#}" contains=@todoContain

" Make a Main To-Do List Title
syn match   todoTitle   /^\s*TODO.\+/ contains=todoContain
" Use < > to highlight an important note, i.e. customer, etc.
syn match   todoParens  /<.\+>/

" Make it beautiful. Note that I used 'gruvbox' for determining the colors.
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

" name the syntax
let b:current_syntax = "todo_done"
"_black vim: ts=8 sw=2
