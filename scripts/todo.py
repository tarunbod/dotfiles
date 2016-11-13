#!/usr/bin/env python3

import os.path, sys, json
from collections import OrderedDict

todo_list = OrderedDict()

file_path = os.path.expanduser('~/.todo_list.json')
if os.path.isfile(file_path):
    with open(file_path, 'r') as todo_list_file:
        todo_list.update(json.load(todo_list_file))

args = sys.argv[1:]

def usage():
    usage = """Usage:
  todo.py add <task>
  todo.py list
  todo.py del <task number>
  todo.py done <task number>"""
    print(usage)
    sys.exit(0)

if len(args) < 1:
    args = ["list"]

task_count = len(todo_list)

if args[0] == "add":
    if len(args) != 2:
        usage()

    name = args[1]
    todo_list[str(task_count + 1)] = {
        "name": name,
        "completed": False
    }
    print("Added " + args[1] + " to todo list")
elif args[0] == "list":
    for i in range(1, task_count + 1):
        task = todo_list[str(i)]
        print("%d) %s (%s)" % (i, task["name"], "✔" if task["completed"] else "╳")) 
elif args[0] == "del":
    if len(args) != 2:
        usage()

    idx = args[1]
    if idx in todo_list:
        del todo_list[idx]
        keys = sorted(todo_list)
        for i in range(0, task_count - 1):
            key = keys[i]
            todo_list[str(i + 1)] = todo_list[key]
            if int(key) >= task_count:
                del todo_list[key]
    else:
        print("Task #%s does not exist" % idx)
elif args[0] == "done":
    if len(args) != 2:
        usage()

    idx = args[1]
    if idx in todo_list:
        todo_list[idx]["completed"] = True
    else:
        print("Task #%s does not exist" % idx)
else:
    usage()

with open(file_path, 'w') as todo_list_file:
    json.dump(todo_list, todo_list_file)
