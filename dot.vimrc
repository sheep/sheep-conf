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
"set incsearch		" Incremental search
"set autowrite		" Automatically save before commands like :next and :make
"set hidden             " Hide buffers when they are abandoned
"set mouse=a		" Enable mouse usage (all modes) in terminals
"set background=dark
set autowrite
set ttyfast

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

set statusline=[%n]\ %<%f\ %((%1*%M%*%R%Y)%)\ %=%-19(\Line\ [%4l/%4L]\ \Col\ [%02c%03V]%)\ ascii['%03b']\ %P
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


" Other part

"help tabstop         " Find out more about this stuff.
"help vimrc           " Find out more about .vimrc/_vimrc :-)


set scrolloff=2     " to have always 2 line before/after the cursor
                    " in top/bottom of the screen
set wildmode=longest,list " to have a bash style autocompletion

" Filetype Settings [require autocmd]
if has("autocmd")

  filetype indent on

  autocmd FileType gitcommit set noexpandtab
  autocmd FileType changelog set noexpandtab
  autocmd FileType make set shiftwidth=8

  autocmd FileType ada set shiftwidth=3
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

" Change buffer
map <C-N> :bn<CR>
map <C-P> :bp<CR>
