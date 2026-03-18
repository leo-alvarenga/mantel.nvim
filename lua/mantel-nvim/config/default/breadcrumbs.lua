local consts = require("mantel-nvim.constants")
local utils = require("mantel-nvim.utils")

--- @type mantel-nvim.Breadcrumbs
return {
	enabled = true,

	hl = {
		breadcrumb_fill = consts.hl_groups.breadcrumb_fill,
		breadcrumb_item = consts.hl_groups.breadcrumb_item,
		breadcrumb_item_focus = consts.hl_groups.breadcrumb_item_focus,
		breadcrumb_separator = consts.hl_groups.breadcrumb_separator,
	},

	padding_left = 2,
	padding_right = 2,

	sep = "  ",

	parts = function(buf)
		local icon = utils.get_icon_from_bufinfo(buf) or ""
		local full_name = vim.fn.fnamemodify(buf.name, ":~:.")

		local str_parts = vim.split(full_name, "/", { plain = true })

		--- @type mantel-nvim.BreadcrumbPart[]
		local parts = {}

		if #str_parts <= 1 then
			table.insert(parts, {
				text = ".",
				len = 1,
			})
		end

		for i, str in ipairs(str_parts) do
			local str_len = utils.strlen(str)

			if str_len > 0 then
				if i == #str_parts and icon then
					str = icon .. " " .. str
				end

				table.insert(parts, {
					text = str,
					len = str_len,
					focused = i == #str_parts,
				})
			end
		end

		return parts
	end,
}
