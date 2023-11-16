local awful = require("awful")
require("awful.autofocus")

awful.layout.layouts = {
    awful.layout.suit.floating, -- #TODO add the others interesting layouts
}

local beautiful = require("beautiful")
local bindings = require("bindings")

awful.rules.rules = {
  { 
    rule = { },
    properties = { 
      border_width = beautiful.border_width,
      border_color = beautiful.border_normal,
      focus = awful.client.focus.filter,
      raise = true,
      keys = bindings.tabkeys,
      buttons = bindings.tabmouse,
      screen = awful.screen.preferred,
      placement = awful.placement.no_overlap+awful.placement.no_offscreen
    }
  },

  { 
    rule_any = {

      instance = {
        "DTA",  -- Firefox addon DownThemAll.
        "copyq",  -- Includes session name in class.
        "pinentry",
      },
      
      class = {
        "Arandr",
        "Blueman-manager",
        "Gpick",
        "Kruler",
        "MessageWin",  -- kalarm.
        "Sxiv",
        "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
        "Wpa_gui",
        "veromix",
        "xtightvncviewer"
      },

      name = {
        "Event Tester",  -- xev.
      },

      role = {
        "AlarmWindow",  -- Thunderbird's calendar.
        "ConfigManager",  -- Thunderbird's about:config.
        "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
      }
    
    }, 
    
    properties = { floating = true }
  
  },

  { 
    rule_any = {
      type = { 
        "normal", 
        "dialog" 
      }
    },
    
    properties = { titlebars_enabled = true }
    
  },

}