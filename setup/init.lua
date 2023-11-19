-- THEME setup
local beautiful = require("beautiful")
local gears = require("gears")
-- setup some beautiful package variables that are consistent in all widgets created
beautiful.init(gears.filesystem.get_configuration_dir() .. "theme/theme.lua") 

-- setup awful the general structure of the whole system
-- awful layouts applies to tabs, allows shortcut to organize them ecc.
-- awful rules applies to tabs too, trought "manage" signal, define titlebar
-- applies some beautiful setup set by the theme ecc.

-- LAYOUT setup
local awful = require("awful")
require("awful.autofocus")
awful.util.spawn("picom") -- allow trasparency

awful.layout.layouts = {
    awful.layout.suit.tile, -- #TODO add the others interesting layouts
}

-- RULES setup
local bindings = require("bindings")

awful.rules.rules = {
  { 
    rule = { },
    properties = { 
      placement = awful.placement.no_overlap+awful.placement.no_offscreen,
      focus = awful.client.focus.filter, -- ? --
      dockable = true,
      screen = awful.screen.preferred,
      border_width = beautiful.border_width,
      border_color = beautiful.border_normal,
      opacity = 1,
      --raise = true, -- ? --
      keys = bindings.tabkeys,
      buttons = bindings.tabmouse,
      maximized = false, -- important for firefox
      floating = false 
    }
  },
}

-- since as we said awful is sort of the global structure there is no need to return anything
-- evreything we might need will be set it up in awful i guess #TODO check

