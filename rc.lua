pcall(require, "luarocks.loader")

-- ERROR handling
require("errors")

-- THEME setup
local beautiful = require("beautiful")
local gears = require("gears")
beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua") -- #TODO change with the chosen theme

-- GENERAL setup
require("setup")

require("screen")

-- BINDINGS
local bindings = require("bindings")
-- root bindings applies evreywhere ( I like to think it as bindings relative to desktops/tags )
root.buttons(bindings.dskmouse) 
root.keys(bindings.dskkeys)

-- SIGNALS
require("signals")
