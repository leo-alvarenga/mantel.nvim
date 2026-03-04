--- @type mantel-nvim.Opts
local default_config = {
	hl = {
		tabline_sel = "TabLineSel",
		tabfill = "TabFill",
		tabline = "TabLine",
		tabsep = "TabSep",
	},
}

local M = {}

--- @type mantel-nvim.Opts
M.opts = default_config

function M.set_opts(user_opts)
	M.opts = vim.tbl_deep_extend("force", {}, default_config, user_opts or {})
end

return M
