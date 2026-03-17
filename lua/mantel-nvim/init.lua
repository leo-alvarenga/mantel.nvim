local lazy = require("mantel-nvim.lazy")
local config = require("mantel-nvim.config")
local state = require("mantel-nvim.state")

local highlights = require("mantel-nvim.highlights")
local tabline = lazy.require("mantel-nvim.ui.tabline")
local winbar = lazy.require("mantel-nvim.ui.breadcrumbs")

local M = {}

M.patch = "0"
M.minor = "22"
M.major = "0"

M.version = M.major .. "." .. M.minor .. "." .. M.patch

function M.render()
	return tabline.render(config.opts)
end

--- @param opts mantel-nvim.Opts
function M.setup(opts)
	config.set_opts(opts)

	highlights.setup_cmd(config.opts)
	highlights.setup_autocmd(config.opts)
	highlights.reload_colors(config.opts)

	state.init(config.opts)

	if winbar and config.opts.breadcrumbs.enabled then
		pcall(winbar.setup_winbar, config.opts)
	end

	if not config.opts.style.preset or config.opts.style.preset == "disabled" then
		return
	end

	vim.o.showtabline = 2
	vim.o.tabline = "%!v:lua.require'mantel-nvim'.render()"
end

M.helpers = {
	lazy = lazy,
}

return M
