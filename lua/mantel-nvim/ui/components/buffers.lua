local utils = require("mantel-nvim.utils")
local hl = utils.hl

local M = {}

M._private = {}

function M._private.get_bufs()
	return vim.fn.getbufinfo({ buflisted = 1 })
end

--- @param opts mantel-nvim.Opts
--- @param part string
--- @param duplicate boolean
--- @param modified boolean
--- @return string part, integer len
function M._private.add_prefix(opts, part, duplicate, modified)
	local decorators = utils.add_decorators(opts, "prefix", duplicate, modified)
	local prefix = decorators .. utils.evaluate_option(opts.bufs.decorators.prefix)

	local len = #prefix

	if len <= 0 then
		return part, 0
	end

	return prefix .. part, len
end

--- @param opts mantel-nvim.Opts
--- @param part string
--- @param duplicate boolean
--- @param modified boolean
--- @return string part, integer len
function M._private.add_suffix(opts, part, duplicate, modified)
	local decorators = utils.add_decorators(opts, "suffix", duplicate, modified)
	local suffix = utils.evaluate_option(opts.bufs.decorators.suffix) .. decorators

	local len = #suffix

	if len <= 0 then
		return part, 0
	end

	return part .. suffix, len
end

--- @param opts mantel-nvim.Opts
--- @param buf vim.fn.getbufinfo.ret.item
--- @param is_current boolean
--- @param is_ambiguos boolean
--- @param is_last boolean
--- @return string res, integer len
function M._private.render_buf(opts, buf, is_current, is_ambiguos, is_last)
	local modified = buf.changed == 1

	local name = buf.name

	if name == "" then
		name = utils.evaluate_buf_overwrite(opts.bufs.overwrites.no_name, buf)
	elseif is_ambiguos then
		name = utils.evaluate_buf_overwrite(opts.bufs.overwrites.ambiguos, buf)
	else
		name = utils.evaluate_buf_overwrite(opts.bufs.overwrites.name, buf)
	end

	name = M._private.add_prefix(opts, name, is_ambiguos, modified)
	name = M._private.add_suffix(opts, name, is_ambiguos, modified)

	local part = utils.center_text(" " .. name .. " ", opts.bufs.min_width)
	local len = #part

	if is_current then
		part = hl(opts.bufs.hl.active) .. part .. hl(opts.bufs.hl.inactive)
	else
		part = hl(opts.bufs.hl.inactive) .. part
	end

	if is_last then
		part = part .. hl(opts.bufs.hl.fill)
	elseif opts.bufs.decorators.sep then
		local sep = utils.evaluate_option(opts.bufs.decorators.sep)

		part = part .. hl(opts.bufs.hl.separator) .. sep
		len = len + #sep
	end

	return part, len
end

--- @param opts mantel-nvim.Opts
--- @return string part, integer len
function M.get(opts)
	local part = ""
	local total_len = 0

	local bufs = M._private.get_bufs()
	local current_buf = vim.api.nvim_get_current_buf()

	for i, buf in ipairs(bufs) do
		local buf_text, len = M._private.render_buf(opts, buf, buf.bufnr == current_buf, #vim.tbl_filter(function(b)
			return utils.evaluate_buf_overwrite(opts.bufs.overwrites.no_name, b)
				== utils.evaluate_buf_overwrite(opts.bufs.overwrites.no_name, buf)
		end, bufs) > 1, i == #bufs)

		part = part .. buf_text
		total_len = total_len + len
	end

	return part, total_len
end

return M
