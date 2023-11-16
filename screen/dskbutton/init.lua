local gears = require("gears")
local awful = require("awful")
local vars = require("vars")

local desktops_button_prototype = gears.table.join(
    awful.button{
        modifier = {},
        button   = 1,
        on_press = function(dsk)
            dsk.view_only()
        end
    },

    awful.button{
        modifier = { vars.modkeys.mod },
        button   = 1,
        on_press = function(dsk)
            if client.focus 
            then
                client.focus:move_to_tag(dsk)
            end
        end
    },

    awful.button{
        modifier = {},
        button   = 3,
        on_press = awful.tag.viewtoggle
    },

    awful.button{
        modifier = {},
        button   = 4,
        on_press = function(dsk)
            awful.tag.viewnext(dsk.screen)
        end
    },

    awful.button{
        modifier = {},
        button   = 5,
        on_press = function(dsk)
            awful.tag.viewprev(dsk.screen)
        end
    })

return desktops_button_prototype