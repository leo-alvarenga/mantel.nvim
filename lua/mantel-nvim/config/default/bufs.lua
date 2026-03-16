local buf_decorators = require("mantel-nvim.config.default.decorators.bufs")
local default_hl = require("mantel-nvim.config.default.highlights")

--- @type mantel-nvim.Bufs
return {
	decorators = buf_decorators,
	min_padding = 4,
	min_width = 20,
	hl = default_hl,

	overwrites = {
		ambiguos = function(buf)
			return vim.fn.fnamemodify(buf.name, ":.")
		end,
		name = function(buf)
			return vim.fn.fnamemodify(buf.name, ":t")
		end,
		no_name = "[Empty buffer]",
	},
}
