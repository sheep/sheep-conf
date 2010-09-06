import os

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
)

wmii.colrules = (
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

))

print "Configuration loaded"

# vim:se sts=4 sw=4 et:
