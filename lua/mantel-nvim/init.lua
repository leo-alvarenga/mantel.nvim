local lazy = require("mantel-nvim.lazy")
local config = require("mantel-nvim.config")

local ui = lazy.require("mantel-nvim.ui")

local M = {}

M.patch = "1"
M.minor = "6"
M.major = "0"

M.version = M.major .. "." .. M.minor .. "." .. M.patch

function M.render()
	return ui.render(config.opts)
end

--- @param opts mantel-nvim.Opts
function M.setup(opts)
	local highlights = require("mantel-nvim.highlights")

	config.set_opts(opts)

	highlights.setup(config.opts)

	vim.o.showtabline = 2
	vim.o.tabline = "%!v:lua.require'mantel-nvim'.render()"
end

M.helpers = {
	lazy = lazy,
}

return M
