--- @return mantel-nvim.HighlightOverwrites
local function get_default_highlights()
	local utils = require("mantel-nvim.utils")

	local normal = utils.get_hl("Normal")
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
			fg = tabsel.bg,
			bg = statusline.bg,
		},
		active = {
			fg = diag_info.fg or statusline.fg,
			bg = normal.bg,
			bold = true,
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
	}
end

return get_default_highlights
