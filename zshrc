#!/usr/bin/zsh
## .zshrc for zsh in /home/anthony
##
## Made by anthony perard
## Login   <perard_a@epita.fr>
##
## Started on  Wed Dec 27 20:12:19 2006 anthony perard
## Last update Fri May 16 21:51:28 2008 Anthony PERARD
##

# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi

# Source a zsh files with auto compile if needed
compile_source() {
  if [ -f "$1" -a ! -e "$1.zwc" -o "$1" -nt "$1.zwc" ]; then
    zcompile "$1"
  fi
  source "$1"
}

# Enable colors for ls, etc.  Prefer ~/.dir_colors #64489
#if [[ -f ~/.dir_colors ]]; then
#	eval `dircolors -b ~/.dir_colors`
#else
#	eval `dircolors -b /etc/DIR_COLORS`
#fi

# Change the window title of X terminals
case $TERM in
	xterm*|rxvt*|Eterm)
		PROMPT_COMMAND='echo -ne "\033]0;zsh: ${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\007"'
		;;
	screen)
		PROMPT_COMMAND='echo -ne "\033_zsh: ${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\033\\"'
		;;
esac


#######
# ENV #
#######

umask 22

# export MALLOC_OPTIONS=J

export PAGER=less
#export NNTPSERVER="news"

export NAME='Anthony PERARD'
export FULLNAME='Anthony PERARD'
export EMAIL='anthony.perard@gmail.com'
export REPLYTO='anthony.perard@gmail.com'
export SHELL='zsh'

test -d $HOME/bin && export PATH="$HOME/bin:$PATH"
test -d /usr/local/bin && export PATH="$PATH:/usr/local/bin"

export EDITOR='vim'
export HGEDITOR='~/.myconf/hgeditor'
export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.rar=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'
export NO_STRICT_EPITA_HEADERS='1' # Used for ViM

# runsocks
#export SOCKS5_PASSWD=`cat ${HOME}/.socks`
#export SOCKS5_USER=${USER}
#export SOCKS5_SERVER='socks-2.epita.fr'

# tsocks
test -f ~/.socks && export TSOCKS_PASSWORD=$(cat ~/.socks)

export MAKE=make

# config.site
#export CONFIG_SITE="$HOME/config.site"

ZSHDIR="$HOME/.zsh"

compile_source ~/.zsh/env_var

#########
# Alias #
#########

if [ -f ~/.zsh/alias ]; then
    compile_source ~/.zsh/alias
fi

############
# Function #
############

# function rename, to rename a windows in xterm
rename () {echo -ne "\033]0;$@\007"; }

#function fun
cdls () { cd "$1" && ls }
alias cl=cdls

if [ -f ~/.zsh/functions_all ]; then
  compile_source ~/.zsh/functions_all
fi

###############
# ZSH OPTIONS #
###############

if [ -f ~/.zsh/options ]; then
  compile_source ~/.zsh/options
fi

fpath=(~/.zsh/functions $fpath)

##########
# COLORS #
##########

std="%{[m%}"
red="%{[0;31m%}"
green="%{[0;32m%}"
yellow="%{[0;33m%}"
blue="%{[0;34m%}"
purple="%{[0;35m%}"
cyan="%{[0;36m%}"
grey="%{[0;37m%}"
white="%{[0;38m%}"
lred="%{[1;31m%}"
lgreen="%{[1;32m%}"
lyellow="%{[1;33m%}"
lblue="%{[1;34m%}"
lpurple="%{[1;35m%}"
lcyan="%{[1;36m%}"
lgrey="%{[1;37m%}"
lwhite="%{[1;38m%}"

###########
# PROMPTS #
###########

PS2='`%_> '       # secondary prompt, printed when the shell needs more information to complete a command.
PS3='?# '         # selection prompt used within a select loop.
PS4='+%N:%i:%_> ' # the execution trace prompt (setopt xtrace). default: '+%N:%i>'
if [ $UID != 0 ]; then
  local prompt_user="${lgreen}%n${std}"
  local prompt_host="${lgreen}@%m${std}"
else
  #local prompt_user="${lred}%n${std}"
  local prompt_host="${lred}%m${std}"
