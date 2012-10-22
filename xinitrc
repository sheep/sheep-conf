#! /bin/sh

export PATH="$HOME/bin:$PATH"

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

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

if which xscreensaver; then
  xscreensaver -no-splash &
fi

export PYTHONOPTIMIZE=2

exec wmii
