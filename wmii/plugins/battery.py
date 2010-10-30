import re
import os

#import sys
#sys.stdout.write("debug:\n")

import pygmi
from pygmi import *

# TODO don't create a monitore if there are no batter
# check return of each regexp

battery = 'BAT0'
path_state = "/proc/acpi/battery/%s/state" % battery
path_charge_full = "/sys/class/power_supply/%s/charge_full" % battery

# Simple of output of state (when discharging)
# present:                 yes
reg_present = re.compile(r'present:\s+(yes)\n')
# capacity state:          ok
# charging state:          discharging
reg_charging_state = re.compile(r'\ncharging state:\s+(discharging|charging|charged)\n')
# present rate:            1703 mA
reg_rate = re.compile(r'\npresent rate:\s+(\d+)\smA\n')
# remaining capacity:      4511 mAh
reg_remaining = re.compile(r'\nremaining capacity:\s+(\d+)\smAh\n')
# present voltage:         11837 mV

def read_content(path):
  # TODO Check error (file not found)
  fd = os.open(path, os.O_RDONLY)
  lines = os.read(fd, 200)
  os.close(fd)
  return lines

def update(self):
  lines = read_content(path_state)
  color = wmii.cache['normcolors']
  if reg_present.findall(lines)[0] == "yes":
    full_capacity = int(read_content(path_charge_full)) / 1000
    remain = float(reg_remaining.findall(lines)[0])
    rate = float(reg_rate.findall(lines)[0])
    state = reg_charging_state.findall(lines)[0]
    time = 0.0
    if state == "discharging":
      color = ('#ff2030', color[1], color[2])
      time = remain / rate
    elif state == "charging":
      color = ('#00ff00', color[1], color[2])
      time = (float(full_capacity) - remain) / rate
    elif state == "charged":
      return None
    else:
      return color, "Bat: Error, unknow state '%s'." % state
    h = int(time)
    m = int((time - h) * 60)
    return color, "bat: %d%% (%d:%02d)" % (remain / full_capacity * 100, h, m)
  else:
    return None

monitor = defmonitor(update, name='battery', interval=60)
