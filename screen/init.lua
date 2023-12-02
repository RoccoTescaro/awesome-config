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
-- geometry changes (eg. when you turn the screen 1920 x 960 -> 960 x 1920)
screen.connect_signal("property::geometry", on_geometry_change)

local awful = require("awful")
local dskbutton = require("screen.dskbutton")
local tabbutton = require("screen.tabbutton")
local wibox = require("wibox")
local vars = require("vars")


-- tested for one screen only
awful.screen.connect_for_each_screen( function(s)
    on_geometry_change(s)

    s.padding = {
        left = dpi(3),
        right = dpi(3),
        top = dpi(3),
        bottom = dpi(3)
    }
    
    awful.tag({ "", "", "", "", "" }, s, awful.layout.layouts[1]) --#TODO make dinamic

    s.searchbar = awful.widget.prompt()
    
    local dsks = require("bar")

    s.dsklist = dsks.new(
    {
        screen = s,
        taglist = { buttons = dskbutton },
        tasklist = { buttons = tabbutton }
    })

    s.bar = awful.wibar({
        position = "bottom",
        screen = s,
        bg = "#ffffff00",
        ontop = true,
        height = bar_height,
        visible = false,
        --input_passthrough = true,
        })


    s.bar:setup {
        
        layout = wibox.layout.align.horizontal,

        nil,
        {
            widget = wibox.container.margin,
            left = dpi(16),
            bottom = dpi(16),
            right = dpi(16),

            {
                layout = wibox.layout.align.horizontal,

                { -- left widgets
                    --layout = wibox.layout.fixed.horizontal, 
                    bg = beautiful.bg_normal,
                    widget = wibox.container.background,
                    shape = gears.shape.rounded_bar,
                    shape_border_width = dpi(1),
                    shape_border_color = beautiful.border_focus,
                    --opacity = 0.96,
                    {
                        widget = wibox.container.constraint,
                        strategy = 'exact',
                        width = dpi(160),
                        {
                            left = dpi(3),
                            right = dpi(3),
                            top = dpi(6),
                            bottom = dpi(6),
                            widget = wibox.container.margin, 
                            {
                                layout = wibox.layout.align.horizontal, 
                                
                                {
                                    widget = wibox.container.margin,
                                    left = dpi(3),
                                    right = dpi(3),
                                    {
                                        widget = wibox.container.background,
                                        bg =  beautiful.bg_systray,
                                        shape = gears.shape.rounded_bar,
                                        vars.kbmap,
                                    }
                                },
                                {
                                    widget = wibox.container.margin,
                                    left = dpi(3),
                                    right = dpi(3),
                                    {
                                        widget = wibox.container.constraint,
                                        strategy = 'max',
                                        width = dpi(104),
                                        {
                                            widget = wibox.container.background,
                                            bg =  beautiful.bg_systray,
                                            shape = gears.shape.rounded_bar,
                                            {
                                                widget = wibox.container.place,
                                                wibox.widget.systray(),
                                            }
                                        }
                                    }
                                },                                            
                                {
                                    widget = wibox.container.margin,
                                    left = dpi(3),
                                    right = dpi(3),
                                    {
                                        
                                        widget = wibox.container.background,
                                        bg =  beautiful.bg_systray,
                                        shape = gears.shape.rounded_bar,
                                        s.searchbar, -- #TODO make its own bar
                                    }
                                }
                            }   
                        }
                    }
                },
                {
                    widget = wibox.container.place,
                    {
                        bg = beautiful.bg_normal,
                        widget = wibox.container.background,
                        shape = gears.shape.rounded_bar,
                        shape_border_width = dpi(1),
                        shape_border_color = beautiful.border_focus,
                        {
                            left = dpi(3),
                            right = dpi(3),
                            top = dpi(6),
                            bottom = dpi(6),
                            widget = wibox.container.margin,
                            s.dsklist,
                        }
                    }
                },
                { -- right widgets
                    --layout = wibox.layout.fixed.horizontal,
                    bg = beautiful.bg_normal,
                    widget = wibox.container.background,
                    shape = gears.shape.rounded_bar,
                    shape_border_width = dpi(1),
                    shape_border_color = beautiful.border_focus,
                    forced_width = dpi(160),
                    opacity = 0.96,
        
                    vars.clock,
                },
            }
        },
        nil

    }
    s.bar_trigger =  wibox({ bg = "#00000000", opacity = 0, ontop = true, visible = true })
    s.bar_timer = gears.timer({ timeout = 2})

    s.bar_trigger:geometry({ y = s.workarea.height-dpi(8), height = dpi(8), width = s.workarea.width })
    s.bar_timer:connect_signal("timeout", function() s.bar.visible = false; s.bar_timer:stop() end )
    s.bar_trigger:connect_signal("mouse::enter", 
    function() 
        s.bar.visible = true
        -- remove the strut of the bar, it seems the only way the workarea gets under it
        s.bar:struts{ left = 0, right = 0, bottom = 0, top = 0 } 
    end)
    s.bar:connect_signal("mouse::enter", function() if s.bar_timer.started then s.bar_timer:stop() end end)
    s.bar:connect_signal("mouse::leave", function() s.bar_timer:again() end)
    --]]
end)
