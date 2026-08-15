sbar = require("sketchybar")

sbar.begin_config()
local theme = require("theme")
require("bar")
require("default")
require("items")
theme.watch()
sbar.end_config()

sbar.event_loop()
