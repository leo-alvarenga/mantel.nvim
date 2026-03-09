local M = {}

M.fmt = string.format

--- Wrapper around `nvim_get_hl` that returns an empty table if the highlight group doesn't exist
--- @param name string
--- @return table
function M.get_hl(name)
	local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = name, link = false })

	if not ok then
		return {}
	end

	return hl
end

--- Gets just the bg color from a highlight group
--- @param name string
--- @return string? hex color string (e.g. "#rrggbb") or nil
function M.bg(name)
	local hl = M.get_hl(name)
	return hl.bg and string.format("#%06x", hl.bg) or nil
end

--- Gets the background color for the current buffer
function M.get_buf_bg()
	return M.bg("Normal") or M.bg("NormalNC") or M.bg("NormalFloat") or M.bg("StatusLine")
end

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

--- @param option table|fun(): table
--- @return table val
function M.evaluate_table_option(option)
	if type(option) == "table" then
		return option
	elseif type(option) == "function" then
		return M.evaluate_table_option(option())
	end

	return {}
end

--- @param option mantel-nvim.BufAwareText
--- @param buf vim.fn.getbufinfo.ret.item
--- @return string val
function M.evaluate_buf_aware_option(option, buf)
	if type(option) == "string" then
		return option
	elseif type(option) == "function" then
		return M.evaluate_buf_aware_option(option(buf), buf)
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
--- @return string centered_text, integer padding
function M.center_text(text, width, filler_char)
	local text_len = #text
	filler_char = filler_char or " "

	if text_len >= width then
		return text, 0
	end

	local padding = math.max(0, math.floor((width - #text) / 2))
	local left_padding = string.rep(filler_char, padding)
	local right_padding = string.rep(filler_char, math.max(0, width - text_len - padding))

	return left_padding .. text .. right_padding, padding
end

return M
