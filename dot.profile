#! /bin/bash

# Add ~/bin to PATH.
export PATH="$HOME/bin:$PATH"

# TODO: Add function that test if a command exist

# Load keymapping with accent
if [ -f $HOME/.Xdefaults ]; then
  xmodmap $HOME/.Xmodmap &
fi

# Lauch netsoul
soulmebaby &

# Lauch xlock
xscreensaver -nosplash &

if [ -f $HOME/.Xdefaults ]; then
  xrdb $HOME/.Xdefaults &
fi

# test -f $HOME/bin/trayion && $HOME/bin/trayion &

trayion &
