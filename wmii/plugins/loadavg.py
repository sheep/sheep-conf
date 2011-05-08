import os

if __name__ != "__main__":
  import pygmi
  from pygmi import *

def get_load():
  return "%.2f %.2f %.2f" % os.getloadavg()

def update(self):
  return wmii.cache['normcolors'], get_load()

if __name__ != "__main__":
  monitor = defmonitor(update, name='load', interval=2)
else:
  print get_load()
