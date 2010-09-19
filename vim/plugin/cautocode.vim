""
"" cautocode.vim for autocode in /u/a1/sigour_b/.vim/plugins
""
"" Made by SIGOURE Benoit
"" Login   <sigour_b@epita.fr>
""
"" Started on  Mon Feb 20 15:58:40 2006 SIGOURE Benoit
"" Last update mar 27 oct 2009 12:15:57 CET Bertrand Ngoy
""

" Because coding != rating

if has("autocmd")

  aug coding
    au BufEnter *.[ch],*.C,*.sh,*.sed,*.ti[gh] call CFile_Map()
    au BufLeave *.[ch],*.C,*.sh,*.sed,*.ti[gh] call CFile_UnMap()
    au BufEnter *.cc,*.cpp,*.hh,*.[hc]xx,*.hcc call CXXFile_Map()
    au BufLeave *.cc,*.cpp,*.hh,*.[hc]xx,*.hcc call CXXFile_UnMap()
  aug END

  function CFile_Map()
    imap { {<NL> <BS><NL>}<Up><End>
    imap ( ()<Left>
    imap [ []<Left>
    inoremap " ""<Left>
    inoremap < <><Left>
    imap <buffer> ;; <ESC>/%%%<CR><ESC>c3l
    nmap <buffer> ;; /%%%<CR>c3l
    imap <buffer> ;main <ESC>ddiint<C-TAB>main(int argc, char** argv<Right><NL>{
    imap <buffer> ;for <C-O>mzfor(%%%; %%%; %%%<Right><NL>{ %%%<C-O>'z;;
    imap <buffer> ;print <C-O>mzfprintf(%%%, %%%, %%%<Right>;<ESC>==<C-O>'z;;

  endfun

  function CFile_UnMap()
    silent! iunmap {
    silent! iunmap (
    silent! iunmap [
    silent! mapclear <buffer>
  endfun

  function CXXFile_Map()
    imap { {<NL> <BS><NL>}<Up><End>
    " uggly but seems necessary to avoid an infinite recursion of the mapping
    imap ( ()<Left><Left><Space><Right>
    imap [ []<Left>
    inoremap " ""<Left>
    inoremap < <><Left>
    imap <buffer> ;; <ESC>/%%%<CR><ESC>c3l
    nmap <buffer> ;; /%%%<CR>c3l
    imap <buffer> ;main <ESC>ddiint<C-TAB>main(int argc, char** argv<Right><NL>{
    imap <buffer> ;for <C-O>mzfor(%%%; %%%; %%%<Right><NL>{ %%%<C-O>'z;;
  endfun

  function CXXFile_UnMap()
    iunmap {
    iunmap (
    iunmap [
    silent! mapclear <buffer>
  endfun

endif
