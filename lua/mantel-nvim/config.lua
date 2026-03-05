--- @type mantel-nvim.HL
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
		min_width = 10,
		no_name_overwrite = "[No name]",
		hl = default_hl,
	},
	tabs = {
		enabled = "auto",
		min_width = 5,
		hl = default_hl,
	},
}

local M = {}

--- @type mantel-nvim.Opts
M.opts = default_config

function M.set_opts(user_opts)
	M.opts = vim.tbl_deep_extend("force", {}, default_config, user_opts or {})
end

return M
