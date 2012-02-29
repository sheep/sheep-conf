import os
import time

import pygmi
from pygmi import *
from wmiirc import tags

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

terminal = 'wmiir', 'setsid', 'urxvt'
browser = 'firefox'

keys.bind('main', (
    "Running programs",
    ('%(mod)s-x', "Launch a terminal",
        lambda k: call(*terminal, background=True)),
    ('%(mod)s-F5', "Launch Firefox",
        lambda k: call(browser, background=True)),

    "Tag actions 2",
    ('%(mod)s-period', "Move to the view to the left",
        lambda k: tags.select(tags.next())),
    ('%(mod)s-comma', "Move to the view to the right",
        lambda k: tags.select(tags.next(True))),
    ('%(mod)s-Shift-period', "Move to the view to the left, take along current client",
        lambda k: tags.select(tags.next(), take_client=Client('sel'))),
    ('%(mod)s-Shift-comma', "Move to the view to the right, take along current client",
        lambda k: tags.select(tags.next(True), take_client=Client('sel'))),

    "Select specific tag",
    ('%(mod)s-equal', "Move to view 'web'",
        lambda k: tags.select("web")),
    ('%(mod)s-minus', "Move to view 'chat'",
        lambda k: tags.select("chat")),

    "Moving around",
    ('%(mod)s-Left',  "Select the client to the left",
        lambda k: Tag('sel').select('left')),
    ('%(mod)s-Right', "Select the client to the right",
        lambda k: Tag('sel').select('right')),
    ('%(mod)s-Up',    "Select the client above",
        lambda k: Tag('sel').select('up')),
    ('%(mod)s-Down',  "Select the client below",
        lambda k: Tag('sel').select('down')),

    "Moving clients around",
    ('%(mod)s-Shift-Left',  "Move selected client to the left",
        lambda k: Tag('sel').send(Client('sel'), 'left')),
    ('%(mod)s-Shift-Right', "Move selected client to the right",
        lambda k: Tag('sel').send(Client('sel'), 'right')),
    ('%(mod)s-Shift-Up',    "Move selected client up",
        lambda k: Tag('sel').send(Client('sel'), 'up')),
    ('%(mod)s-Shift-Down',  "Move selected client down",
        lambda k: Tag('sel').send(Client('sel'), 'down')),
))

if not call('pidof', 'trayer'):
    trayer = 'trayer', '--expand', 'true', '--widthtype', 'request', \
        '--height', '5', '--transparent', 'true', '--alpha', '255', \
        '--edge', 'bottom', '--align', 'right'
    call(*trayer, background=True, preexec_fn=time.sleep(1))

print "Configuration loaded"

# vim:se sts=4 sw=4 et:
