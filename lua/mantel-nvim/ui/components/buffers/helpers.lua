local utils = require("mantel-nvim.utils")

local M = {}

--- @param opts mantel-nvim.Opts
--- @param buf vim.fn.getbufinfo.ret.item
--- @param position mantel-nvim.Positionable
--- @return string part, integer len
function M.add_decorators(opts, buf, position)
	local part = ""

	--- @type mantel-nvim.PositionableDecorator[]
	local decorators = {}
	local len = 0

	--- @type mantel-nvim.PositionableDecorator[]
	local all_decorators =
		vim.tbl_extend("keep", {}, opts.bufs.decorators.extras or {}, opts.bufs.decorators.native or {})

	for i, decorator in ipairs(all_decorators) do
		::continue::

		if #decorator.name <= 0 then
			utils.notify(
				"Extra decorator at position '" .. i .. "' is missing a name. Skipping...",
				vim.log.levels.WARN
			)

			goto continue
		end

		if decorator.disabled ~= true and decorator.position == position then
			table.insert(decorators, decorator)
		end
	end

	----------------------------------------------------------

	table.sort(decorators, function(a, b)
		return a.order < b.order
	end)

	--- @type table<string, boolean>
	local rendered_decorators = {}

	local fallback_hl = opts.bufs.hl.inactive

	if utils.is_current_buf(buf.bufnr) then
		fallback_hl = opts.bufs.hl.active
	end

	for _, decorator in ipairs(decorators) do
		local text = utils.evaluate_buf_aware_option(decorator.text, buf)

		if #text > 0 and not rendered_decorators[decorator.name] then
			rendered_decorators[decorator.name] = true
			len = len + #text

			local hl = utils.evaluate_buf_aware_option(decorator.hl or fallback_hl, buf)

			if type(hl) == "string" then
				text = utils.hl(hl) .. text
			end

			part = part .. text
		end
	end

	return part, len
end

return M
