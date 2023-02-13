" Vim syntax file
" Language:    .todo and .done files
" Maintainer:  Jordan Woods
" Originator:  Josep M. Bach <josep.m.bachNOSPAN@gmail.com>
" Last Change: 02/01/2023

if exists("b:current_syntax")
  finish
endif

syn case ignore " I am fine with everything being case insensitive
set foldmethod=marker " fold with { { { #
syn sync fromstart

" Date And TimeStamps
syn match   toDate         "\<\(sun\|mon\|tue\|wed\|thu\|fri\|sat\), \(1[0-9]\|2[0-9]\|3[0-1]\|0\?[1-9]\)\s\w*\s\(\d\d\d\d\|\d\d\)\>"
" syn match   toDate         "\<\(1[0-9]\|2[0-9]\|3[0-1]\|0\?[1-9]\)\s\w*\s\(\d\d\d\d\|\d\d\)\>"
syn match   toDate         "\<\(0\?[1-9]\|1[0-2]\)[/]\(1[0-9]\|2[0-9]\|3[0-1]\|0\?[1-9]\)\(/\d\d\d\d\>\|/\d\d\>\)\?"
syn match   toTime24       "\<\(0\?[0-9]\|1[0-9]\|2[0-3]\):\([0-5][0-9]\)\>"
syn match   toTime12       "\<\(0\?[0-9]\|1[0-2]\):\([0-5][0-9]\)\s*\([ap]m\>\)*"
syn match   toTime12       "\<\(0\?[0-9]\|1[0-2]\)\s*\([ap]m\)"
" Allow for good looking timekeeping in to-done lists.
syn match   toTimeCard     "(\(XX\|[0-9]\?[0-9]\)\(:[0-5][0-9]\|\.[0-9][0-9]\|:XX\|.XX\))" contains=toTimeCFrame
syn match   toTimeCFrame   "\(XX\|[0-9]\?[0-9]\)\(:[0-5][0-9]\|\.[0-9][0-9]\|:XX\|.XX\)" contained

" Vital Keywords...
syn keyword toVital        vital important today tomorrow urgent wait nextgroup=toImp
syn keyword toVital        hold nextgroup=toOn,toImp
syn match   toOn           /\s\+on/ contained  nextgroup=toImp
syn match   toImp          /:/ contained
syn keyword toKeyWord      contained TODO FIXME

" Cluster the things to still display within comments, etc.
syn cluster toContain      contains=toFold,toTimeCard,toDate,toTime12,toTime24,toVital,toKeyword,@Spell

" Block Comment with {#...#}. Regular comment with # ...
syn region  toCommentBlock start="{#" end="#}" contains=@toContain
syn match   toComment      "#.*"               contains=@toContain
syn match   toFold         "{{{\d\+"           nextgroup=toDone
syn match   toFold         "\d\+}}}"           nextgroup=toDone

" Colorize the title / section titles...
syn match   toProjTag      /^\s*=\+\s/ nextgroup=toProj skipwhite
syn match   toProjEnd      /\s\+=\+$/
syn match   toProj         /.\+/ contained contains=@toContain,toComment,toProjEnd
syn match   toProj         /^WEEK\s\+.*/ contains=@toContain,toComment
syn match   toProj         /^\s*to\s\?do.\+/ contains=toContain
syn match   toProj         /^\d\d\d\d\s\+.*/ contains=@toContain,toComment

" Uncompleted = [ ], Completed = [√], In Progress = [I], Ignore = [X]
" Colorize the checkbox: [√]...
syn match   toOkValue      /√/ contained
syn region  toOk           start=/\[/ end=/\]/ oneline contains=toOkValue nextgroup=toDone
syn match   toEmpty        /\[\s\]/
syn match   toInProg       /\[I\]/ nextgroup=toCurrent
syn match   toIgnore       /\[X\]/ nextgroup=toDone

" Comment out entry that is completed.
syn match   toDone         /.\+/ contained contains=toComBlck,toResponse,@toContain
syn region  toResponse     start="(" end=")" oneline contained
" Re-highlight entry that is in progress.
syn match   toCurrent      /.\+/ contained contains=toCurBlck,@toContain
" Use similar highlighting on other lines when using: {"..."} or lines that start with: " ...
syn region  toCurrentBlock start="{\"" end="\"}" contains=@toContain
syn match   toCurrent      /^\s*\".*/            contains=@toContain

" Use < > to highlight an important note, i.e. customer, etc. (Gets greyed out with comment)
syn match   toParens       /<.\+>/

" Make it beautiful. Note that I used 'gruvbox' for determining the colors.
hi link     toTimeCard     Normal
hi link     toKeyword      Normal
hi link     toOkValue      Special
hi link     toOk           Special
hi link     toResponse     toOk
hi link     toTime12       Special
hi link     toTime24       toTime12
hi link     toTimeCFrame   toTime12
hi link     toDate         Number
hi link     toEmpty        Statement
hi link     toVital        Statement
hi link     toOn           toVital
hi link     toImp          toVital
hi link     toProj         Identifier
hi link     toComment      Comment
hi link     toCommentBlock toComment
hi link     toDone         toComment
hi link     toIgnore       toComment
hi link     toFold         toComment
hi link     toParens       Type
hi link     toInProg       String
hi link     toCurrent      String
hi link     toCurrentBlock toCurrent

" name the syntax
let b:current_syntax = "todo_done"
"_black vim: ts=8 sw=2
