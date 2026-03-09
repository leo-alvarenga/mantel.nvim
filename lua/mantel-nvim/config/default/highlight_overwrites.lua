--- @return mantel-nvim.HighlightOverwrites
local function get_default_highlights()
	local utils = require("mantel-nvim.utils")

	local normal = utils.get_hl("Normal")
	local statusline = utils.get_hl("StatusLine")
	local tabsel = utils.get_hl("TabLineSel")
	local tabline = utils.get_hl("TabLine")

	local comment = utils.get_hl("Comment")
	local diag_info = utils.get_hl("DiagnosticInfo")

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
			fg = comment.fg,
			bg = tabline.bg,
			italic = true,
		},
		duplicate = {
			fg = comment.fg,
			bg = tabline.bg,
		},
		separator = {
			fg = comment.fg,
			bg = tabsel.fg,
		},
	}
end

return get_default_highlights
