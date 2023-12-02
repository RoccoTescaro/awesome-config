local vars = require("vars")
local awful = require("awful")

local taglist = {}

-- bindings --

local tag_buttons = {}

local function tag_buttons.add_button(modkey, key, func)
    table.insert(tag_buttons, awful.button(modkey, key, func))
end

tag_buttons.add_button({}, 1, function(tag) tag:view_only() end)
tag_buttons.add_button({vars.modkeys.mod}, 1, function(tag) if client.focus then client.focus:move_to_tag(tag) end end) -- not really a thing
tag_buttons.add_button({}, 3, awful.tag.viewtoggle)
tag_buttons.add_button({}, 4, function(tag) awful.tag.viewnext(tag.screen) end)
tag_buttons.add_button({}, 5, function(tag) awful.tag.viewprev(tag.screen) end)

-- functions definition --

local function three_tag(screen) -- #TODO adapt with number of tags
    -- table indexes goes from 1 to n_dsk
    -- cannot use modular arithmatic for prev_index 
    local n_dsk = #screen.tags
    local sel_dsk = screen.selected_tag
    local prev_index = sel_dsk.index - 1
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

-- attributes definition --

taglist.screen = 1 -- #TODO updade with signals
taglist.buttons = tag_buttons
taglist.filter = awful.widget.taglist.filter.all,
taglist.source = three_tag
    -- widget (esthetic) --
taglist.widget_template = {} -- #TODO

-- taglist = awful.widget.taglist(taglist)

return taglist