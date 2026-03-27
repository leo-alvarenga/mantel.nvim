--- @return mantel-nvim.HighlightOverwrites
local function get_default_highlights()
	local utils = require("mantel-nvim.utils")

	local normal = utils.get_hl("Normal")
	local comment = utils.get_hl("Comment")
	local statusline = utils.get_hl("StatusLine")
	local tabsel = utils.get_hl("TabLineSel")
	local tabline = utils.get_hl("TabLine")

	local diag_info = utils.get_hl("DiagnosticInfo")
	local diag_error = utils.get_hl("DiagnosticError")
	local diag_warn = utils.get_hl("DiagnosticWarn")

	return {
		fill = {
			fg = tabline.fg,
			bg = statusline.bg,
		},
		inactive = {
			fg = comment.fg or tabsel.bg,
			bg = statusline.bg,
		},
		active = {
			fg = diag_info.fg or statusline.fg,
			bg = normal.bg,
			bold = true,
			italic = true,
		},
		modified = {
			fg = diag_info.fg or statusline.fg,
			bg = normal.bg,
			bold = true,
		},
		duplicate = {
			fg = diag_info.fg or statusline.fg,
			bg = normal.bg,
			bold = true,
		},
		separator = {
			fg = diag_info.fg or statusline.fg,
			bg = statusline.bg,
		},
		prefix = {
			bg = normal.bg,
			fg = statusline.bg,
		},
		suffix = {
			bg = normal.bg,
			fg = statusline.bg,
		},
		prefix_inactive = {
			fg = statusline.bg,
			bg = statusline.bg,
		},
		suffix_inactive = {
			fg = statusline.bg,
			bg = statusline.bg,
		},

		diagnostics_error = {
			fg = diag_error.fg or statusline.fg,
			bg = normal.bg,
			bold = true,
		},
		diagnostics_warn = {
			fg = diag_warn.fg or statusline.fg,
			bg = normal.bg,
		},
		diagnostics_info = {
			fg = diag_info.fg or statusline.fg,
			bg = normal.bg,
		},
		diagnostics_hint = {
			fg = diag_info.fg or statusline.fg,
			bg = normal.bg,
		},
		diagnostics_error_inactive = {
			fg = diag_error.fg or statusline.fg,
			bg = statusline.bg,
		},
		diagnostics_warn_inactive = {
			fg = diag_warn.fg or statusline.fg,
			bg = statusline.bg,
		},
		diagnostics_info_inactive = {
			fg = diag_info.fg or statusline.fg,
			bg = statusline.bg,
		},
		diagnostics_hint_inactive = {
			fg = diag_info.fg or statusline.fg,
			bg = statusline.bg,
		},

		section_separator = {
			fg = diag_info.fg or statusline.fg,
			bg = statusline.bg,
		},
		tab_active = {
			fg = diag_info.fg or statusline.fg,
			bg = normal.bg,
		},
		tab_inactive = {
			fg = comment.fg or tabsel.bg,
			bg = normal.bg,
		},

		breadcrumb_fill = {
			fg = tabline.fg,
			bg = normal.bg,
		},
		breadcrumb_item = {
			fg = comment.fg or statusline.fg,
			bg = normal.bg,
		},
		breadcrumb_item_focus = {
			fg = diag_info.fg or statusline.fg,
			bg = normal.bg,
			bold = true,
			italic = true,
		},
		breadcrumb_separator = {
			fg = comment.fg or statusline.fg,
			bg = normal.bg,
		},
	}
end

return get_default_highlights
