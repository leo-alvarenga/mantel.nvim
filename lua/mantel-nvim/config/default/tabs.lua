local utils = require("mantel-nvim.utils")

--- @type mantel-nvim.Tabs
return {
	enabled = "auto",
	min_width = 7,
	min_padding = 2,

	prefix = "",
	content = function()
		local tab_count = #vim.fn.gettabinfo()
		local current_tab = tostring(vim.fn.tabpagenr())

		--- @type mantel-nvim.TabPart[]
		local parts = {
			{
				text = current_tab,
				active = true,
				len = utils.strlen(current_tab),
			},
		}

		local text = "/" .. tab_count
		table.insert(parts, {
			text = text,
			active = false,
			len = utils.strlen(text),
		})

		return parts
	end,
	suffix = "",
}
