set nocompatible
"set columns
if has("syntax")
  syntax on
endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
if has("autocmd")
  filetype plugin indent on
endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
"set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
"set smartcase		" Do smart case matching
set incsearch		" Incremental search
set autowrite		" Automatically save before commands like :next and :make
"set hidden             " Hide buffers when they are abandoned
set mouse=a             " Enable mouse usage (all modes) in terminals
"set background=dark
set ttyfast
set splitright          " to have the new window on the right instead of the left, when vertical split

" Colors Scheme

colorscheme candycode
"colorscheme fnaqevan

" GUI

if has("gui_running")

  "set guioptions-=T     " Remove tool bar
  set guioptions=       " Remove all
  set noguipty
  set mousehide 	" hide the mouse cursor when typing

  " Change background only if in GUI (not in term)
  highlight Normal gui=NONE guibg=Black guifg=White

endif

" Status line

set statusline=[%n]\ %<%f\ %((%1*%M%*%R%Y)%)\ %=%-19(\Line\ [%4l/%4L]\ \Col\ [%02c%03V]%)\ %P
highlight StatusLine term=reverse  cterm=bold ctermfg=white ctermbg=lightblue gui=bold guifg=white guibg=blue
set laststatus=2      " To always view statusline

" Indent Part

set tabstop=8        " Force tabs to be displayed/expanded to 4 spaces (instead of default 8).
set softtabstop=2    " Make Vim treat <Tab> key as 4 spaces, but respect hard Tabs.
                     "   I don't think this one will do what you want.
set expandtab        " Turn Tab keypresses into spaces.  Sounds like this is happening to you.
                     "    You can still insert real Tabs as [Ctrl]-V [Tab].
"set noexpandtab      " Leave Tab keys as real tabs (ASCII 9 character).
"1,$retab!            " Convert all tabs to space or ASCII-9 (per "expandtab"),
                     "   on lines 1_to_end-of-file.
set shiftwidth=2     " When auto-indenting, indent by this much.
                     "   (Use spaces/tabs per "expandtab".)
set directory=~/.vim/tmp " directory to place swap files in
set title		" set the title of the windows to the current file name
set autoindent		" always set autoindenting on

set cinoptions=(0     " Options for the C indentation


" Other part

"help tabstop         " Find out more about this stuff.
"help vimrc           " Find out more about .vimrc/_vimrc :-)

" Folding {
  set foldenable                  " Turn on folding
  set foldmarker={,}              " Fold C style code (only use this as default
                                  " if you use a high foldlevel)
  set foldmethod=marker           " Fold on the marker
  set foldlevel=100               " Don't autofold anything (but I can still
			          " fold manually)
  set foldopen=block,hor,mark,percent,quickfix,tag 	" what movements
							" open folds
  function SimpleFoldText() " {
    return getline(v:foldstart).' '
  endfunction " }
  set foldtext=SimpleFoldText()   " Custom fold text function
				  " (cleaner than default)
" }

set scrolloff=2     " to have always 2 line before/after the cursor
                    " in top/bottom of the screen

" Command line
" Suffixes file to ignore on completion.
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc
set wildignore=.o
" set wildmode=longest,list " to have a bash style autocompletion
"set wildmode=list:longest,full,longest:full
set wildmode=longest:full,full
set wildmenu

" Filetype Settings [require autocmd]
if has("autocmd")

  filetype indent on

  autocmd FileType gitcommit setl noexpandtab
  autocmd FileType changelog setl noexpandtab
  autocmd FileType make setl shiftwidth=8
  autocmd FileType c setl shiftwidth=4
  autocmd FileType cpp setl shiftwidth=4

  autocmd FileType ada setl shiftwidth=3
  "autocmd FileType ada set makeprg=make

  " automatically delete trailing DOS-returns and trailing whitespaces
  autocmd BufWritePre *.c,*.h,*.y,*.yy,*.l,*.ll,*.C,*.cpp,*.hh,*.cc,*.hxx,*.cxx,*.hpp,*.java,*.rb,*.py,*.m4,*.pl,*.pm silent! %s/[\r \t]\+$//
endif

" Key mapping

" To manipulate compiling
map <F5> :make<CR>
map <F6> :cp<CR>
map <F7> :cn<CR>
map <F8> :cwindow<CR>

" buffer stuffs
map <C-N> :bn<CR>
map <C-P> :bp<CR>
map <space>l :bn<CR>
map <space>h :bp<CR>
map <space>o :BufExplorer<CR>
map <space>t :tabnew<CR>
map <space>k :tabn<CR>
map <space>j :tabp<CR>

" ctags mappings {
" refresh systags
"map <F11> :! ctags -f ~/.vim/systags -R /usr/include /usr/local/include<CR>
"set tags+=~/.vim/systags
map <F11> :! ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
imap <C-SPACE> <C-X><C-O>
