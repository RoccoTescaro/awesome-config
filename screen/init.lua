-- Each desktop (tag) has associated to it its own screen 
-- the screen consists of wallpaper (background) and the programmed widgets (like the bar) 

local beautiful = require("beautiful")
local gears = require("gears")
local dpi = require("beautiful.xresources").apply_dpi   
local bar_height = dpi(56) -- (has a bottom margin included) 

local function refresh_background(screen)
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen -- ? --
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(screen)
        end
        gears.wallpaper.maximized(wallpaper, screen, true)
    end
end

local function refresh_workarea(screen) -- doesn't seem to work
    local wa = screen.geometry
    wa.y = wa.y + bar_height 
    wa.height = wa.height - bar_height
    screen.workarea = wa
end

local function on_geometry_change(screen)
    refresh_background(screen)
    refresh_workarea(screen)
end

-- call the refresh background function if the screen
-- geometry changes (eg. when you turn the screen 1920x960 -> 960x1920)
screen.connect_signal("property::geometry", on_geometry_change)

local awful = require("awful")
local dskbutton = require("screen.dskbutton")
local tabbutton = require("screen.tabbutton")
local wibox = require("wibox")
local vars = require("vars")

awful.screen.connect_for_each_screen( function(s)
    on_geometry_change(s)

    s.padding = {
        left = dpi(3),
        right = dpi(3),
        top = dpi(3),
        bottom = dpi(3)
    }

    awful.tag({ "1", "2", "3" }, s, awful.layout.layouts[1])

    s.searchbar = awful.widget.prompt()
    
    s.dsklist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        style = {
            shape = gears.shape.rounded_rect,--function(cr, width, height) gears.shape.rounded_bar(cr, dpi(96), dpi(4)) end
        },
        layout = {
            spacing = dpi(12),
            layout = wibox.layout.fixed.horizontal
        },
        buttons = dskbutton,
        --style.spacing = dpi(16)
        --layout = wibox.layout.align.horizontal
    }

    --[[
    s.tablist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = tabbutton
    }
    --]]

    s.bar = awful.wibar({
        position = "bottom",
        screen = s,
        bg = beautiful.bg_normal .. "00",
        ontop = true,
        height = bar_height,
        visible = false,
        })


    s.bar:setup {
        
        layout = wibox.layout.align.horizontal,

        nil,
        {
            widget = wibox.container.margin,
            left = dpi(14),
            bottom = dpi(14),
            right = dpi(14),

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
                    opacity = 0.8,
        
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
                    opacity = 0.8,
        
                    vars.clock,
                },
            }
        },
        nil

    }
    s.bar_trigger =  wibox({ bg = "#00000000", opacity = 0, ontop = true, visible = true })
    s.bar_timer = gears.timer({ timeout = 2})

    s.bar_trigger:geometry({ y = s.workarea.height-dpi(6), height = dpi(6), width = s.workarea.width })
    s.bar_timer:connect_signal("timeout", function() s.bar.visible = false; s.bar_timer:stop() end )
    s.bar_trigger:connect_signal("mouse::enter", function() s.bar.visible = true end)
    s.bar:connect_signal("mouse::enter", function() if s.bar_timer.started then s.bar_timer:stop() end end)
    s.bar:connect_signal("mouse::leave", function() s.bar_timer:again() end)

    -- remove the strut of the bar, it seems the only way the workare gets under it
    s.bar:struts{ left = 0, right = 0, bottom = 0, top = 0 }

    s.workarea = {
        x = s.geometry.x,
        y = s.geometry.y,
        width = s.geometry.width,
        height = s.geometry.height
    }
end)
