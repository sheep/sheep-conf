import re
import os

if __name__ != "__main__":
  import pygmi
  from pygmi import *
else:
  import sys
  sys.path.append("..")

from utils import parse_file

path_load = '/proc/loadavg'
re_load = re.compile(r'^(?P<load>([0-9.]+ ){2}[0-9.]+)')

def get_load():
  a = parse_file(path_load, re_load)
  return a['load'][0]

def update(self):
  return wmii.cache['normcolors'], get_load()

if __name__ != "__main__":
  monitor = defmonitor(update, name='load', interval=2)
else:
  print get_load()
