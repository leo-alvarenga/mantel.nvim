local helpers = require("mantel-nvim.ui.components.buffers.helpers")
local utils = require("mantel-nvim.utils")

--- @param opts mantel-nvim.Opts
--- @param buf vim.fn.getbufinfo.ret.item
--- @param duplicate boolean
--- @param modified boolean
--- @return string part, integer len
return function(opts, buf, duplicate, modified)
	local decorators, decorators_len = helpers.add_decorators(opts, buf, "suffix", duplicate, modified)
	local suffix = utils.evaluate_buf_aware_option(opts.bufs.decorators.suffix, buf)

	local len = #suffix + decorators_len

	if len <= 0 then
		return "", 0
	end

	return decorators .. suffix, len
end
