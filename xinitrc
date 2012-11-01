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
if which gnome-keyring-daemon >/dev/null 2>&1; then
  eval `gnome-keyring-daemon -c ssh -s`
  export SSH_AUTH_SOCK
fi

# Load french charactere with 'Alt Gr'
test -f .Xmodmap && xmodmap .Xmodmap

# Set timeout for Energy Star (DPMS) of screen
xset dpms 300
xset +dpms

if which xscreensaver >/dev/null 2>&1; then
  xscreensaver -no-splash &
fi

# Should check if it exist
urxvtd -q -f -o

export PYTHONOPTIMIZE=2

exec wmii
