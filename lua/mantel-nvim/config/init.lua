local M = {}

local default_config = require("mantel-nvim.config.default")

--- @type mantel-nvim.Opts
M.opts = default_config

function M.set_opts(user_opts)
	M.opts = vim.tbl_deep_extend("force", {}, default_config, user_opts or {})

	if M.opts.style == "slanted" then
		M.opts.bufs.decorators.prefix = ""
		M.opts.bufs.decorators.suffix = ""
	elseif M.opts.style == "sloped" then
		M.opts.bufs.decorators.prefix = ""
		M.opts.bufs.decorators.suffix = ""
	end
end

return M
