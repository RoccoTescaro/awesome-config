-- Each desktop (tag) has associated to it its own screen 
-- the screen consists of wallpaper (background) and the programmed widgets (like the bar) 

local beautiful = require("beautiful")
local gears = require("gears")

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

-- call the refresh background function if the screen
-- geometry changes (eg. when you turn the screen 1920x960 -> 960x1920)
screen.connect_signal("property::geometry", refresh_background)

local awful = require("awful")
local dskbutton = require("screen.dskbutton")
local tabbutton = require("screen.tabbutton")
local wibox = require("wibox")
local vars = require("vars")

awful.screen.connect_for_each_screen( function(s)
    refresh_background(s)

    awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])

    s.searchbar = awful.widget.prompt()
    
    s.dsklist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = dskbutton
    }

    s.tablist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = tabbutton
    }

    s.bar = awful.wibar({ position = "bottom", screen = s }) -- #TODO change to left
    s.bar:setup {
        
        layout = wibox.layout.align.horizontal,
        
        { -- left widgets
            layout = wibox.layout.fixed.horizontal,
            
            s.dsklist,
            s.searchbar, -- #TODO make its own bar
        },

        s.tablist, -- Middle widget

        { -- right widgets
            layout = wibox.layout.fixed.horizontal,
            
            vars.kbmap,
            wibox.widget.systray(),
            vars.clock,
        },
    }
end)

