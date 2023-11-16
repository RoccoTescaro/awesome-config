-- ERROR handling

local naughty = require("naughty")

-- setup notifications esthetic 
-- would be better to put this in theme.lua but we cannot do it becouse 
-- startup error handling is done before loading the theme 
-- loading it before would omit the error checking to theme.lua file
local dpi = require("beautiful.xresources").apply_dpi
local gears = require("gears")

naughty.config.padding = dpi(16)
naughty.config.spacing = dpi(8)

--[[ low notifications -- for some reason doesn't load !!! #TODO fix
naughty.config.presets.low.timeout = 5
naughty.config.presets.low.hover_timeout = 0
naughty.config.presets.low.max_width = dpi(544)
naughty.config.presets.low.font = "sans 8"
naughty.config.presets.low.fg = "#FFFFFF"
naughty.config.presets.low.bg = "#EBC72888"
naughty.config.presets.low.border_width = dpi(2)
naughty.config.presets.low.border_color = "#F1D96D"
naughty.config.presets.low.shape = function(cr, w, h) gears.shape.rounded_rect(cr, w, h, dpi(6)) end
naughty.config.presets.low.margin = dpi(8)
--]]

-- normal notifications
naughty.config.presets.normal.timeout = 3
naughty.config.presets.normal.hover_timeout = 0
naughty.config.presets.normal.max_width = dpi(544)
naughty.config.presets.normal.font = "sans 8"
naughty.config.presets.normal.fg = "#FFFFFF"
naughty.config.presets.normal.bg = "#485B7088"
naughty.config.presets.normal.border_width = dpi(2)
naughty.config.presets.normal.border_color = "#879BB0"
naughty.config.presets.normal.shape = function(cr, w, h) gears.shape.rounded_rect(cr, w, h, dpi(6)) end
naughty.config.presets.normal.margin = dpi(8)

-- critical notifications
naughty.config.presets.critical.timeout = 5
naughty.config.presets.critical.hover_timeout = 3
naughty.config.presets.critical.max_width = dpi(544)
naughty.config.presets.critical.font = "sans 8"
naughty.config.presets.critical.fg = "#FFFFFF"
naughty.config.presets.critical.bg = "#BF2B3388"
naughty.config.presets.critical.border_width = dpi(2)
naughty.config.presets.critical.border_color = "#CF4E53"
naughty.config.presets.critical.shape = function(cr, w, h) gears.shape.rounded_rect(cr, w, h, dpi(6)) end
naughty.config.presets.critical.margin = dpi(8)

-- startup errors --
if awesome.startup_errors 
then
    naughty.notify(
        { 
            preset = naughty.config.presets.critical,
            title = "[ERROR] - startup - ",
            text = awesome.startup_errors 
        }
    )
end

-- runtime errors --
do
    local err_flag = false
    
    awesome.connect_signal(
        "debug::error", 
        function (err_msg)
            if err_flag then return end
            err_flag = true
            
            naughty.notify(
                { 
                    preset = naughty.config.presets.critical,
                    title = "[ERROR] - runtime - ",
                    text = tostring(err_msg) 
                }
            )

            err_flag = false
        end
    )
end

-- TESTS 
--[[
naughty.notify(
    {
        presets = naughty.config.presets.low,
        title = "[LOW TEST]",
        text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas egestas enim varius, rhoncus libero eu, maximus quam. Suspendisse condimentum malesuada quam. Integer sollicitudin sed tellus at posuere. Etiam vel nisl ante."
    }    
)
--

naughty.notify(
    {
        -- by default should take normal presets
        title = "[NORMAL TEST]",
        text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas egestas enim varius, rhoncus libero eu, maximus quam. Suspendisse condimentum malesuada quam. Integer sollicitudin sed tellus at posuere. Etiam vel nisl ante."
    }    
)

naughty.notify(
    {
        preset = naughty.config.presets.critical,
        title = "[CRITICAL TEST]",
        text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas egestas enim varius, rhoncus libero eu, maximus quam. Suspendisse condimentum malesuada quam. Integer sollicitudin sed tellus at posuere. Etiam vel nisl ante."
    }    
)
--]]
