#!/bin/zsh
## dot.zshrc for skel in /afs/.epitech.net/users/skel
##
## Made by rocky luke
## Login   <root@epitech.eu>
##
## Started on  Thu Aug 28 09:54:48 2008 rocky luke
## Last update Thu Aug 28 10:07:26 2008 rocky luke
##

export EDITOR='emacs'
export HISTFILE="$HOME/.history"
export LOGCHECK='60'
export MAILCHECK=0
export PAGER='less'
export WATCH='all'
export WATCHFMT='%n has %a %l from %m at %T'

if [ -f ${HOME}/.myzshrc ]
then
    . ${HOME}/.myzshrc
fi
