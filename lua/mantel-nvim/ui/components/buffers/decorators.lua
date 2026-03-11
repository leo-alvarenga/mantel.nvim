local helpers = require("mantel-nvim.ui.components.buffers.helpers")
local utils = require("mantel-nvim.utils")

local M = {}

--- @param opts mantel-nvim.Opts
--- @param buf vim.fn.getbufinfo.ret.item
--- @return string before, string after, integer before_len, integer after_len
function M.get_name_decorators(opts, buf)
	local name_before, name_before_len = helpers.add_decorators(opts, buf, "name_before")
	local name_after, name_after_len = helpers.add_decorators(opts, buf, "name_after")

	return name_before, name_after, name_after_len, name_before_len
end

--- @param opts mantel-nvim.Opts
--- @param buf vim.fn.getbufinfo.ret.item
--- @return string part, integer len
function M.get_prefix(opts, buf)
	local decorators, decorators_len = helpers.add_decorators(opts, buf, "prefix")
	local prefix = utils.evaluate_buf_aware_option(opts.bufs.decorators.prefix, buf)

	local len = #prefix + decorators_len

	if len <= 0 then
		return "", 0
	end

	local hl = utils.buf_aware_hl(buf, opts.bufs.hl.inactive)

	if utils.is_current_buf(buf.bufnr) then
		hl = utils.buf_aware_hl(buf, opts.bufs.hl.active)
	end

	return hl .. prefix .. "%*" .. decorators, len
end

--- @param opts mantel-nvim.Opts
--- @param buf vim.fn.getbufinfo.ret.item
--- @return string part, integer len
function M.get_suffix(opts, buf)
	local decorators, decorators_len = helpers.add_decorators(opts, buf, "suffix")
	local suffix = utils.evaluate_buf_aware_option(opts.bufs.decorators.suffix, buf)

	local len = #suffix + decorators_len

	if len <= 0 then
		return "", 0
	end

	local hl = utils.buf_aware_hl(buf, opts.bufs.hl.inactive)

	if utils.is_current_buf(buf.bufnr) then
		hl = utils.buf_aware_hl(buf, opts.bufs.hl.active)
	end

	return decorators .. hl .. suffix .. "%*", len
end

return M
