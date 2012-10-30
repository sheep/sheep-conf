import os
import time

import pygmi
from pygmi import *
from wmiirc import tags

wmii.rules = (
    (ur'(Firefox|Shiretoko|Namoroka)', dict(tags='web')),
    (ur'(Google Chrome|Chromium)', dict(tags='web')),
    (ur'Opera', dict(tags='web')),
    (ur'(Pidgin|XChat)', dict(tags='chat')),
    (ur'Icedove', dict(tags='mail')),
)

wmii.colrules = (
    # With xchat/pidgin
    ('chat', '75+25'),
    ('.*', '50+50'),
)

terminal = 'wmiir', 'setsid', 'urxvtc'
browser = 'wmiir', 'setsid', 'firefox'
chrome = 'wmiir', 'setsid', 'chromium'

keys.bind('main', (
    "Running programs",
    ('%(mod)s-x', "Launch a terminal",
        lambda k: call(*terminal, background=True)),
    ('%(mod)s-F5', "Launch Firefox",
        lambda k: call(*browser, background=True)),
    ('%(mod)s-F6', "Launch Google-Chrome",
        lambda k: call(*chrome, background=True)),

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
    ('%(mod)s-%(web_tag)s', "Move to view 'web'",
        lambda k: tags.select("web")),
    ('%(mod)s-%(chat_tag)s', "Move to view 'chat'",
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

print "Configuration loaded"

# vim:se sts=4 sw=4 et:
