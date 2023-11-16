local gears = require("gears")
local awful = require("awful")
local vars = require("vars")

local desktops_button_prototype = gears.table.join(
    awful.button(
        {},
        1,
        function(dsk)
            dsk:view_only()
        end
    ),

    awful.button(
        { vars.modkeys.mod },
        1,
        function(dsk)
            if client.focus 
            then
                client.focus:move_to_tag(dsk)
            end
        end
    ),

    awful.button(
        {},
        3,
        awful.tag.viewtoggle
    ),

    awful.button(
        {},
        4,
        function(dsk)
            awful.tag.viewnext(dsk.screen)
        end
    ),

    awful.button(
        {},
        5,
        function(dsk)
            awful.tag.viewprev(dsk.screen)
        end
    ))

return desktops_button_prototype