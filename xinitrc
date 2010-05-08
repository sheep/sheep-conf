#! /bin/sh

export PATH="$PATH:$HOME/bin"
export PAGER='most -s'

# Load .Xdefaults
test -f .Xdefaults && xrdb .Xdefaults

which trayion && trayion &

# Add a ssh-agent
if which gnome-keyring-daemon; then
  eval `gnome-keyring-daemon -s`
  export SSH_AUTH_SOCK
fi

# Load french charactere with 'Alt Gr'
test -f .Xmodmap && xmodmap .Xmodmap

xscreensaver -no-splash &

# Set timeout for Energy Star (DPMS) of screen
xset dpms 120
xset +dpms

exec /usr/bin/ion3
