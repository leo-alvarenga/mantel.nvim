local lazy = require("mantel-nvim.lazy")
local config = require("mantel-nvim.config")
local state = require("mantel-nvim.state")

local highlights = require("mantel-nvim.highlights")
local tabline = lazy.require("mantel-nvim.ui.tabline")

local M = {}

M.patch = "0"
M.minor = "16"
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

	if opts.displayWarning then
		vim.schedule(function()
			vim.notify_once(
				"This plugins IS NOT meant for daily use. It is a playground for testing out ideas and concepts ",
				vim.log.levels.WARN,
				{ title = "mantel-nvim", timeout = 8000 }
			)

			vim.notify_once(
				"Even though it may be stable, it is certainly NOT the best approach for it. Use at your own risk",
				vim.log.levels.WARN,
				{ title = "mantel-nvim", timeout = 8000 }
			)

			vim.notify_once(
				"Disable this warning by setting `disableWarning` to `true` in the setup options",
				vim.log.levels.WARN,
				{ title = "mantel-nvim", timeout = 8000 }
			)
		end)
	end

	vim.o.showtabline = 2
	vim.o.tabline = "%!v:lua.require'mantel-nvim'.render()"
end

M.helpers = {
	lazy = lazy,
}

return M
