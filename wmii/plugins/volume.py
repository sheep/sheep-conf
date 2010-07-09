import re

import pygmi
from pygmi import *

monitor = None
mixer = 'Master'
vol = '0'

reg_vol = re.compile(r'\[(\d+)%\]')

def get():
    global vol

    output = call('amixer', 'get', mixer)
    vol = reg_vol.findall(output)[0]

def set(value):
    call('amixer', 'set', mixer, value)
    monitor.refresh()

def increase_volume():
    set('5%+')

def decrease_volume():
    set('5%-')

def mute_volume_toggle():
    set('toggle')

def update(self):
    get()
    return wmii.cache['normcolors'], "vol: %s%%" % vol

monitor = defmonitor(update, name='4_volume', interval=60)

keys.bind('main', (
    "Volume",
    ('XF86AudioRaiseVolume', "Increase volume",
        lambda k: increase_volume()),
    ('XF86AudioLowerVolume', "Decrease volume",
        lambda k: decrease_volume()),
    ('XF86AudioMute', "Mute volume",
        lambda k: mute_volume_toggle()),

    ('%(mod)s-Shift-Prior', "Increase volume",
        lambda k: increase_volume()),
    ('%(mod)s-Shift-Next', "Decrease volume",
        lambda k: decrease_volume()),
    ('%(mod)s-Shift-End', "Mute volume",
        lambda k: mute_volume_toggle()),
    ))

    #${mod}-Shift-Prior: increase_volume
    #${mod}-Shift-Next: decrease_volume
    #${mod}-Shift-Return: mute_volume_toggle
