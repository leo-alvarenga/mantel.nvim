local diagnostics = require("mantel-nvim.config.default.decorators.diagnostics")
local icon = require("mantel-nvim.config.default.decorators.icon")

--- @type mantel-nvim.Decorators
return {
	sep = " ",
	prefix = "",
	suffix = "",

	native = {
		----------------------------------------------------------
		--- Prefix decorators
		----------------------------------------------------------
		icon,
		diagnostics,

		----------------------------------------------------------
		--- Suffix decorators
		----------------------------------------------------------
		{
			name = "modified",
			order = 1,
			text = function(buf)
				return buf.changed == 1 and "  ●" or ""
			end,
			position = "name_after",
		},
	},
}
