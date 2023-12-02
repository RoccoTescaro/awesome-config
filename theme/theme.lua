local dpi = require("beautiful.xresources").apply_dpi

local theme = {}

--[[theme.palette = {
    black           = "#000000",
    dd_default_c    = "#303D4B",
    d_default_c     = "#485B70",
    default_c       = "#5F7995",
    l_default_c     = "#879BB0",
    ll_default_c    = "#AFBCCA",
    white           = "#FFFFFF",
    dark_error      = "#BF2B33",
    light_error     = "#CF4E53",
    dark_warning    = "#EBC728",
    light_warning   = "#F1D96D",
}--]]

local gears = require("gears")
theme.dir = gears.filesystem.get_configuration_dir() .. "theme/"

theme.wallpaper = theme.dir .. "background.png"

theme.font = "FantasqueSansM Nerd Font Mono Regular 12" --# TODO change

-- Background
theme.bg_normal     = "#161821"
theme.bg_dark       = "#000000"
theme.bg_focus      = "#1e2132"
theme.bg_urgent     = "#ed8274"
theme.bg_minimize   = "#444444"
theme.bg_systray    = "#262831"

-- Foreground
theme.fg_normal     = "#ffffff"
theme.fg_focus      = "#e4e4e4"
theme.fg_urgent     = "#ffffff"
theme.fg_minimize   = "#ffffff"

-- Sizing
theme.useless_gap         = dpi(3) -- plus dpi(3) of screen padding
theme.gap_single_client   = true   

-- Window Borders
theme.border_width          = dpi(2)            -- window border width
theme.border_normal         = theme.bg_normal
theme.border_focus          = "#373B41"
theme.border_marked         = theme.fg_urgent

-- Titlebars
theme.titlebar_font = theme.title_font
theme.titlebar_bg = theme.bg_normal
theme.titlebar_bg_focus = theme.titlebar_bg -- make titlebars not change color when focused

-- Taglist
theme.taglist_bg_empty = "#16182190"
theme.taglist_bg_occupied = '#808080cc'
theme.taglist_bg_urgent = '#e91e6399'
theme.taglist_bg_focus = theme.bg_normal
theme.taglist_shape = gears.shape.rounded_bar

-- Tasklist
theme.tasklist_font = theme.font

theme.tasklist_bg_normal = "#16182190"
theme.tasklist_bg_focus = theme.bg_normal
theme.tasklist_bg_urgent = theme.bg_urgent
theme.tasklist_bg_minimize = "#808080cc"

theme.tasklist_fg_focus = theme.fg_focus
theme.tasklist_fg_urgent = theme.fg_urgent
theme.tasklist_fg_normal = theme.fg_normal
theme.tasklist_shape = gears.shape.rounded_bar
theme.tasklist_plain_task_name = false

--[[

theme.fg_normal = theme.palette.ll_default_c
theme.fg_focus = theme.palette.white
theme.fg_urgent = theme.palette.white
theme.bg_normal = theme.palette.dd_default_c
theme.bg_focus = theme.palette.d_default_c
theme.bg_urgent = theme.palette.l_default_c

theme.border_width = dpi(2)
theme.border_normal = theme.bg_normal
theme.border_focus = theme.bg_focus

theme.useless_gap = dpi(3)

theme.taglist_fg_focus = theme.fg_focus
theme.taglist_bg_focus = theme.bg_focus

theme.tasklist_fg_focus = theme.fg_focus
theme.tasklist_bg_focus = theme.bg_focus
theme.tasklist_plain_task_name = false

theme.titlebar_fg_normal = theme.fg_normal
theme.titlebar_fg_focus = theme.fg_focus
theme.titlebar_bg_normal = theme.bg_normal
theme.titlebar_bg_focus = theme.bg_focus
--]]

-- set before by error-handlig (which uses it)
--[[
theme.notification_font = theme.font 
theme.notification_bg = theme.bg_normal
theme.notification_fg = theme.fg_normal
theme.notification_border_width = dpi(2)
theme.notification_border_color = theme.palette.white
theme.notification_shape = function(cr, w, h) gears.shape.rounded_rect(cr, w, h, dpi(6)) end
theme.notification_opacity = 0.8
theme.notification_margin = dpi(16)
theme.notification_width = dpi(544)
theme.notification_height = dpi(80)
--]]

return theme
