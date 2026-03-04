local config = require("mantel-nvim.config")
local consts = require("mantel-nvim.constants")
local ui = require("mantel-nvim.ui")

local M = {}

M.patch = "1"
M.minor = "0"
M.major = "0"

M.version = M.major .. "." .. M.minor .. "." .. M.patch

function M.render()
	return ui.render(config.opts)
end

--- @param opts mantel-nvim.Opts
function M.setup(opts)
	config.set_opts(opts)

	vim.o.showtabline = 2
	vim.o.tabline = "%!v:lua.require'mantel-nvim'.render()"
end

return M
