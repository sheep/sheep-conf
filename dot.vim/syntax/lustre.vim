" Vim syntax file
" Language:	Lustre
" Adapte de pascal.vim de
" ----Maintainer:	Mario Eusebio <bio@dq.fct.unl.pt>

syn clear

syn case ignore

syn keyword lustrePack	package model provides needs body end uses

syn keyword lustreStatement		returns var let tel assert
" syn keyword lustreLabel		      case goto
syn keyword lustreConditional	   if else then

syn keyword lustreTodo contained	TODO

" String
" syn region  lustreString	start=+'+  end=+'+

syn match  lustreIdentifier		"\<[a-zA-Z_][a-zA-Z0-9_]*\>"

syn match  lustreDelimiter		"[()]"

" syn match  lustreMatrixDelimiter	"[][]"

"if you prefer you can highlight the range
"syn match  lustreMatrixDelimiter	"[[0-9]\+\.\.[0-9]\+]"

" Les notations numeriques sont recuperees de c.vim
syn match lustreNumber    "\<[0-9]\+\>"
"floating point number, with dot, optional exponent
syn match lustreFloat     "\<[0-9]\+\.[0-9]*\(e[-+]\=[0-9]\+\)\=\>"
"floating point number, starting with a dot, optional exponent
syn match lustreFloat     "\.[0-9]\+\(e[-+]\=[0-9]\+\)\=\>"
"floating point number, without dot, with exponent
syn match lustreFloat     "\<[0-9]\+e[-+]\=[0-9]\+\>"


" If you don't like tabs
"syn match lustreShowTab "\t"
"syn match lustreShowTabc "\t"

" Les caracteres speciaux
syn match lustreOperator "[#+/*=><^]"
syn match lustreOperator ">="
syn match lustreOperator ">="
syn match lustreOperator "<>"


syn region lustreComment	start="(\*"  end="\*)" contains=lustreTodo
syn region lustreComment	start="/\*"  end="\*/" contains=lustreTodo

" Priorite des trucs qui commencent par -
syn match lustreType "<<"
syn match lustreType ">>"
syn match lustreOperator "-"
syn match lustreOperator "->"
syn match lustreComment	"--.*" contains=lustreTodo

" Les mots-cles
syn keyword lustreConstant true false
syn keyword lustreOperator	and or not xor
syn keyword lustreOperator div mod
syn keyword lustreOperator pre current when
syn keyword lustreType	bool int real map red fill
syn keyword lustreFunction	node function type const
syn keyword lustreStatement	extern unsafe

syn sync lines=250

if !exists("did_lustre_syntax_inits")
  let did_lustre_syntax_inits = 1
  " The default methods for highlighting.  Can be overridden later
  hi link lustreStatement		Statement
  " hi link lustreLabel			Label
  hi link lustreConditional		Conditional
  hi link lustreTodo			Todo
  " hi link lustreString			String
  " hi link lustreMatrixDelimiter		Identifier
  hi link lustreConstant		Number
  hi link lustreNumber			Number
  hi link lustreFloat			Number
  " hi link lustreByte			Number
  hi link lustreOperator			Operator
  hi link lustreFunction			Function
  hi link lustreType			Type
  hi link lustreComment			Comment
  hi link lustreStatement		Statement

  hi link lustrePack		Type

"optional highlighting
  hi link lustreDelimiter		Identifier

  "hi link lustreShowTab			Error
  "hi link lustreShowTabc		Error

  "hi link lustreIdentifier		Identifier
endif

let b:current_syntax = "lustre"

" vim: ts=8
