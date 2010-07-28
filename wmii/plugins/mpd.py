# python-wmii mpd status plugin v.0.1
#
# Description:
# ------------
# Display the state of MPD in the wmii status bar.
# Requires the mpdlib2 library, part of pympd.
#
# Install:
# -------
# Copy this file in ~/.wmii-3.5/statusbar/
#
# How I use it:
# -------------
# I have some global bindings set up to control MPD, via mpc,
# using xbindkeys. (could use directly the wmii keybinding system
# but I prefer to access these functions from any window manager.
# This small plugin allows me to have some visual feedback by
# showing the current playing song, if any.
#
# Can also be used as a stand-alone script:
#	python 10_mpd.py | dzen2
# (passes the output to dzen)
#
# Updates:
# --------
# 2007-11-28    simplify update() function, update songstr()
#               to generate better output, add logger, add to
#               python-wmii mercurial repository
#
# ------------------------------------------------------------
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
#
# Copyright (C) 2007 Brescan Florin ( ratzunu at gmail ... )
#
# Hacked by Anthony PERARD
# update to use with wmii-3.9.2

# vim:syntax=python:sw=4:ts=4:expandtab

import pygmi
from pygmi import *

has_pympd = False
try:
    import mpdlib2
    has_pympd = True
except:
    pass

SONG_MAX = 60
mpd = None
monitor = None

def songstr(song):
    s = ''
    if 'title' in song:
        if 'artist' in song:
            s += song['artist'] + ' - '
        s += song['title']
    else:
        s = song.get('file', '')

    if s and len(s) > SONG_MAX:
        s = '..%s' % s[len(s) - SONG_MAX:]
    return s

def update(self):
    global mpd

    try:
        if not mpd:
            mpd = mpdlib2.connect()

        status = mpd.status()

        if status:
            song = ''
            if status.state in ('play', 'pause'):
                song = ' %s' % songstr(mpd.currentsong())
            return wmii.cache['normcolors'], 'mpd: (%s) %s' % (status.state, song)
    except Exception, e:
        mpd = None  # try to reconnect if connection is lost

    return None

def pause():
    global mpd
    if mpd:
        if mpd.status().state in ('pause', 'stop'):
            mpd.play()
        else:
            mpd.pause(1)
        monitor.refresh()

def stop():
    mpd.stop()
    monitor.refresh()

def next(n):
    if n:
        mpd.next()
    else:
        mpd.previous()
    monitor.refresh()

if has_pympd:
    monitor = defmonitor(update, name='1_mpd', interval=3.0)

    keys.bind('main', (
      "Musique",
      ('XF86AudioPlay', "Play/Pause",
        lambda k: pause()),
      ('XF86AudioStop', "Stop",
        lambda k: stop()),
      ('XF86AudioNext', "Next music",
        lambda k: next(True)),
      ('XF86AudioPrev', "Previous music",
        lambda k: next(False)),

      ('%(mod)s-Home', "Play/Pause",
        lambda k: pause()),
      ('%(mod)s-End', "Stop",
        lambda k: stop()),
      ('%(mod)s-Next', "Next music",
        lambda k: next(True)),
      ('%(mod)s-Prior', "Previous music",
        lambda k: next(False)),
    ))

#${mod}-Prior: play_previous_song
#${mod}-Next: play_next_song
#${mod}-Return: pause_current_song_toggle
#${mod}-Home: load_playlist_from_menu
#${mod}-End: add_current_song_to_playlist_from_menu
