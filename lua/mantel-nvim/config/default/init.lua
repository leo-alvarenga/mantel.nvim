local breadcrumbs = require("mantel-nvim.config.default.breadcrumbs")
local bufs = require("mantel-nvim.config.default.bufs")
local tabs = require("mantel-nvim.config.default.tabs")

local get_default_highlights = require("mantel-nvim.config.default.highlight_overwrites")

--- @type mantel-nvim.Opts
return {
	disableWarning = false,
	ellipsis = " ... ",

	mode = "classic",

	style = {
		preset = "default",
		ignore_first_buffer_prefix = false,
	},

	bufs = bufs,
	tabs = tabs,

	breadcrumbs = breadcrumbs,

	highlight_overwrites = get_default_highlights,
}
