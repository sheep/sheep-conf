import re

import pygmi
from pygmi import *
from utils import colors

monitor = None
mixer = 'Master'
vol = '0'
mute = 0

reg_vol = re.compile(r'\[(\d+)%\]')
reg_mute = re.compile(r'\[(on|off)\]')

def get():
    global vol
    global mute

    output = call('amixer', 'get', mixer)
    vol = reg_vol.findall(output)[0]
    if reg_mute.findall(output)[0] == "off":
      mute = 1
    else:
      mute = 0

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
    color = wmii.cache['normcolors']
    if mute != 0:
      color = colors.redcolors
    return color, "vol: %s%%" % vol

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
