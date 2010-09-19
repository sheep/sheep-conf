" Source: Found at http://svn.tylerrick.com/public/vim/ (ftplugin/ruby.vim)
"
" This is for user-specific stuff in addition to the core plugin available here:
"   $VIMRUNTIME/ftplugin/ruby.vim
" See also:
"   $VIMRUNTIME/compiler/ruby.vim
"   $VIMRUNTIME/compiler/rubyunit.vim
"   $VIMRUNTIME/syntax/ruby.vim
"   $VIMRUNTIME/indent/ruby.vim

" Only do this when not done yet for this buffer
if (exists("b:did_per_user_ftplugin"))
  finish
endif
let b:did_per_user_ftplugin = 1

set tabstop=2
set shiftwidth=2	" Number of spaces to use for each step of (auto)indent. Should always match tabstop, in my opinion.
set expandtab

"----------
" Source: http://software.pmade.com/blogs/ramblings/2006/06/02/vim_mapping_for_ruby
" Author: Peter Jones
function! RubyEndToken ()
    let current_line = getline( '.' )
    let braces_at_end = '{\s*\(|\(,\|\s\|\w\)*|\s*\)\?$'
    let stuff_without_do = '^\s*\(class\|if\|unless\|begin\|case\|for\|module\|while\|until\|def\)'
    let with_do = 'do\s*\(|\(,\|\s\|\w\)*|\s*\)\?$'

    if match(current_line, braces_at_end) >= 0
        return "\<CR>}\<C-O>O" 
    elseif match(current_line, stuff_without_do) >= 0
        return "\<CR>end\<C-O>O" 
    elseif match(current_line, with_do) >= 0
        return "\<CR>end\<C-O>O" 
    else
        return "\<CR>" 
    endif
endfunction
"----------


"imap <<-    <<-EndString<CR><Tab><CR>EndString<Esc>-A
iabbrev <<-    <<-EndString<CR><Tab><CR>EndString<Esc>-A<Backspace>

"iabbrev %Q( %Q()<Left>
"imap %Q( %Q( )<Left>


imap <buffer> <CR> <C-R>=RubyEndToken()<CR>
