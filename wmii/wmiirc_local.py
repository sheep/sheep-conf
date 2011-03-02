import os
import time

import pygmi
from pygmi import *

# Theme
background = '#363946'

wmii['font'] = 'drift,-*-fixed-*-*-*-*-13-*-*-*-*-*-*-*'
wmii['normcolors'] = '#e0e0e0', '#202020', '#202438'
wmii['focuscolors'] = '#cae682', '#505860', '#303840'

wmii['border'] = 5

wmii.tagrules = (
    ('Firefox|Shiretoko|Namoroka', 'web'),
    ('Google Chrome|Chromium', 'web'),
    ('Opera', 'web'),
    ('Pidgin|XChat', 'chat'),
    ('Icedove', 'mail'),

    ('trayer', '/.*/'),
)

wmii.colrules = (
    # With xchat/pidgin
    ('chat', '75+25'),
    ('.*', '50+50'),
)

terminal = 'wmiir', 'setsid', 'xterm'
browser = 'firefox'

keys.bind('main', (
    "Running programs",
    ('%(mod)s-x', "Launch a terminal",
        lambda k: call(*terminal, background=True)),
    ('%(mod)s-F5', "Launch Firefox",
        lambda k: call(browser, background=True)),

    "Tag actions 2",
    ('%(mod)s-period', "Move to the view to the left",
        lambda k: Tags().select(Tags().next())),
    ('%(mod)s-comma', "Move to the view to the right",
        lambda k: Tags().select(Tags().next(True))),
    ('%(mod)s-Shift-period', "Move to the view to the left, take along current client",
        lambda k: Tags().select(Tags().next(), take_client=Client('sel'))),
    ('%(mod)s-Shift-comma', "Move to the view to the right, take along current client",
        lambda k: Tags().select(Tags().next(True), take_client=Client('sel'))),

    "Select specific tag",
    ('%(mod)s-equal', "Move to view 'web'",
        lambda k: Tags().select("web")),
    ('%(mod)s-minus', "Move to view 'chat'",
        lambda k: Tags().select("chat")),

    "Moving around",
    ('%(mod)s-Left',  "Select the client to the left",
        lambda k: Tag('sel').select('left')),
    ('%(mod)s-Right', "Select the client to the right",
        lambda k: Tag('sel').select('right')),
    ('%(mod)s-Up',    "Select the client above",
        lambda k: Tag('sel').select('up')),
    ('%(mod)s-Down',  "Select the client below",
        lambda k: Tag('sel').select('down')),
))

trayer = 'trayer', '--expand', 'true', '--widthtype', 'request', \
    '--height', '5', '--transparent', 'true', '--alpha', '255', \
    '--edge', 'bottom', '--align', 'right'
call(*trayer, background=True, preexec_fn=time.sleep(1))

print "Configuration loaded"

# vim:se sts=4 sw=4 et:
