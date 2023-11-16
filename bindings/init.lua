local bindings = {}

local gears = require("gears")
local awful = require("awful")

bindings.dskmouse = gears.table.join(
  awful.button(
    {},
    4,
    awful.tag.viewnext
  ),

  awful.button(
    {},
    4,
    awful.tag.viewprev
  ))

local vars = require("vars")
local hotkeys_popup = require("awful.hotkeys_popup")
require("awful.hotkeys_popup.keys")

bindings.dskkeys = gears.table.join(
  awful.key(
    { vars.modkeys.mod, vars.modkeys.ctrl },
    "h",
    hotkeys_popup.show_help,
    { description = "help", group = "awesome" }
  ),

  awful.key(
    { vars.modkeys.mod, vars.modkeys.ctrl },
    "r",
    awesome.restart,
    { description = "refresh", group = "awesome" }
  ),

  awful.key(
    { vars.modkeys.mod, vars.modkeys.ctrl },
    "q",
    awesome.quit,
    { description = "quit", group = "awesome" }
  ),

  awful.key(
    { vars.modkeys.mod, vars.modkeys.ctrl },
    "Tab",
    awful.tag.viewnext,
    { description = "next", group = "desktops" }
  ),

  awful.key( -- #TODO check if works DOESN'T see original rc.lua
    { vars.modkeys.mod, vars.modkeys.ctrl, vars.modkeys.shift },
    "numrow",
    function(index)
      if client.focus
      then
        local tag = client.focus.screen.tags[index]
        if tag
        then
          client.focus:move_to_tag(tag)
        end
      end
    end,
    { description = "move", group = "desktops" }
  ),

  awful.key( -- #TODO check if works
    { vars.modkeys.mod, vars.modkeys.ctrl },
    "numpad",
    function(index)
      local tag = awful.screen.focused().selected_tag
      if tag
      then
        tag.layout = tag.layouts[index] or tag.layout
      end
    end,
    { description = "select", group = "desktops" }
  ),

  awful.key(
    { vars.modkeys.mod },
    "Tab",
    function() awful.client.swap.byidx(1) end,
    { description = "next", group = "tabs" }
  ),

  awful.key(
    { vars.modkeys.mod },
    "r",
    function() awful.screen.focused().searchbar:run() end,
    { description = "prompt", group = "launcher" }
  ),

  awful.key(
    { vars.modkeys.mod },
    "Return", -- Enter
    function() awful.spawn(vars.terminal) end,
    { description = "terminal", group = "launcher" }
  ))

bindings.tabmouse = gears.table.join(
  awful.button(
    {},
    1,
    function(tab)
      tab:emit_signal("request::activate", "mouse_click", { raise = true })
    end
  ),

  awful.button(
    { vars.modkeys.mod },
    1,
    function(tab)
      tab:emit_signal("request::activate", "mouse_click", { raise = true })
      awful.mouse.client.move(tab)
    end
  ),

  awful.button(
    { vars.modkeys.mod },
    3,
    function(tab)
      tab:emit_signal("request::activate", "mouse_click", { raise = true })
      awful.mouse.client.resize(tab)
    end
  ))

bindings.tabkeys = gears.table.join(
  awful.key(
    { vars.modkeys.mod, vars.modkeys.shift },
    "f",
    function(tab) 
      tab.fullscreen = not tab.fullscreen
      tab:raise()
    end,
    { description = "fullscreen", group = "tabs" }
  ),

  awful.key(
    { vars.modkeys.mod, vars.modkeys.shift },
    "c",
    function(tab) 
      tab:kill()
    end,
    { description = "close", group = "tabs" }
  ))

return bindings
