local helpers = require("mantel-nvim.ui.components.buffers.helpers")
local utils = require("mantel-nvim.utils")

local M = {}

--- @param opts mantel-nvim.Opts
--- @param buf vim.fn.getbufinfo.ret.item
--- @param modified boolean
--- @param is_ambiguos boolean
--- @return string before, string after, integer before_len, integer after_len
function M.get_name_decorators(opts, buf, modified, is_ambiguos)
	local name_before, name_before_len = helpers.add_decorators(opts, buf, "name_before", is_ambiguos, modified)
	local name_after, name_after_len = helpers.add_decorators(opts, buf, "name_after", is_ambiguos, modified)

	return name_before, name_after, name_after_len, name_before_len
end

--- @param opts mantel-nvim.Opts
--- @param buf vim.fn.getbufinfo.ret.item
--- @param duplicate boolean
--- @param modified boolean
--- @return string part, integer len
function M.get_prefix(opts, buf, duplicate, modified)
	local decorators, decorators_len = helpers.add_decorators(opts, buf, "prefix", duplicate, modified)
	local prefix = utils.evaluate_buf_aware_option(opts.bufs.decorators.prefix, buf)

	local len = #prefix + decorators_len

	if len <= 0 then
		return "", 0
	end

	return prefix .. decorators, len
end

--- @param opts mantel-nvim.Opts
--- @param buf vim.fn.getbufinfo.ret.item
--- @param duplicate boolean
--- @param modified boolean
--- @return string part, integer len
function M.get_suffix(opts, buf, duplicate, modified)
	local decorators, decorators_len = helpers.add_decorators(opts, buf, "suffix", duplicate, modified)
	local suffix = utils.evaluate_buf_aware_option(opts.bufs.decorators.suffix, buf)

	local len = #suffix + decorators_len

	if len <= 0 then
		return "", 0
	end

	return decorators .. suffix, len
end

return M
