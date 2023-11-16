local gears = require("gears")
local awful = require("awful")

local tabs_button_prototype = gears.table.join(
    awful.button(
        {},
        1,
        function(tab)
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
    ),

    awful.button(
        {},
        4,
        function()
            awful.client.focus.byidx(1)
        end
    ),

    awful.button(
        {},
        5,
        function()
            awful.client.focus.byidx(-1)
        end
    ))

return tabs_button_prototype