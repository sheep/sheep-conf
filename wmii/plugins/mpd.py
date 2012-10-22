# Check this:
# http://jatreuman.indefero.net/p/python-mpd/page/ExampleErrorhandling/
# mpd client protocol: http://www.musicpd.org/doc/protocol/ch03.html

from threading import Thread
from select import select
from os import pipe, fdopen
from time import sleep

if __name__ != "__main__":
    import pygmi
    from pygmi import *

from pympd import mpd

SONG_MAX = 60
mpc = None
monitor = None
cmd_in = None
cmd_out = None

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
    global mpc

    if not mpc:
      return None

    try:
        status = mpc.status()
        song = ''
        prefix = 'mpc: (%s)' % status['state']
        if status['state'] in ('play', 'pause'):
            song = ' %s' % songstr(mpc.currentsong())
        if status['state'] == "stop":
            prefix = u"\u25A0"
        elif status['state'] == "play":
            prefix = u"\u25B6"
        elif status['state'] == "pause":
            prefix = u"\u25AE\u25AE"
        return wmii.cache['normcolors'], u'%s%s' % (prefix, song)
    except UnicodeDecodeError, e:
        return wmii.cache['normcolors'], u'%s' % prefix

def mpd_loop(monitor):
    global mpc
    global cmd_in
    idle = False
    updated = True

    while True:
        try:
            if not mpc:
                mpc = mpd.MPDClient()
                mpc.connect('localhost', 6600)

            if updated:
                if monitor:
                    monitor.refresh()
                else:
                    print "(%s) %s" % (mpc.status()['state'], songstr(mpc.currentsong()))
                updated = False

            mpc.send_idle('player')
            idle = True
            (rfds, _, _) = select([mpc,cmd_in], [], [])
            # check first if mpd have a new status!
            if rfds.count(mpc) > 0:
                rfds.pop(rfds.index(mpc))
                mpc.fetch_idle()
                idle = False
                updated = True
            # then run a command
            if rfds.count(cmd_in) > 0:
                fd = rfds.pop(rfds.index(cmd_in))
                if idle:
                    mpc.send_noidle()
                    mpc.fetch_idle()
                    idle = False
                cmd = cmd_in.readline()
                if cmd == 'play\n':
                    if mpc.status()['state'] in ('pause', 'stop'):
                        mpc.play()
                    else:
                        mpc.pause(1)
                elif cmd == 'stop\n':
                    mpc.stop()
                elif cmd == 'next\n':
                    mpc.next()
                elif cmd == 'prev\n':
                    mpc.previous()
                else:
                    print 'mpd: Unrecognised "%s" command.' % cmd

        except mpd.MPDError as e:
            print "mpd: %s, reconnect..." % e
            mpc.disconnect()
            sleep(5)
            mpc = None
        except Exception as e:
            print "mpd: %s %s, quit!" % (type(e), e)
            break

def send_command(cmd):
    global cmd_out
    cmd_out.write('%s\n' % cmd)
    cmd_out.flush()

if __name__ != "__main__":
    monitor = defmonitor(update, name='1_mpd', interval=-1)

    keys.bind('main', (
        "Musique (MPD)",
        ('XF86AudioPlay', "Play/Pause",
            lambda k: send_command('play')),
        ('XF86AudioStop', "Stop",
            lambda k: send_command('stop')),
        ('XF86AudioNext', "Next music",
            lambda k: send_command('next')),
        ('XF86AudioPrev', "Previous music",
            lambda k: send_command('prev')),

        ('%(mod)s-Home', "Play/Pause",
            lambda k: send_command('play')),
        ('%(mod)s-End', "Stop",
            lambda k: send_command('stop')),
        ('%(mod)s-Next', "Next music",
            lambda k: send_command('next')),
        ('%(mod)s-Prior', "Previous music",
            lambda k: send_command('prev')),
        # TODO For this next one, should check if urxvtd is used and if ncmpcpp is installed
        ('%(mod)s-Insert', "Run ncmpcpp",
            lambda k: call('urxvtc', '-e', 'ncmpcpp', background=True)),
        ))

(cmd_in,cmd_out) = pipe()
cmd_in = fdopen(cmd_in, 'r', 5)
cmd_out = fdopen(cmd_out, 'w', 5)
Thread(target=mpd_loop, args=(monitor,)).start()

# vim:sw=4 ts=4 expandtab
