#!/usr/bin/env python3

from mpd import MPDClient
import sys

cmds = ["currentsong", "nextsong", "next", "previous", "pause", "play", "status"]
usage_str = "Usage:\n"
for cmd in cmds:
    usage_str += "mpdlib.py %s\n" % cmd

if len(sys.argv) < 2 or sys.argv[1] not in cmds:
    print(usage_str)
    sys.exit(0)

cmd = sys.argv[1]
def show(str):
    to_print = ""
    if len(sys.argv) == 3 and sys.argv[2] == '--front-space':
        to_print += " "
    to_print += str
    print(to_print)

client = MPDClient()
try:
    client.connect("localhost", 6600)
except ConnectionRefusedError as e: 
    print('Server probably not running', file=sys.stderr)
    sys.exit(0)

if cmd == cmds[0]: # current song info
    song = client.currentsong()
    print(song['artist'] + ' - ' + song['title'])
elif cmd == cmds[1]: # get next song info
    status = client.status()
    song = client.playlistid(status['nextsongid'])[0]
    print(song['artist'] + ' - ' + song['title'])
elif cmd == cmds[2]: # next
    client.next()
elif cmd == cmds[3]: # previous
    client.previous()
elif cmd == cmds[4]: # pause
    client.pause(1)
elif cmd == cmds[5]: # play
    client.pause(0)
elif cmd == cmds[6]: # status cmd
    status = client.status()
    song = client.currentsong()
    char = '*' if status['state'] == 'play' else '-'
    print(song['artist'] + ' - ' + song['title'] + ' (' + char + ')')
