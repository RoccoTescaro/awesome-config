local vars = require("vars")
local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

local tasklist = {}

-- bindings --

local task_buttons = {}

function task_buttons.add_button(modkey, key, func)
    gears.table.join(task_buttons, {awful.button(modkey, key, func)})
end

task_buttons.add_button({}, 1, function(task) 
    if task == client.focus then task.minimized = true
    else task:emit_signal("request::activate", "tasklist", { raise = true })
    end
end)
task_buttons.add_button({}, 4, function() awful.client.focus.byidx(1) end)
task_buttons.add_button({}, 5, function() awful.client.focus.byidx(-1) end)

-- create function definition --

function tasklist.new(tag)
    local function only_this_tag(task, _)
        for _, _tag in ipairs(task:tags()) do
            if _tag == tag then return true end 
        end
        return false
    end

    local new_tasklist = {}
    
    new_tasklist.screen = tag.screen -- #TODO updade with signals
    new_tasklist.buttons = task_buttons
    new_tasklist.filter = only_this_tag
    new_tasklist.layout = {spacing = dpi(4), layout = wibox.layout.fixed.horizontal}
        -- widget (esthetic) --
    new_tasklist.widget_template = {
        widget = wibox.container.place,
        {
            id = "clienticon",
            widget = awful.widget.clienticon,
        },
        
        create_callback = function(self, client, _, _) 
            self:get_children_by_id("clienticon")[1].client = client 
        end,
        
        update_callback = function(self, _, _, _) 
            local childs = self:get_children_by_id("clienticon")
            for _, elm in ipairs(childs) do
                if client.focus and elm.client == client.focus then
                    self.forced_width = dpi(30) 
                    self.forced_height = dpi(30)
                    self.opacity = 1
                else
                    self.forced_width = dpi(24)
                    self.forced_height = dpi(24)
                    self.opacity = 0.5
                end

            end
        end
    }

    return awful.widget.tasklist(new_tasklist)
end

return tasklist