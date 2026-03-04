local hl = require("mantel-nvim.utils").hl

local M = {}

M._private = {}

function M._private.get_bufs()
	return vim.fn.getbufinfo({ buflisted = 1 })
end

--- @param opts mantel-nvim.Opts
--- @param buf vim.fn.getbufinfo.ret.item
--- @param is_current boolean
--- @param is_ambiguos boolean
--- @return string res, integer len
function M._private.render_buf(opts, buf, is_current, is_ambiguos)
	local part = ""

	local name = buf.name

	if name == "" then
		name = "[No Name]"
	end

	if is_ambiguos then
		name = vim.fn.fnamemodify(name, ":.")
	else
		name = vim.fn.fnamemodify(name, ":t")
	end

	part = part .. " " .. name .. " "
	local len = #part

	if is_current then
		part = hl(opts.hl.tabline_sel) .. part .. hl(opts.hl.tabfill)
	else
		part = hl(opts.hl.tabfill) .. part
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

	for _, buf in ipairs(bufs) do
		local buf_text, len = M._private.render_buf(opts, buf, buf.bufnr == current_buf, #vim.tbl_filter(function(b)
			return vim.fn.fnamemodify(b.name, ":t") == vim.fn.fnamemodify(buf.name, ":t")
		end, bufs) > 1)

		part = part .. buf_text
		total_len = total_len + len
	end

	return part, total_len
end

return M
