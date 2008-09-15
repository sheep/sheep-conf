#!/bin/sh -e

export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

XTERM="xterm"
#WMNG="startfluxbox"
WMNG="ion3"
END="oclock"
SHELL="/bin/zsh"
PAGER="most"

xhost -

if [ -f $HOME/.Xdefaults ]
then
    xrdb $HOME/.Xdefaults
fi

#if [ -d $HOME/.fluxbox ]
#then
#    fluxbox-generate_menu
#fi

exec ${WMNG} &
exec ${XTERM} &

xset b off
xset r rate 300 100
umask 77
echo `date`: `hostname` on X >> .previous_host
mkdir -p /goinfre/${USER}
# this is the cache for netbeans
mkdir -p /goinfre/${USER}/.cache_netbean
# mixer speaker 0
ns_send_msg perard_a '-g 0'

exec ${END}
