local vars = {}

vars.terminal = os.getenv("TERMINAL") or "kitty"

vars.editor = os.getenv("EDITOR") or "code"

vars.terminal_editor = "nvim"

vars.modkeys = {
    alt = "Mod1",
    mod = "Mod4",
    shift = "Shift",
    ctrl = "Control"
}

local awful = require("awful")
vars.kbmap = awful.widget.keyboardlayout()

local wibox = require("wibox")
vars.clock = wibox.widget.textclock()

return vars