local M = {}

M.fmt = string.format

function M.is_current_buf(bufnr)
	return vim.api.nvim_get_current_buf() == bufnr
end

--- Wrapper around `vim.notify` that sets a default log level and title
function M.notify(msg, level)
	vim.notify(msg, level or vim.log.levels.INFO, { title = "Mantel" })
end

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

--- @param option mantel-nvim.BufAwareStr
--- @param buf vim.fn.getbufinfo.ret.item
--- @return string val
function M.evaluate_buf_aware_option(option, buf)
	if type(option) == "string" and #option > 0 then
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

--- Formats a highlight group for use in the statusline/tabline
--- @param buf vim.fn.getbufinfo.ret.item
--- @param hl mantel-nvim.BufAwareStr
function M.buf_aware_hl(buf, hl)
	local hl_val = M.evaluate_buf_aware_option(hl, buf)

	if type(hl_val) ~= "string" or #hl_val < 1 then
		return ""
	end

	return M.fmt("%%#%s#", hl)
end

--- @class CenterTextOptions
--- @field text string The text to center
--- @field width integer The total width of the field
--- @field filler_char string? The character to use for filling the space (default: " ")
--- @field text_width integer? The display width of the text (if different from #text, e.g. due to multibyte characters)
--- @field hl string? Optional highlight group
--- @field min_padding integer? Minimum padding on each side (default: 0)

--- Centers the given text within a field of the specified width, using the specified filler character
--- @param options CenterTextOptions
--- @return string centered_text, integer padding
function M.center_text(options)
	local text = options.text or ""
	local text_len = options.text_width or #text

	local filler_char = options.filler_char or " "

	local width = options.width or 0
	local hl = options.hl

	local padding = math.max(options.min_padding or 0, math.floor((width - text_len) / 2))
	local left_padding = string.rep(filler_char, padding)
	local right_padding = string.rep(filler_char, math.max(options.min_padding or 0, width - text_len - padding))

	if hl then
		left_padding = M.hl(hl) .. left_padding
		right_padding = M.hl(hl) .. right_padding
	end

	return left_padding .. text .. right_padding, #left_padding + #right_padding
end

M.trigger_update = vim.schedule_wrap(function()
	vim.cmd("redrawtabline")
end)

return M
