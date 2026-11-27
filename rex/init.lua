-- Splits: ] side by side, [ stacked
rex.bind("ctrl+b>]", "pane.split", { direction = "right" })
rex.bind("ctrl+b>[", "pane.split", { direction = "down" })
rex.bind("ctrl+b>x", "pane.close")
rex.bind("ctrl+b>z", "pane.zoom")
rex.bind("ctrl+b>o", "pane.focus_next")
rex.bind("ctrl+b>left", "pane.focus.left")
rex.bind("ctrl+b>right", "pane.focus.right")
rex.bind("ctrl+b>up", "pane.focus.up")
rex.bind("ctrl+b>down", "pane.focus.down")

rex.bind("ctrl+b>c", "client.tab.new")

-- base-index 1: prefix+1 selects the first tab
for i = 1, 9 do
  rex.bind("ctrl+b>" .. i, "client.tab.goto", { index = i })
end

-- Sessions
rex.bind("ctrl+b>q", "session.previous")
rex.bind("ctrl+b>w", "session.switch")
rex.bind("ctrl+b>e", "session.next")
rex.bind("ctrl+b>n", "session.new.on_host")
rex.bind("ctrl+b>m", "client.host.switch")

-- Press ctrl+b twice to send ctrl+b to the terminal
rex.bind("ctrl+b>ctrl+b", "pane.send_key", { key = "ctrl+b" })
