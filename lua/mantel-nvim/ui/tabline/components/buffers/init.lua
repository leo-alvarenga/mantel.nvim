local config = require("mantel-nvim.config")
local decorators = require("mantel-nvim.ui.tabline.components.buffers.decorators")
local utils = require("mantel-nvim.utils")

local hl = utils.buf_aware_hl

local M = {}

M._private = {}

function M._private.get_bufs()
	local state = require("mantel-nvim.state")
	return state.get_bufs()
end

--- @param buf vim.fn.getbufinfo.ret.item
--- @param is_current boolean
--- @param is_ambiguos boolean
--- @param index integer
--- @return string res, integer len
function M._private.render_buf(buf, is_current, is_ambiguos, index)
	local name = buf.name
	local name_hl = config.opts.bufs.hl.inactive

	if is_current then
		name_hl = config.opts.bufs.hl.active
	end

	if name == "" then
		name = utils.evaluate_buf_aware_option(config.opts.bufs.overwrites.no_name, buf)
	elseif is_ambiguos then
		name = utils.evaluate_buf_aware_option(config.opts.bufs.overwrites.ambiguos, buf)
	else
		name = utils.evaluate_buf_aware_option(config.opts.bufs.overwrites.name, buf)
	end

	local name_before, name_after, name_before_len, name_after_len = decorators.get_name_decorators(buf)

	local prefix, prefix_len = decorators.get_prefix(buf, index == 1)
	local suffix, suffix_len = decorators.get_suffix(buf)

	local len = utils.strlen(name) + name_before_len + name_after_len
	name = hl(buf, name_hl) .. name

	local centered_name, padding_len = utils.center_text({
		text = name_before .. name .. name_after,
		width = config.opts.bufs.min_width - prefix_len - suffix_len,
		text_width = len,
		min_padding = config.opts.bufs.min_padding,
	})

	len = len + prefix_len + suffix_len + padding_len
	local part = prefix .. hl(buf, name_hl) .. centered_name .. suffix

	return part, len
end

--- @return string part, integer len
function M.get()
	local part = ""
	local total_len = 0

	local bufs = M._private.get_bufs()

	for i, buf in ipairs(bufs) do
		local is_current = utils.is_current_buf(buf.bufnr)

		local ambiguity_list = vim.tbl_filter(function(b)
			return utils.evaluate_buf_aware_option(config.opts.bufs.overwrites.name, b)
				== utils.evaluate_buf_aware_option(config.opts.bufs.overwrites.name, buf)
		end, bufs)

		local is_ambiguos = #ambiguity_list > 1

		local buf_text, len = M._private.render_buf(buf, is_current, is_ambiguos, i)

		part = part .. buf_text
		total_len = total_len + len
		local sep = utils.evaluate_buf_aware_option(config.opts.bufs.decorators.sep or "", buf)

		if i == #bufs then
			part = part .. hl(buf, config.opts.bufs.hl.active)
		elseif utils.strlen(sep) > 0 then
			part = part .. hl(buf, config.opts.bufs.hl.separator) .. sep
			total_len = total_len + utils.strlen(sep)
		end
	end

	return part, total_len
end

return M
