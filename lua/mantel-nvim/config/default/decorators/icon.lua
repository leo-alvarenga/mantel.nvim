local utils = require("mantel-nvim.utils")

--- @type mantel-nvim.PositionableDecorator
return {
	name = "fileicon",
	order = 1,
	position = "name_before",
	--- @type fun(buf: vim.fn.getbufinfo.ret.item): string
	text = function(buf)
		local icon = utils.get_icon_from_bufinfo(buf)

		if icon then
			icon = icon .. "  "
		end

		return icon or ""
	end,
}
