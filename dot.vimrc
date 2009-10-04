set nocompatible
"set columns
syntax on

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
filetype indent on


" Other part

"help tabstop         " Find out more about this stuff.
"help vimrc           " Find out more about .vimrc/_vimrc :-)


set scrolloff=2     " to have always 2 line before/after the cursor
                    " in top/bottom of the screen
set wildmode=longest,list " to have a bash style autocompletion
