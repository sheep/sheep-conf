import os

import pygmi
from pygmi import *

monitor = None
loaded = 'us'

def load_layout(layout, name=None, xmodmap=None):
    global loaded
    call('setxkbmap', *layout)
    if xmodmap:
        call('xmodmap', os.path.expanduser(xmodmap))
    if name:
        loaded = name
    else:
        loaded = layout
    monitor.refresh()

def us_keyboard():
    # Change binding to default
    keys.defs['web_tag'] = 'equal'
    setattr(keys, 'mode', 'main')
    load_layout(('us', ''), 'us', '~/.Xmodmap')

def dvorak_programmer_keyboard():
    # Change binding to avoid key conflict (between = and 9)
    keys.defs['web_tag'] = 'numbersign' # '#'
    setattr(keys, 'mode', 'main')
    load_layout(('-layout', 'us', '-variant', 'dvp',
            '-option', 'compose:102', '-option', 'numpad:shift3',
            '-option', 'kpdl:semi', '-option', 'keypad:atm',
            '-option', 'caps:shift'),
        'dvp',
        None)

def dvorak_keyboard():
    # Change binding to default
    keys.defs['web_tag'] = 'equal'
    setattr(keys, 'mode', 'main')
    load_layout(('dvorak', ''), 'dv', None)

def update(self):
    color = wmii.cache['normcolors']
    return color, "%s" % loaded

monitor = defmonitor(update, name='s_keyboard', interval=-1)

keys.bind('main', (
    "Keyboard",
    ('%(mod)s-F1', "Load US+ layout",
        lambda k: us_keyboard()),
    ('%(mod)s-F2', "Load Dvorak for programmer layout",
        lambda k: dvorak_programmer_keyboard()),
    ('%(mod)s-F3', "Load Dvorak layout",
        lambda k: dvorak_keyboard()),
    ))
