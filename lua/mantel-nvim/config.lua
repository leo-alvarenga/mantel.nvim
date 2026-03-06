--- @type mantel-nvim.Decorators
local default_decorators = {
	sep = "",
	prefix = " ",
	suffix = " ",
	modified = {
		enabled = true,
		order = 1,
		text = " ●",
		position = "suffix",
	},
}

--- @return mantel-nvim.HighlightOverwrites
local function get_default_highlights()
	local lazy = require("mantel-nvim.lazy")
	local utils = lazy.require("mantel-nvim.utils")

	local normal = utils.get_hl("Normal")
	local tabsel = utils.get_hl("TabLineSel")
	local tabline = utils.get_hl("TabLine")
	local comment = utils.get_hl("Comment")

	local diag_error = utils.get_hl("DiagnosticError")
	local diag_warn = utils.get_hl("DiagnosticWarn")
	local diag_info = utils.get_hl("DiagnosticInfo")
	local diag_hint = utils.get_hl("DiagnosticHint")

	return {
		fill = {
			fg = normal.fg,
			bg = normal.bg,
		},
		background = {
			fg = tabline.fg,
			bg = tabline.bg,
		},
		inactive = {
			fg = tabsel.bg,
			bg = normal.bg,
		},
		active = {
			fg = normal.bg,
			bg = tabsel.bg,
			bold = true,
		},
		visible = {
			fg = normal.fg,
			bg = tabline.bg,
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
		error = {
			fg = diag_error.fg,
			bg = tabline.bg,
		},
		warn = {
			fg = diag_warn.fg,
			bg = tabline.bg,
		},
		info = {
			fg = diag_info.fg,
			bg = tabline.bg,
		},
		hint = {
			fg = diag_hint.fg,
			bg = tabline.bg,
		},
		separator = {
			fg = diag_info.fg,
			bg = tabline.bg,
		},
		prefix = {
			fg = diag_info.fg,
			bg = tabline.bg,
		},
		suffix = {
			fg = diag_info.fg,
			bg = tabline.bg,
		},
		breadcrumb = {
			fg = comment.fg,
			bg = normal.bg,
			italic = true,
		},
	}
end

--- @type mantel-nvim.HighlightGroups
local default_hl = {
	fill = "MantelFill",
	background = "MantelBackground",
	inactive = "MantelInactive",
	visible = "MantelVisible",
	active = "MantelActive",
	modified = "MantelModified",
	duplicate = "MantelDuplicate",
	error = "MantelError",
	warn = "MantelWarn",
	info = "MantelInfo",
	hint = "MantelHint",
	separator = "MantelSeparator",
	breadcrumb = "MantelBreadcrumb",
}

--- @type mantel-nvim.Opts
local default_config = {
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

	highlight_overwrites = get_default_highlights(),
}

local M = {}

--- @type mantel-nvim.Opts
M.opts = default_config

function M.set_opts(user_opts)
	M.opts = vim.tbl_deep_extend("force", {}, default_config, user_opts or {})
end

return M
