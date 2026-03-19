local M = {}

local default_config = require("mantel-nvim.config.default")

--- @type mantel-nvim.Opts
M.opts = default_config

function M.apply_style()
	local consts = require("mantel-nvim.constants")

	local preset = consts.styles[M.opts.style.preset]
	if preset then
		M.opts.bufs.decorators.prefix = preset.prefix
		M.opts.bufs.decorators.suffix = preset.suffix
	end
end

function M.set_opts(user_opts)
	M.opts = vim.tbl_deep_extend("force", {}, default_config, user_opts or {})

	M.apply_style()
end

function M.get_opts()
	return M.opts
end

return M
