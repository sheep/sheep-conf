#! /bin/sh

export PATH="$HOME/bin:$PATH"
export PAGER='most -s'

# Load .Xdefaults
test -f .Xdefaults && xrdb .Xdefaults

# Add a ssh-agent
if which gnome-keyring-daemon; then
  eval `gnome-keyring-daemon -c ssh -s`
  export SSH_AUTH_SOCK
fi

# Load french charactere with 'Alt Gr'
test -f .Xmodmap && xmodmap .Xmodmap

# Set timeout for Energy Star (DPMS) of screen
xset dpms 300
xset +dpms

xscreensaver -no-splash &

export PYTHONOPTIMIZE=2

exec wmii
