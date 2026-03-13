local bufs = require("mantel-nvim.config.default.bufs")
local tabs = require("mantel-nvim.config.default.tabs")

local get_default_highlights = require("mantel-nvim.config.default.highlight_overwrites")

--- @type mantel-nvim.Opts
return {
	disableWarning = false,

	mode = "classic",

	bufs = bufs,
	tabs = tabs,

	highlight_overwrites = get_default_highlights,
}
