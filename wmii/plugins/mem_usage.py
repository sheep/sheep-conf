import re
import os

if __name__ != "__main__":
  import pygmi
  from pygmi import *
  from utils import parse_file
else:
  import sys
  sys.path.append("..")
  from utils import parse_file

path_meminfo = '/proc/meminfo'

re_all = re.compile(r'^(MemTotal:\s*(?P<total>\d+) kB|MemFree:\s*(?P<free>\d+) kB|Buffers:\s*(?P<buffers>\d+) kB|Cached:\s*(?P<cached>\d+) kB|SwapTotal:\s*(?P<swap_total>\d+) kB|SwapFree:\s*(?P<swap_free>\d+) kB)\n')

def get_int(array):
  for i in array:
    if i != None:
      return float(i)
  return 0

def get_mem_stat():
  stat = parse_file(path_meminfo, re_all)
  mem = dict([(k, get_int(v)) for k, v in stat.items()])
  mem_free = mem['free'] + mem['buffers'] + mem['cached']
  mem_used = mem['total'] - mem_free
  mem_usage = mem_used / mem['total'] * 100.0

  if mem['swap_total'] == 0:
    swap_usage = 0
  else:
    swap_usage = 100 - (mem['swap_free'] / mem['swap_total'] * 100.0)

  s = 'ram: %.2fG (%02d%%)' % (mem_used / 2 ** 20, mem_usage)
  if swap_usage > 0:
    s += ' swap: %02d%%' % (swap_usage)
  return s

def update(self):
  return wmii.cache['normcolors'], get_mem_stat()

if __name__ != "__main__":
  monitor = defmonitor(update, name='h_mem', interval=10)
else:
  print get_mem_stat()
