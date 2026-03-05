local config = require("mantel-nvim.config")
local consts = require("mantel-nvim.constants")
local highlights = require("mantel-nvim.highlights")
local ui = require("mantel-nvim.ui")

local M = {}

M.patch = "0"
M.minor = "2"
M.major = "0"

M.version = M.major .. "." .. M.minor .. "." .. M.patch

function M.render()
	return ui.render(config.opts)
end

--- @param opts mantel-nvim.Opts
function M.setup(opts)
	config.set_opts(opts)
	highlights.setup()

	vim.o.showtabline = 2
	vim.o.tabline = "%!v:lua.require'mantel-nvim'.render()"
end

return M
