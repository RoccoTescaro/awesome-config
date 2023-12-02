-- apply rules to tab
local awful = require("awful")
local gears = require("gears")
local dpi = require("beautiful.xresources").apply_dpi

client.connect_signal("manage", 
    function(c)
        c.shape = function(cr, w, h) gears.shape.rounded_rect(cr, w, h, dpi(12)) end

        if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position 
        then
            awful.placement.no_offscreen(c)
        end
    end)
    

local gears = require("gears")
local wibox = require("wibox")

client.connect_signal("request::titlebars", 
    function(c)
        local buttons = gears.table.join( -- #TODO refactor
            awful.button({ }, 1, function()
                c:emit_signal("request::activate", "titlebar", {raise = true})
                awful.mouse.client.move(c)
            end),
            awful.button({ }, 3, function()
                c:emit_signal("request::activate", "titlebar", {raise = true})
                awful.mouse.client.resize(c)
            end)
        )
    
        awful.titlebar(c) : setup {
            { -- Left
                awful.titlebar.widget.iconwidget(c),
                buttons = buttons,
                layout  = wibox.layout.fixed.horizontal
            },
            { -- Middle
                { -- Title
                    align  = "center",
                    widget = awful.titlebar.widget.titlewidget(c)
                },
                buttons = buttons,
                layout  = wibox.layout.flex.horizontal
            },
            { -- Right
                awful.titlebar.widget.floatingbutton (c),
                awful.titlebar.widget.maximizedbutton(c),
                awful.titlebar.widget.stickybutton   (c),
                awful.titlebar.widget.ontopbutton    (c),
                awful.titlebar.widget.closebutton    (c),
                layout = wibox.layout.fixed.horizontal()
            },
            layout = wibox.layout.align.horizontal
        }
    end)

client.connect_signal("mouse::enter", 
    function(c)
        c:emit_signal("request::activate", "mouse_enter", {raise = false})
    end)

local beautiful = require("beautiful")

client.connect_signal("focus", function(c) 
    c.border_color = beautiful.border_focus 
end)
client.connect_signal("unfocus", function(c) 
    c.border_color = beautiful.border_normal 
end)