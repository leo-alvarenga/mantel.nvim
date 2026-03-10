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
		for i, extra in ipairs(opts.bufs.decorators.extras) do
			::continue::

			if #extra.name <= 0 then
				utils.notify(
					"Extra decorator at position '" .. i .. "' is missing a name. Skipping...",
					vim.log.levels.WARN
				)
				goto continue
			end

			if extra.position == position then
				table.insert(decorators, extra)
			end
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
				text = utils.hl(hl) .. text .. "%*"
			end

			part = part .. text
		end
	end

	return part, len
end

return M
