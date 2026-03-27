local buf_decorators = require("mantel-nvim.config.default.decorators.bufs")
local utils = require("mantel-nvim.utils")

--- @type mantel-nvim.Bufs
return {
	decorators = buf_decorators,
	min_padding = 4,
	min_width = 20,
	max_name_len = 20,

	overwrites = {
		ambiguos = function(buf)
			return vim.fn.fnamemodify(buf.name, ":.")
		end,
		name = function(buf)
			return vim.fn.fnamemodify(buf.name, ":t")
		end,
		no_name = "[Empty buffer]",
		overflow = function(_, name, max_len, ellipsis)
			local direction = "left-to-right"
			local prefix = ""
			local suffix = ""

			if string.find(name, "/", nil, true) then
				direction = "right-to-left"
				prefix = ellipsis
			else
				suffix = ellipsis
			end

			local cut_count = max_len - (utils.strlen(ellipsis))
			return prefix .. utils.strslice(name, cut_count, direction) .. suffix
		end,
	},
}
