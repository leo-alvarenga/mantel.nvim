local M = {}

--- Wrapper around `nvim_get_hl` that returns an empty table if the highlight group doesn't exist
--- @param name string
--- @return table
local function get_hl(name)
	local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = name, link = false })

	if not ok then
		return {}
	end

	return hl
end

function M.blend(fg, bg, alpha)
	return vim.api.nvim_get_color_by_name(string.format("#%06x", math.floor((1 - alpha) * fg + alpha * bg)))
end

-- Setup --------------------------------------------------------

function M.setup()
	local normal = get_hl("Normal")
	local tabline = get_hl("TabLine")
	local tabsel = get_hl("TabLineSel")
	local fill = get_hl("TabLineFill")
	local comment = get_hl("Comment")

	local diag_error = get_hl("DiagnosticError")
	local diag_warn = get_hl("DiagnosticWarn")
	local diag_info = get_hl("DiagnosticInfo")
	local diag_hint = get_hl("DiagnosticHint")

	vim.api.nvim_set_hl(0, "MantelFill", {
		bg = fill.bg or tabline.bg,
	})

	vim.api.nvim_set_hl(0, "MantelBackground", {
		fg = tabline.fg,
		bg = tabline.bg,
	})

	vim.api.nvim_set_hl(0, "MantelInactive", {
		fg = tabline.fg,
		bg = tabline.bg,
	})

	vim.api.nvim_set_hl(0, "MantelVisible", {
		fg = normal.fg,
		bg = tabline.bg,
	})

	vim.api.nvim_set_hl(0, "MantelActive", {
		fg = tabsel.fg,
		bg = tabsel.bg,
		bold = true,
	})

	vim.api.nvim_set_hl(0, "MantelModified", {
		fg = comment.fg,
		bg = tabline.bg,
		italic = true,
	})

	vim.api.nvim_set_hl(0, "MantelDuplicate", {
		fg = comment.fg,
		bg = tabline.bg,
	})

	vim.api.nvim_set_hl(0, "MantelError", {
		fg = diag_error.fg,
		bg = tabline.bg,
	})

	vim.api.nvim_set_hl(0, "MantelWarn", {
		fg = diag_warn.fg,
		bg = tabline.bg,
	})

	vim.api.nvim_set_hl(0, "MantelInfo", {
		fg = diag_info.fg,
		bg = tabline.bg,
	})

	vim.api.nvim_set_hl(0, "MantelHint", {
		fg = diag_hint.fg,
		bg = tabline.bg,
	})

	vim.api.nvim_set_hl(0, "MantelSeparator", {
		fg = diag_info.fg,
		bg = tabline.bg,
	})

	vim.api.nvim_set_hl(0, "MantelBreadcrumb", {
		fg = comment.fg,
		bg = fill.bg or tabline.bg,
		italic = true,
	})

	vim.api.nvim_create_autocmd("ColorScheme", {
		callback = function()
			require("mantel-nvim.highlights").setup()
		end,
	})
end

return M
