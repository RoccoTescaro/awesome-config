local bindings = {}

local gears = require("gears")
local awful = require("awful")

bindings.dskmouse = gears.table.join(
    awful.button{
        modifier    = {},
        button      = 4,
        on_press    = awful.tag.viewnext
    },

    awful.button{
        modifier    = {},
        button      = 4,
        on_press    = awful.tag.viewprev
    })

local vars = require("vars")
local hotkeys_popup = require("awful.hotkeys_popup")
require("awful.hotkeys_popup.keys")

bindings.dskkeys = gears.table.join(
    awful.key{
        modifier    = { vars.modkeys.mod, vars.modkeys.ctrl },
        key         = "h",
        description = "help",
        group       = "awesome",
        on_press    = hotkeys_popup.show_help
    },

    awful.key{
        modifier    = { vars.modkeys.mod, vars.modkeys.ctrl },
        key         = "r",
        description = "refresh",
        group       = "awesome",
        on_press    = awesome.restart
    },

    awful.key{
        modifier    = { vars.modkeys.mod, vars.modkeys.ctrl },
        key         = "q",
        description = "quit",
        group       = "awesome",
        on_press    = awesome.quit
    },

    awful.key{
        modifier    = { vars.modkeys.mod, vars.modkeys.ctrl },
        key         = "Tab",
        description = "next",
        group       = "desktops",
        on_press    = awful.tag.viewnext
    },

    awful.key{
        modifier    = { vars.modkeys.mod, vars.modkeys.ctrl, vars.modkeys.shift },
        key         = "numrow",
        description = "move",
        group       = "desktops",
        on_press    = function(index)
            if client.focus 
            then
                local tag = client.focus.screen.tags[index]
                if tag 
                then
                   client.focus:move_to_tag(tag)
                end
            end
        end
    },

    awful.key{
        modifier    = { vars.modkeys.mod, vars.modkeys.ctrl },
        key         = "numpad",
        description = "select",
        group       = "desktops",
        on_press    = function(index)
            local tag = awful.screen.focused().selected_tag
            if tag 
            then
                tag.layout = tag.layouts[index] or tag.layout
            end
        end
    },

    awful.key{
        modifier    = { vars.modkeys.mod },
        key         = "Tab",
        description = "next",
        group       = "tabs",
        on_press    = function() 
            awful.client.swap.byidx(1)
        end
    },

    awful.key{
        modifier    = { vars.modkeys.mod },
        key         = "Return", -- Enter
        description = "terminal",
        group       = "launcher",
        on_press    = function() 
            awful.spawn(vars.terminal)
        end
    },

    awful.key{
        modifier    = { vars.modkeys.mod },
        key         = "r", 
        description = "prompt",
        group       = "launcher",
        on_press    =  function() 
            awful.screen.focused().searchbar:run()
        end
    })

bindings.tabmouse = gears.table.join(
    awful.button{
        modifier   = {},
        button     = 1,
        on_press   = function(tab)
            tab:emit_signal("request::activate", "mouse_click", {raise = true})
        end
    },

    awful.button{
        modifier   = { vars.modkeys.mod },
        button     = 1,
        on_press   = function(tab)
            tab:emit_signal("request::activate", "mouse_click", {raise = true})
            awful.mouse.client.move(tab)
        end
    },

    awful.button{
        modifier   = { vars.modkeys.mod },
        button     = 3,
        on_press   = function(tab)
            tab:emit_signal("request::activate", "mouse_click", {raise = true})
            awful.mouse.client.resize(tab)
        end
    })

bindings.tabkeys = gears.table.join(
    awful.key{
        modifier    = { vars.modkeys.mod, vars.modkeys.shift },
        key         = "f",
        description = "fullscreen",
        group       = "tabs",
        on_press    = function(tab) 
            tab.fullscreen = not tab.fullscreen
            tab:raise()
        end
    },

    awful.key{
        modifier    = { vars.modkeys.mod, vars.modkeys.shift },
        key         = "c",
        description = "close",
        group       = "tabs",
        on_press    = function(tab) 
            tab:kill()
        end
    })

return bindings