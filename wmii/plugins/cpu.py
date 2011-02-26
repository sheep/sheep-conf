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

print_cpu_freq = 0
print_cpu_load = 1
print_cpu_temp = 0

sensor = "THM"
path_temp = "/proc/acpi/thermal_zone/%s/temperature" % sensor
path_cpuinfo = '/proc/cpuinfo'
path_stats = '/proc/stat'

if print_cpu_freq:
  re_cpu = re.compile(r'^cpu MHz\s*:\s*(?P<mhz>\d+).*$')
if print_cpu_load:
  re_stats = re.compile(r'^cpu(?P<cpu>\d+) (?P<user>\d+) (?P<system>\d+) (?P<nice>\d+) (?P<idle>\d+) (?P<iowait>\d+).*$')
if print_cpu_temp:
  re_temp = re.compile(r'^temperature:\s*(?P<temp>\d+)\s+(?P<unit>.*)$')

old_stats = dict(user = 0, system = 0, nice = 0, idle = 0)

def cpu_stat_init():
  stat_vals = parse_file(path_stats, re_stats)
  # convert values to int's
  stat_vals = dict([(k, [int(w) for w in v]) for k, v in stat_vals.items()])
  old_stats.update(stat_vals)

def cpu_stat_next():
  try:
    stat_vals = parse_file(path_stats, re_stats)
    stat_vals = dict([(k, [int(w) for w in v]) for k, v in stat_vals.items()])
    total = list()
    for i in stat_vals['cpu']:
      dtotal = \
          stat_vals['user'][i]   - old_stats['user'][i]   + \
          stat_vals['system'][i] - old_stats['system'][i] + \
          stat_vals['nice'][i]   - old_stats['nice'][i]   + \
          stat_vals['idle'][i]   - old_stats['idle'][i]   + \
          stat_vals['iowait'][i] - old_stats['iowait'][i]
      total.append( \
        '%02d%%' % (99 - ((stat_vals['idle'][i] - old_stats['idle'][i]) * 99 / dtotal)))
    old_stats.update(stat_vals)
    return ','.join(total)
  except Exception, e:
    cpu = 'error: %s,' % e

def mhz_to_ghz(v):
  return "%.1f" % (int(v) / 1000.0)

def cpu_freq_get():
  cpu_vals = parse_file(path_cpuinfo, re_cpu)
  cpu = '--'
  try:
    cpu = '/'.join(map(mhz_to_ghz, cpu_vals['mhz']))
  except Exception, e:
    cpu = 'error: %s,' % e
  return cpu

def cpu_temp_get():
  temp_vals = parse_file(path_temp, re_temp)
  temp = '--'
  try:
    temp = '%02d%s' % (int(temp_vals['temp'][0]), temp_vals['unit'][0])
  except Exception, e:
    temp = 'error: %s,' % e
  return temp

def update(self):
  cpu = load = temp = ''

  try:
      if print_cpu_freq:
          cpu = " %s GHz" % cpu_freq_get()
      if print_cpu_load:
          load = " (%s)" % cpu_stat_next()
      if print_cpu_temp:
          temp = " [%s]" % cpu_temp_get()

      return wmii.cache['normcolors'], "cpu:%s%s%s" % (cpu, load, temp)
  except Exception, e:
      return wmii.cache['normcolors'], "cpu_error: %s" % e


if print_cpu_load:
  cpu_stat_init()

if __name__ != "__main__":
  monitor = defmonitor(update, name='cpu', interval=2)
else:
  import time
  while 1:
    time.sleep(1)
    print cpu_stat_next()
