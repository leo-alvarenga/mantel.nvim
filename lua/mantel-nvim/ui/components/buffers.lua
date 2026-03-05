local utils = require("mantel-nvim.utils")
local hl = utils.hl

local M = {}

M._private = {}

function M._private.get_bufs()
	return vim.fn.getbufinfo({ buflisted = 1 })
end

--- @param opts mantel-nvim.Opts
--- @param buf vim.fn.getbufinfo.ret.item
--- @param is_current boolean
--- @param is_ambiguos boolean
--- @param is_last boolean
--- @return string res, integer len
function M._private.render_buf(opts, buf, is_current, is_ambiguos, is_last)
	local name = buf.name
	local prefix = utils.evaluate_option(opts.bufs.decorators.prefix)
	local suffix = utils.evaluate_option(opts.bufs.decorators.suffix)

	if buf.changed == 1 then
		prefix = prefix .. " ●"
	end

	if name == "" then
		name = utils.evaluate_option(opts.bufs.no_name_overwrite)
	end

	if is_ambiguos then
		name = vim.fn.fnamemodify(name, ":.")
	else
		name = vim.fn.fnamemodify(name, ":t")
	end

	local part = utils.center_text(" " .. name .. " ", opts.bufs.min_width)
	part = prefix .. part .. suffix

	local len = #part + #prefix + #suffix

	if is_current then
		part = hl(opts.bufs.hl.active) .. part .. hl(opts.bufs.hl.inactive)
	else
		part = hl(opts.bufs.hl.inactive) .. part
	end

	if is_last then
		part = part .. hl(opts.bufs.hl.fill)
	else
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
			return vim.fn.fnamemodify(b.name, ":t") == vim.fn.fnamemodify(buf.name, ":t")
		end, bufs) > 1, i == #bufs)

		part = part .. buf_text
		total_len = total_len + len
	end

	return part, total_len
end

return M
