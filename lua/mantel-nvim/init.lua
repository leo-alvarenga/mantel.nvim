local lazy = require("mantel-nvim.lazy")

local config = require("mantel-nvim.config")
local breadcrumbs = require("mantel-nvim.ui.breadcrumbs")
local highlights = require("mantel-nvim.highlights")
local tabline = require("mantel-nvim.ui.tabline")

local M = {}

M.patch = "0"
M.minor = "24"
M.major = "0"

M.version = M.major .. "." .. M.minor .. "." .. M.patch

function M.render()
	return tabline.render()
end

--- @param opts mantel-nvim.Opts
function M.setup(opts)
	local state = require("mantel-nvim.state")

	config.set_opts(opts)

	highlights.setup_cmd(config.opts)
	highlights.setup_autocmd(config.opts)
	highlights.reload_colors(config.opts)

	state.init()

	pcall(breadcrumbs.setup)
	pcall(tabline.setup)
end

M.helpers = {
	lazy = lazy,
}

return M
