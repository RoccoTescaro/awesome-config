local naughty = require("naughty")

-- setup notifications esthetic --

-- You may ask why? doing it here istead via theme.lua
-- we cannot do it becouse startup error handling should be done before loading the theme 
-- loading the theme before would omit the error checking to theme.lua file which in my opinion
-- is prone to errors as much as the rest of the code

local dpi = require("beautiful.xresources").apply_dpi
local gears = require("gears")

naughty.config.padding = dpi(16)
naughty.config.spacing = dpi(8)

local function set_naughty_preset(args)
    setmetatable(args, {__index = {
        timeout = 5,
        hover_timeout = 5, 
        max_width = dpi(544),
        font = "sans 8",
        fg = "#FFFFFF",
        bg = "#202020C0",
        border_width = dpi(2),
        border_color = "#FFFFFF",
        shape = function(cr, w, h) gears.shape.rounded_rect(cr, w, h, dpi(6)) end,
        margin = dpi(8),
        opacity = 1
    }})
    
    args[1].timeout = args.timeout
    args[1].hover_timeout = args.hover_timeout 
    args[1].max_width = args.max_width
    args[1].font = args.font
    args[1].fg = args.fg
    args[1].bg = args.bg
    args[1].border_width = args.border_width
    args[1].border_color = args.border_color
    args[1].shape = args.shape
    args[1].margin = args.margin
    args[1].opacity = args.opacity
end

set_naughty_preset{naughty.config.presets.low, hover_timeout = 60, bg = "#EBC72888", border_color = "#F1D96D"}
set_naughty_preset{naughty.config.presets.normal, bg = "#485B70DD", border_color = "#879BB0"}
set_naughty_preset{naughty.config.presets.critical, hover_timeout = 60, bg = "#AF1B23DD", border_color = "#CF4E53"}

-- general log functions --

local console = {}

function console.log(args)
    setmetatable(args, {__index = {
        lvl = "",
        title = ""
    }})

    local _lvl = (args[3] and args[1]) or args.lvl
    local _title = args[2] or args.title
    local _msg = args[3] or args[1] or args.msg

    local p = naughty.config.presets.normal
    if _lvl == "ERROR" then 
        p = naughty.config.presets.critical
    elseif _lvl == "WARNING" then 
        p = naughty.config.presets.low
    end

    local t = ""
    if _lvl ~= "" then 
        t = "[" .. _lvl .. "]"
    end
    if _title ~= "" then 
        t = t .. " - " .. _title .. " - "    
    end 

    naughty.notify(
        {
            preset = p,
            title = t,
            text = _msg
        }   
    )
end

return console