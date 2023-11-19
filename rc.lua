-- RUN lua loader
-- basicly calling the lua compiler with all the default packages ?
pcall(require, "luarocks.loader")

-- ERROR handling
-- helps for debugging, show notification of errors for this compiled file
require("errors")

-- GENERAL setup
-- setup some global stuff, like theme and general rules that applies to tabs
require("setup")

-- SCREEN setup
-- define how the screen is structured, with wallpapers, bars ecc.
require("screen")

-- BINDINGS
-- root bindings applies evreywhere ( I like to think it as bindings relative to desktops/tags )
local bindings = require("bindings")
root.buttons(bindings.dskmouse) 
root.keys(bindings.dskkeys)

-- SIGNALS
-- still not clear
require("signals")

--github token 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
