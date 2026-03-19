local config = require("mantel-nvim.config")
local helpers = require("mantel-nvim.ui.tabline.components.buffers.helpers")
local utils = require("mantel-nvim.utils")

local M = {}

--- @param buf vim.fn.getbufinfo.ret.item
--- @return string before, string after, integer before_len, integer after_len
function M.get_name_decorators(buf)
	local name_before, name_before_len = helpers.add_decorators(buf, "name_before")
	local name_after, name_after_len = helpers.add_decorators(buf, "name_after")

	return name_before, name_after, name_after_len, name_before_len
end

--- @param buf vim.fn.getbufinfo.ret.item
--- @param is_first boolean
--- @return string part, integer len
function M.get_prefix(buf, is_first)
	local decorators, decorators_len = helpers.add_decorators(buf, "prefix")
	local prefix = utils.evaluate_buf_aware_option(config.opts.bufs.decorators.prefix, buf)

	local len = utils.strlen(prefix) + decorators_len

	if len <= 0 then
		return "", 0
	end

	if is_first and config.opts.style.ignore_first_buffer_prefix and config.opts.style.preset ~= "default" then
		local consts = require("mantel-nvim.constants")
		local preset = consts.styles[config.opts.style.preset]

		if preset and prefix == preset.prefix then
			return "", 0
		end
	end

	local hl = utils.buf_aware_hl(buf, config.opts.bufs.hl.prefix_inactive)

	if utils.is_current_buf(buf.bufnr) then
		hl = utils.buf_aware_hl(buf, config.opts.bufs.hl.prefix)
	end

	return hl .. prefix .. decorators, len
end

--- @param buf vim.fn.getbufinfo.ret.item
--- @return string part, integer len
function M.get_suffix(buf)
	local decorators, decorators_len = helpers.add_decorators(buf, "suffix")
	local suffix = utils.evaluate_buf_aware_option(config.opts.bufs.decorators.suffix, buf)

	local len = utils.strlen(suffix) + decorators_len

	if len <= 0 then
		return "", 0
	end

	local hl = utils.buf_aware_hl(buf, config.opts.bufs.hl.suffix_inactive)

	if utils.is_current_buf(buf.bufnr) then
		hl = utils.buf_aware_hl(buf, config.opts.bufs.hl.suffix)
	end

	return decorators .. hl .. suffix, len
end

return M
