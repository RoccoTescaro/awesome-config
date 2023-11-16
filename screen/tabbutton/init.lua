local gears = require("gears")
local awful = require("awful")

local tabs_button_prototype = gears.table.join(
    awful.button{
        mod     = {},
        _button = 1,
        press   = function(tab)
            if tab == client.focus 
            then
                tab.minimized = true
            else
                tab:emit_signal(
                    "request::activate",
                    "tasklist",
                    { raise = true }
                )
            end
        end
    },

    awful.button{
        mod     = {},
        _button = 4,
        press   = function()
            awful.client.focus.byidx(1)
        end
    },

    awful.button{
        mod     = {},
        _button = 5,
        press   = function()
            awful.client.focus.byidx(-1)
        end
    })

return tabs_button_prototype