fi
#local prompt_host="${lgreen}%m${std}"
local prompt_cwd="${lblue}%B%40<..<%~%<<%b"
local prompt_time="${lblue}%D{%H:%M:%S}${std}"
local prompt_rv="%(?..${lred}%?${std} )"
PROMPT="${prompt_user}${prompt_host} ${prompt_cwd} ${lblue}%(!.#.$)${std} "
RPROMPT="${prompt_rv}${prompt_time}"

##############
# TERM STUFF #
##############

#/bin/stty erase "^H" intr "^C" susp "^Z" dsusp "^Y" stop "^S" start "^Q" kill "^U"  >& /dev/null

chpwd() {
    [[ -t 1 ]] || return
    case $TERM in
      sun-cmd) print -Pn "\e]lzsh: %n@%m %~\e\\"
        ;;
      *xterm*|rxvt|(k|E|dt)term) print -Pn "\e]0;zsh: %n@%m %~\a"
        ;;
    esac
}

chpwd
#setterm -blength 0

# CUSTOM WIDGETS

show-man ()
{
  man ${BUFFER%% *} 2> /dev/null;
}

# FIXME Don't work on multiline, zsh segv when call zle accept-line.
my-accept-line ()
{
    targets="emacs e firefox xpdf gthumb eclipse gnus"

    if test "${+SSH_CONNECTION}" -eq 0; then
        if ! echo "$BUFFER" | grep -Eq "&!?$"; then
            for t in $targets; do
                if echo $BUFFER | grep -q "^$t\b"; then
                    BUFFER="$BUFFER&!"
                    break
                fi
            done
        fi
    fi
    zle accept-line
}

#zle -N my-accept-line
zle -N show-man # opens the man of the current command

#bindkey "" my-accept-line


################
# KEY BINDINGS #
################
bindkey -e			# bind similaire a emacs
#bindkey -v			# bind similaire a vim

if test "$TERM" = "linux"; then
  bindkey '\e[1~'	beginning-of-line	# home
  bindkey '\e[4~'	end-of-line		# end
else
  bindkey '\e[H'	beginning-of-line	# home
  bindkey '\e[F'	end-of-line		# end
fi
#bindkey "\eOP"	run-help		# run-help when F1 is pressed
#bindkey "^[[A"	up-line-or-search	# cursor up
#bindkey -s '^B'	" &\n"			# ctrl-B runs it in the background
#bindkey ' '	magic-space		# also do history expansion on space
bindkey "\e[3~" delete-char
bindkey '[2~' overwrite-mode          # Insert
bindkey '[5~' history-search-backward # PgUp
bindkey '[6~' history-search-forward  # PgDn

type run-help | grep -q 'is an alias' && unalias run-help


#######################
# COMPLETION TWEAKING #
#######################

# The following lines were added by compinstall
_compdir=/usr/share/zsh/site-functions
[[ -z $fpath[(r)$_compdir] ]] && fpath=($fpath $_compdir)

autoload -U compinit; compinit -u # option -u use to not check unsecure dir and files.

# This one is a bit ugly. You may want to use only `*:correct'
# if you also have the `correctword_*' or `approximate_*' keys.
# End of lines added by compinstall

zmodload zsh/complist

zstyle ':completion:*:processes' command 'ps -au$USER'     # on processes completion complete all user processes
zstyle ':completion:*:descriptions' format \
       $'%{\e[0;31m%}completing %B%d%b%{\e[0m%}'           # format on completion
zstyle ':completion:*' verbose yes                         # provide verbose completion information
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format \
       $'%{\e[0;31m%}No matches for:%{\e[0m%} %d'
zstyle ':completion:*:matches' group 'yes'                 # separate matches into groups
zstyle ':completion:*:options' description 'yes'           # describe options in full
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:*:zcompile:*' ignored-patterns '(*~|*.zwc)'

# activate color-completion(!)
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

## correction

# Ignore completion functions for commands you don't have:
#  zstyle ':completion:*:functions' ignored-patterns '_*'
zstyle ':completion::(^approximate*):*:functions' ignored-patterns '_*'

