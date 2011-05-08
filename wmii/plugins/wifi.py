import pygmi
from pygmi import *
from utils import colors

# TODO check if exist:
import wpactrl
import os
import re

interface = '/var/run/wpa_supplicant/wlan0'
wpa = None
monitor = None

# Get as reponse to STATUS
#   bssid=c0:d0:44:41:ca:4b
#   ssid=SKY51786
#   id=0
#   mode=station
#   pairwise_cipher=TKIP
#   group_cipher=TKIP
#   key_mgmt=WPA-PSK
#   wpa_state=COMPLETED
#   ip_address=192.168.0.8

re_wpa_state = re.compile(r'wpa_state=(.+)\n')
re_ip_address = re.compile(r'ip_address=[0-9\.]+\n')
#re_ssid = re.compile(r'ssid=(.*)\n')

def update(self):
  global wpa

  try:
    color = colors.redcolors
    if not wpa:
      wpa = wpactrl.WPACtrl(interface)
    # check: wpa.request('PING') => 'PONG\n'
    wpa_status = wpa.request('STATUS')
    state = re_wpa_state.findall(wpa_status)[0]
    if state == "COMPLETED":
      ip = ""
      res_ip = re_ip_address.findall(wpa_status)
      if len(res_ip) > 0:
        ip = res_ip[0]
      if len(ip) > 6:
        state = "OK"
        color = wmii.cache['normcolors']
      else:
        state = "no IP"

    return color, 'wifi: %s' % state

  except wpactrl.error, error:
    #print 'Error: ', error
    wpa = None

  return None

monitor = defmonitor(update, name='5_wifi', interval=10)
