local M = {}

--- @type mantel-nvim.Decorators
local default_decorators = {
	sep = "",
	prefix = "| ",
	suffix = " ",
	modified = {
		enabled = true,
		order = 1,
		text = " ●",
		position = "suffix",
	},
}

--- @return mantel-nvim.HighlightOverwrites
function M.get_default_highlights()
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
			bg = statusline.bg or tabsel.fg,
		},
		inactive = {
			fg = tabsel.bg,
			bg = statusline.bg or tabsel.fg,
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

--- @type mantel-nvim.HighlightGroups
local default_hl = {
	fill = "MantelFill",
	inactive = "MantelInactive",
	active = "MantelActive",
	modified = "MantelModified",
	duplicate = "MantelDuplicate",
	separator = "MantelSeparator",
}

--- @type mantel-nvim.Opts
local default_config = {
	mode = "classic",

	bufs = {
		decorators = default_decorators,
		min_width = 10,
		hl = default_hl,

		overwrites = {
			ambiguos = function(buf)
				return vim.fn.fnamemodify(buf.name, ":.")
			end,
			name = function(buf)
				return vim.fn.fnamemodify(buf.name, ":t")
			end,
			no_name = "[No name]",
		},
	},
	tabs = {
		decorators = default_decorators,
		enabled = "auto",
		min_width = 5,
		hl = default_hl,
	},

	highlight_overwrites = M.get_default_highlights,
}

--- @type mantel-nvim.Opts
M.opts = default_config

function M.set_opts(user_opts)
	M.opts = vim.tbl_deep_extend("force", {}, default_config, user_opts or {})
end

return M
