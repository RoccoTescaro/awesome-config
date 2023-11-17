local dpi = require("beautiful.xresources").apply_dpi

local theme = {}

theme.palette = {
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
}

local gears = require("gears")
theme.dir = gears.filesystem.get_configuration_dir() .. "theme/"

theme.wallpaper = theme.dir .. "background.png"

theme.font = "FantasqueSansM Nerd Font Mono Regular 12" --# TODO change

theme.fg_normal = theme.palette.ll_default_c
theme.fg_focus = theme.palette.white
theme.fg_urgent = theme.palette.white
theme.bg_normal = theme.palette.dd_default_c
theme.bg_focus = theme.palette.d_default_c
theme.bg_urgent = theme.palette.l_default_c

theme.border_width = dpi(2)
theme.border_normal = theme.bg_normal
theme.border_focus = theme.bg_focus

theme.useless_gap = 0

theme.taglist_fg_focus = theme.fg_focus
theme.taglist_bg_focus = theme.bg_focus

theme.tasklist_fg_focus = theme.fg_focus
theme.tasklist_bg_focus = theme.bg_focus
theme.tasklist_plain_task_name = false

theme.titlebar_fg_normal = theme.fg_normal
theme.titlebar_fg_focus = theme.fg_focus
theme.titlebar_bg_normal = theme.bg_normal
theme.titlebar_bg_focus = theme.bg_focus

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

theme.titlebar_close_button_normal = theme.dir .. "titlebar/close_normal.png" --# TODO change
theme.titlebar_close_button_focus = theme.dir .. "titlebar/close_focus.png"

theme.titlebar_maximized_button_normal_inactive = theme.dir .. "titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive = theme.dir .. "titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = theme.dir .. "titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active = theme.dir .. "titlebar/maximized_focus_active.png"

return theme
