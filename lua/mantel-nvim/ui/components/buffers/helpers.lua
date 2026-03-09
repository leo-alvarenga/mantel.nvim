local utils = require("mantel-nvim.utils")

local M = {}

--- @param opts mantel-nvim.Opts
--- @param buf vim.fn.getbufinfo.ret.item
--- @param position mantel-nvim.Positionable
--- @param duplicate boolean
--- @param modified boolean
--- @return string part, integer len
function M.add_decorators(opts, buf, position, duplicate, modified)
	local part = ""

	--- @type mantel-nvim.PositionableDecorator[]
	local decorators = {}
	local len = 0

	----------------------------------------------------------
	--- Native decorators
	----------------------------------------------------------

	if duplicate and opts.bufs.decorators.duplicate and opts.bufs.decorators.duplicate.position == position then
		table.insert(decorators, opts.bufs.decorators.duplicate)
	end

	if modified and opts.bufs.decorators.modified and opts.bufs.decorators.modified.position == position then
		table.insert(decorators, opts.bufs.decorators.modified)
	end

	if opts.bufs.decorators.diagnostics and opts.bufs.decorators.diagnostics.position == position then
		table.insert(decorators, opts.bufs.decorators.diagnostics)
	end

	----------------------------------------------------------
	--- Extra decorators
	----------------------------------------------------------

	if opts.bufs.decorators.extras and #opts.bufs.decorators.extras > 0 then
		for _, extra in ipairs(opts.bufs.decorators.extras) do
			if extra.position == position then
				table.insert(decorators, extra)
			end
		end
	end

	----------------------------------------------------------

	table.sort(decorators, function(a, b)
		return a.order < b.order
	end)

	for _, decorator in ipairs(decorators) do
		local text = utils.evaluate_buf_aware_option(decorator.text, buf)

		if #text > 0 then
			part = part .. text
			len = len + #text
		end
	end

	return part, len
end

return M
