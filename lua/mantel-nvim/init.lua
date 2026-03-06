local lazy = require("mantel-nvim.lazy")
local config = require("mantel-nvim.config")

local highlights = require("mantel-nvim.highlights")
local ui = lazy.require("mantel-nvim.ui")

local M = {}

M.patch = "0"
M.minor = "7"
M.major = "0"

M.version = M.major .. "." .. M.minor .. "." .. M.patch

function M.render()
	return ui.render(config.opts)
end

--- @param opts mantel-nvim.Opts
function M.setup(opts)
	config.set_opts(opts)

	highlights.setup_cmd(config.opts)
	highlights.setup_autocmd(config.opts)
	highlights.reload_colors(config.opts)

	vim.o.showtabline = 2
	vim.o.tabline = "%!v:lua.require'mantel-nvim'.render()"
end

M.helpers = {
	lazy = lazy,
}

return M
