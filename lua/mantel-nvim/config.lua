--- @return mantel-nvim.HighlightOverwrites
local function get_default_highlights()
	local lazy = require("mantel-nvim.lazy")
	local utils = lazy.require("mantel-nvim.utils")

	local normal = utils.get_hl("Normal")
	local tabline = utils.get_hl("TabLine")
	local tabsel = utils.get_hl("TabLineSel")
	local fill = utils.get_hl("TabLineFill")
	local comment = utils.get_hl("Comment")

	local diag_error = utils.get_hl("DiagnosticError")
	local diag_warn = utils.get_hl("DiagnosticWarn")
	local diag_info = utils.get_hl("DiagnosticInfo")
	local diag_hint = utils.get_hl("DiagnosticHint")

	return {
		fill = {
			bg = fill.bg or tabline.bg,
		},
		background = {
			fg = tabline.fg,
			bg = tabline.bg,
		},
		inactive = {
			fg = tabline.fg,
			bg = tabline.bg,
		},
		visible = {
			fg = normal.fg,
			bg = tabline.bg,
		},
		active = {
			fg = tabsel.fg,
			bg = tabsel.bg,
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
		breadcrumb = {
			fg = comment.fg,
			bg = fill.bg or tabline.bg,
			italic = true,
		},
	}
end

local default_highlights = {
	MantelFill = { bg = "#000000" },
	MantelBackground = { fg = "#ffffff", bg = "#000000" },
	MantelInactive = { fg = "#cccccc", bg = "#222222" },
	MantelVisible = { fg = "#ffffff", bg = "#222222" },
	MantelActive = { fg = "#ffffff", bg = "#222222", bold = true },
	MantelModified = { fg = "#ff8800", bg = "#222222", italic = true },
	MantelDuplicate = { fg = "#888888", bg = "#222222" },
	MantelError = { fg = "#ff0000", bg = "#222222" },
	MantelWarn = { fg = "#ffaa00", bg = "#222222" },
	MantelInfo = { fg = "#00aaff", bg = "#222222" },
	MantelHint = { fg = "#00ff88", bg = "#222222" },
	MantelSeparator = { fg = "#888888", bg = "#222222" },
	MantelBreadcrumb = { fg = "#888888", bg = "#000000", italic = true },
}

--- @type mantel-nvim.Decorators
local default_decorators = {
	sep = "",
	prefix = "",
	suffix = "",
	modified = {
		enabled = true,
		order = 1,
		text = " ●",
		position = "suffix",
	},
}

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
