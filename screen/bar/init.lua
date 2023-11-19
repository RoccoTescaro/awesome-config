local dpi = require("beautiful.xresources").apply_dpi
local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")

local left_widget = wibox.container.background()
left_widget.bg = beautiful.palette.d_default_c
left_widget.shape = gears.shape.rounded_bar
left_widget.shape_border_width = beautiful.border_width
left_widget.shape_border_color = beautiful.palette.dd_default_c
left_widget.forced_width = dpi(160)
left_widget.opacity = 0.9
left_widget.widget = {
    layout = wibox.layout.fixed.horizontal,
    wibox.widget.systray()
}

local right_widget = wibox.container.background()
right_widget.bg = beautiful.palette.d_default_c
right_widget.shape = gears.shape.rounded_bar
right_widget.shape_border_width = beautiful.border_width
right_widget.shape_border_color = beautiful.palette.dd_default_c
right_widget.forced_width = dpi(160)
right_widget.opacity = 0.9
right_widget.widget = {
    layout = wibox.layout.fixed.horizontal,
    wibox.widget.systray()
}

local bar = wibox()
bar.ontop = true
bar.type = "desktop"
bar:struts({left = 0, right = 0, bottom = 0, top = 0})

bar.widget = 
{
    widget = wibox.container.margin,
    left = dpi(14),
    right = dpi(14),
    bottom = dpi(14),

    {
        layout = wibox.layout.align.horizontal,
        left_widget,
        nil,
        right_widget
    }
}



--[[bar.position = "bottom"
bar.bg = "#00000000" -- transparent
bar.ontop = true
bar.height = dpi(64)

bar:setup{
    layout = 
    widget = wibox.container.margin,
    margins = dpi(14),
        {
            layout = wibox.layout.align.horizontal,

            { -- left widgets
                --layout = wibox.layout.fixed.horizontal, 
                bg = beautiful.palette.d_default_c,
                widget = wibox.container.background,
                shape = gears.shape.rounded_bar,
                shape_border_width = beautiful.border_width,
                shape_border_color = beautiful.palette.dd_default_c,
                forced_width = dpi(160),
    
                {
                    layout = wibox.layout.fixed.horizontal, 
    
                    vars.kbmap,
                    wibox.widget.systray(),
                    s.searchbar, -- #TODO make its own bar
                }
            },
            
            s.dsklist,
            --s.tablist, -- Middle widget
    
            { -- right widgets
                --layout = wibox.layout.fixed.horizontal,
                bg = beautiful.palette.d_default_c,
                widget = wibox.container.background,
                shape = gears.shape.rounded_bar,
                shape_border_width = beautiful.border_width,
                shape_border_color = beautiful.palette.dd_default_c,
                forced_width = dpi(160),
    
                vars.clock,
            },
        }
}--]]

return bar