zstyle ':completion:*'             completer _complete _correct _approximate
zstyle ':completion:*:correct:*'   insert-unambiguous true
#  zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
#  zstyle ':completion:*:corrections' format $'%{\e[0;31m%}%d (errors: %e)%}'
zstyle ':completion:*: &corrections' format $'%{\e[0;31m%}%d (errors: %e)%{\e[0m%}'
zstyle ':completion:*:correct:*'   original true
zstyle ':completion:correct:'      prompt 'correct to:'

# allow one error for every three characters typed in approximate completer
zstyle -e ':completion:*:approximate:' max-errors 'reply=( $((($#PREFIX+$#SUFFIX)/3 )) numeric )'
#  zstyle ':completion:*:correct:*'   max-errors 2 numeric

# match uppercase from lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# offer indexes before parameters in subscripts
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# insert all expansions for expand completer
zstyle ':completion:*:expand:*' tag-order all-expansions

# ignore duplicate entries
zstyle ':completion:*:history-words' stop yes
zstyle ':completion:*:history-words' remove-all-dups yes
zstyle ':completion:*:history-words' list false
zstyle ':completion:*:history-words' menu yes

# filename suffixes to ignore during completion (except after rm command)
#  zstyle ':completion:*:*:(^rm):*:*files' ignored-patterns  '*?.(o|c~|old|pro|zwc)' '*~'

# Don't complete backup files as executables
zstyle ':completion:*:complete:-command-::commands' ignored-patterns '*\~'

# If there are more than N options, allow selecting from a menu with
# arrows (case insensitive completion!).
#  zstyle ':completion:*-case' menu select=5
zstyle ':completion:*' menu select=2

# zstyle ':completion:*:*:kill:*' verbose no
#  zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
#                                /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

# caching
[ -d $ZSHDIR/cache ] && zstyle ':completion:*' use-cache yes && \
                        zstyle ':completion::complete:*' cache-path $ZSHDIR/cache/

#lrde_hosts=''
# Do we have `host' installed?
# if which host >/dev/null 2>/dev/null; then
#     if PATH='/sbin:/usr/sbin:/bin:/usr:bin' ifconfig -a 2>/dev/null | \
#        grep -qF '192.168.101'
#     then
#       # We're inside the lab: simply use hostnames for autocompletion
#       lrde_hosts="`host -l lrde.epita.fr 2>/dev/null | cut -f1 -d. | grep -v '^lrde$' | grep -ve '-sf' | xargs echo`"
#       echo "$lrde_hosts" > ~/.hosts.lrde
#     else
#       # We're outside the lab: use FQDN from the cache for autocompletion
#       test -r ~/.hosts.lrde && \
#         lrde_hosts="`sed 's/ /.lrde.epita.fr /g' ~/.hosts.lrde`"
#     fi
# fi
#
if test -r "$ZSHDIR/myhosts"; then
  my_hosts=`cat "$ZSHDIR/myhosts"`
  zstyle ':completion:*:hosts' hosts ${=my_hosts}
fi

# simple completion for fbset (switch resolution on console)
_fbmodes() { compadd 640x480-60 640x480-72 640x480-75 640x480-90 640x480-100 768x576-75 800x600-48-lace 800x600-56 800x600-60 800x600-70 800x600-72 800x600-75 800x600-90 800x600-100 1024x768-43-lace 1024x768-60 1024x768-70 1024x768-72 1024x768-75 1024x768-90 1024x768-100 1152x864-43-lace 1152x864-47-lace 1152x864-60 1152x864-70 1152x864-75 1152x864-80 1280x960-75-8 1280x960-75 1280x960-75-32 1280x1024-43-lace 1280x1024-47-lace 1280x1024-60 1280x1024-70 1280x1024-74 1280x1024-75 1600x1200-60 1600x1200-66 1600x1200-76 }
compdef _fbmodes fbset

# use generic completion system for programs not yet defined:
compdef _gnu_generic tail head feh cp mv gpg df stow uname ipacsum fetchipac

# Debian specific stuff
# zstyle ':completion:*:*:lintian:*' file-patterns '*.deb'
#zstyle ':completion:*:*:linda:*'   file-patterns '*.deb'

#_debian_rules() { words=(make -f debian/rules) _make }
#compdef _debian_rules debian/rules # type debian/rules <TAB> inside a source package

# see upgrade function in this file
compdef _hosts upgrade
