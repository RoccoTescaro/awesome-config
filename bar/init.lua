-- https://gist.github.com/ruby0b/11d03fba9eefc737598fffffe34c085e

local beautiful = require("beautiful")
local wibox = require("wibox")
local gears = require("gears")
local dpi = beautiful.xresources.apply_dpi
local vars = require("vars")
local awful = require("awful")

-- helper function with some defaults values --
local function widget_bg(widget, args)
    local args = args or {}
    local widget_ = wibox.container.background(widget)
    widget_.bg = args.bg or beautiful.bg_normal
    widget_.shape = args.shape or gears.shape.rounded_bar
    widget_.shape_border_width = args.shape_border_width or dpi(1)
    widget_.shape_border_color = args.shape_border_color or beautiful.border_focus
    widget_.opacity = args.opacity or 1
    return widget_
end

-- bottom left widget --
    -- kbmap element --
local kbmap_widget = widget_bg(vars.kbmap, {bg = beautiful.bg_systray, shape_border_width = 0})
kbmap_widget = wibox.container.margin(kbmap_widget, dpi(3), dpi(3))
    -- systray element --
local systray_widget = wibox.container.place(wibox.widget.systray())
systray_widget = widget_bg(systray_widget, {bg = beautiful.bg_systray, shape_border_width = 0})
systray_widget = wibox.container.constraint(systray_widget, 'max', dpi(104))
systray_widget = wibox.container.margin(systray_widget, dpi(3), dpi(3)) 
    ----

bl_widget = wibox.widget{layout = wibox.layout.align.horizontal, kbmap_widget, systray_widget, nil}
bl_widget = wibox.container.margin(bl_widget, dpi(3), dpi(3), dpi(6), dpi(6))
bl_widget = wibox.container.constraint(bl_widget,'exact', dpi(160))
bl_widget = widget_bg(bl_widget)

-- bottom right widget --
    -- clock element --
local clock_widget = widget_bg(vars.clock, {bg = beautiful.bg_systray, shape_border_width = 0})
clock_widget = wibox.container.margin(clock_widget, dpi(3), dpi(3))
    ----

br_widget = wibox.container.margin(clock_widget, dpi(3), dpi(3), dpi(6), dpi(6))
br_widget = wibox.container.constraint(br_widget, 'exact', dpi(160))
br_widget = widget_bg(br_widget)

-- bar widget --
    -- tasklist -- #todo change filter
-- local task_buttons = require("screen.dskbutton")
-- local tasklist = awful.widget.tasklist({}, awful.tasklist.filter.currenttags, task_buttons, {})

--[[

bar = awful.wibar()
bar.screen = 1          -- #TODO add a signal to change screen, width, visible/struts
bar.bg = "#FFFFFF00"
bar.position = "top"
bar.ontop = true
bar.visible = true
bar.height = dpi(56)
bar.opacity = 1

bar:setup{
    layout = wibox.layout.align.horizontal,
    bl_widget,
    nil,
    br_widget
}

--]]

local awful = require("awful")
local gears = require("gears")

local internal_spacing = dpi(12)
local icon_size = dpi(28)
local smaller_icon_size = dpi(24)

local function fancy_tasklist(cfg, tag)
    local function only_this_tag(c, s)
        for _, t in ipairs(c:tags()) do
            if t == tag then 
                return true 
            end 
        end
        return false
    end

    local overrides = {
        filter = only_this_tag,
        layout = {
            spacing = dpi(4),
            layout = wibox.layout.fixed.horizontal
        },
        widget_template = {
            id = "clienticon",
            widget = awful.widget.clienticon,

            create_callback = function(self, c, _, _) --#TODO define a default icon
                self:get_children_by_id("clienticon")[1].client = c
                self.forced_height = icon_size
                self.forced_width = icon_size
            end
        }
    }
    return awful.widget.tasklist(gears.table.join(cfg, overrides))
end

local module = {}

-- @param cfg.screen
-- @param cfg.tasklist -> see awful.widget.tasklist
-- @param cfg.taglist  -> see awful.widget.taglist
function module.new(cfg)
    cfg = cfg or {}
    local taglist_cfg = cfg.taglist or {}
    local tasklist_cfg = cfg.tasklist or {}

    local screen = cfg.screen or awful.screen.focused()
    taglist_cfg.screen = screen
    tasklist_cfg.screen = screen

    local function update_callback(self, tag, _, _)
        -- make sure that empty tasklists take up no extra space
        local list_separator = self:get_children_by_id("list_separator")[1]
        if #tag:clients() == 0 then
            list_separator.spacing = 0
        else
            list_separator.spacing = internal_spacing
        end
    end

    local function create_callback(self, tag, _index, _tags)
        local tasklist = require("tasklist").new(tag)
        self:get_children_by_id("tasklist_placeholder")[1]:add(tasklist)
        update_callback(self, tag, _index, _tags)
    end

    local overrides = {
        widget_template = {
            widget = wibox.container.margin,
            left = dpi(3),
            right = dpi(3),
            {
                id = "list_separator",
                layout = wibox.layout.fixed.horizontal,
                {
                    widget = wibox.container.constraint,
                    strategy = 'min',
                    width = dpi(104),
                    height = dpi(64),  
                    {
                        widget = wibox.container.background,
                        bg =  beautiful.bg_systray,
                        shape = gears.shape.rounded_bar,
                        {
                            widget = wibox.container.place,
                            {
                                -- icons
                                widget = wibox.container.margin,
                                left = dpi(16),
                                right = dpi(16),
                                {
                                    id = "tasklist_placeholder",
                                    layout = wibox.layout.fixed.horizontal
                                },
                            },
                        },
                    }              
                },
                
            },
                
            create_callback = create_callback,
            update_callback = update_callback,
        },

        filter = awful.widget.taglist.filter.all,
        source = function(screen)
            -- table indexes goes from 1 to n_dsk
            -- cannot use modular arithmatic for prev_index 
            local n_dsk = #screen.tags
            local sel_dsk = screen.selected_tag
            local prev_index = sel_dsk.index-1
            if sel_dsk.index == 1 
            then 
                prev_index = n_dsk
            end
            local prev_dsk = screen.tags[prev_index]
            local next_dsk = screen.tags[(sel_dsk.index % n_dsk) + 1]
            return {prev_dsk, 
                    sel_dsk, 
                    next_dsk}
        end
    }

    return awful.widget.taglist(gears.table.join(taglist_cfg, overrides))
end

return module
--]]