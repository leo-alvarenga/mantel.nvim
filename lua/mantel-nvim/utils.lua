local M = {}

M.fmt = string.format

--- @param option string|fun(): string
--- @return string|nil val
function M.evaluate_option_explicit(option)
	if type(option) == "string" then
		return option
	elseif type(option) == "function" then
		return M.evaluate_option_explicit(option())
	end

	return nil
end

--- @param option string|fun(): string
--- @return string val
function M.evaluate_option(option)
	return M.evaluate_option_explicit(option) or ""
end

--- @param option boolean|fun(): boolean
--- @return boolean val
function M.evaluate_toggle(option)
	if type(option) == "boolean" then
		return option
	elseif type(option) == "function" then
		return M.evaluate_toggle(option())
	end

	return false
end

--- @param option string|fun(buf: vim.fn.getbufinfo.ret.item): string
--- @param buf vim.fn.getbufinfo.ret.item
--- @return string val
function M.evaluate_buf_overwrite(option, buf)
	if type(option) == "string" then
		return option
	elseif type(option) == "function" then
		return M.evaluate_buf_overwrite(option(buf), buf)
	end

	return ""
end

--- Formats a highlight group for use in the statusline/tabline
--- @param hl string
function M.hl(hl)
	if type(hl) ~= "string" or #hl < 1 then
		return ""
	end

	return M.fmt("%%#%s#", hl)
end

--- Centers the given text within a field of the specified width, using the specified filler character
--- @param text string The text to center
--- @param width integer The total width of the field
--- @param filler_char string? The character to use for filling the space (default: " ")
function M.center_text(text, width, filler_char)
	local text_len = #text
	filler_char = filler_char or " "

	if text_len >= width then
		return text
	end

	local padding = math.max(0, math.floor((width - #text) / 2))
	local left_padding = string.rep(filler_char, padding)
	local right_padding = string.rep(filler_char, width - text_len - padding)

	return left_padding .. text .. right_padding
end

--- @param opts mantel-nvim.Opts
--- @param position mantel-nvim.Positionable
--- @param duplicate boolean
--- @param modified boolean
--- @return string part, integer len
function M.add_decorators(opts, position, duplicate, modified)
	local part = ""

	--- @type mantel-nvim.PositionableDecorator[]
	local decorators = {}
	local len = 0

	if
		duplicate
		and opts.bufs.decorators.duplicate
		and M.evaluate_toggle(opts.bufs.decorators.duplicate.enabled)
		and opts.bufs.decorators.duplicate.position == position
	then
		table.insert(decorators, opts.bufs.decorators.duplicate)
	end

	if
		modified
		and opts.bufs.decorators.modified
		and M.evaluate_toggle(opts.bufs.decorators.modified.enabled)
		and opts.bufs.decorators.modified.position == position
	then
		table.insert(decorators, opts.bufs.decorators.modified)
	end

	table.sort(decorators, function(a, b)
		return a.order < b.order
	end)

	for _, decorator in ipairs(decorators) do
		local text = M.evaluate_option(decorator.text)

		part = part .. text
		len = len + #text
	end

	return part, len
end

return M
