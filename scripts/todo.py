#!/usr/bin/env python3

import os.path, sys, json
from collections import OrderedDict

todo_list = OrderedDict()

file_path = os.path.expanduser('~/.todo_list.json')
if os.path.isfile(file_path):
    with open(file_path, 'r') as todo_list_file:
        todo_list.update(json.load(todo_list_file))


usage = """Usage:
  todo.py add <task>
  todo.py list
  todo.py del <task number>
  todo.py done <task number>"""

if len(sys.argv) < 2:
    print(usage)
    sys.exit(0)

if sys.argv[1] == "add":
    todo_list[sys.argv[2]] = False
    print("Added " + sys.argv[2] + " to todo list")
elif sys.argv[1] == "list":
    for idx, pair in enumerate(todo_list.items()):
        print('%2d. %s (%s)' % (idx, pair[0], '✔' if pair[1] == True else '╳'))
elif sys.argv[1] == "del":
    print('to be implemented')

with open(file_path, 'w') as todo_list_file:
    json.dump(todo_list, todo_list_file)
