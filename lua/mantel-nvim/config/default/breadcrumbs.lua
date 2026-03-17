local default_hl = require("mantel-nvim.config.default.highlights")
local utils = require("mantel-nvim.utils")

--- @type mantel-nvim.Breadcrumbs
return {
	enabled = true,

	hl = default_hl,

	padding_left = 4,
	padding_right = 4,

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
				})
			end
		end

		return parts
	end,
}
