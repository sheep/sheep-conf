import re
import os

import pygmi
from pygmi import *
from utils import parse_file

sensor = "THM"
path_temp = "/proc/acpi/thermal_zone/%s/temperature" % sensor
path_cpuinfo = '/proc/cpuinfo'
path_stats = '/proc/stat'


re_cpu = re.compile(r'^cpu MHz\s*:\s*(?P<mhz>\d+).*$')
re_stats = re.compile(r'^cpu(?P<cpu>\d+) (?P<user>\d+) (?P<system>\d+) (?P<nice>\d+) (?P<idle>\d+).*$')
re_temp = re.compile(r'^temperature:\s*(?P<temp>\d+)\s+(?P<unit>.*)$')

old_stats = dict(user = 0, system = 0, nice = 0, idle = 0)

def cpu_stat_init():
  stat_vals = parse_file(path_stats, re_stats)
  # convert values to int's
  stat_vals = dict([(k, [int(w) for w in v]) for k, v in stat_vals.items()])
  old_stats.update(stat_vals)

def cpu_stat_next():
  stat_vals = parse_file(path_stats, re_stats)
  stat_vals = dict([(k, [int(w) for w in v]) for k, v in stat_vals.items()])
  total = list()
  for i in stat_vals['cpu']:
    dtotal = \
        stat_vals['user'][i]   - old_stats['user'][i]   + \
        stat_vals['system'][i] - old_stats['system'][i] + \
        stat_vals['nice'][i]   - old_stats['nice'][i]   + \
        stat_vals['idle'][i]   - old_stats['idle'][i]
    total.append( \
      '%02d%%' % (100 - ((stat_vals['idle'][i] - old_stats['idle'][i]) * 100 / dtotal)))
  old_stats.update(stat_vals)
  return ','.join(total)


def mhz_to_ghz(v):
  return "%.1f" % (int(v) / 1000.0)

def update(self):
  cpu_vals = parse_file(path_cpuinfo, re_cpu)
  temp_vals = parse_file(path_temp, re_temp)

  cpu = '--'
  try:
    cpu = '/'.join(map(mhz_to_ghz, cpu_vals['mhz']))
  except Exception, e:
    cpu = 'error: %s,' % e

  load = '--'
  try:
    load = cpu_stat_next()
  except Exception, e:
    load = 'error: %s,' % e

  temp = '--'
  try:
    temp = '%02d%s' % (int(temp_vals['temp'][0]), temp_vals['unit'][0])
  except Exception, e:
    temp = 'error: %s,' % e

  return wmii.cache['normcolors'], "cpu: %s GHz (%s) [%s]" % (cpu, load, temp)
  #return wmii.cache['normcolors'], "cpu: %s%% [%s]" % (load, temp)


cpu_stat_init()
monitor = defmonitor(update, name='cpu', interval=1)
