local utils = require("mantel-nvim.utils")

local decorators = require("mantel-nvim.ui.components.buffers.decorators")

local hl = utils.hl

local M = {}

M._private = {}

function M._private.get_bufs()
	local state = require("mantel-nvim.state")
	return state.get_bufs()
end

--- @param opts mantel-nvim.Opts
--- @param buf vim.fn.getbufinfo.ret.item
--- @param is_current boolean
--- @param is_ambiguos boolean
--- @return string res, integer len
function M._private.render_buf(opts, buf, is_current, is_ambiguos)
	local modified = buf.changed == 1

	local name = buf.name

	if name == "" then
		name = utils.evaluate_buf_aware_option(opts.bufs.overwrites.no_name, buf)
	elseif is_ambiguos then
		name = utils.evaluate_buf_aware_option(opts.bufs.overwrites.ambiguos, buf)
	else
		name = utils.evaluate_buf_aware_option(opts.bufs.overwrites.name, buf)
	end

	local name_before, name_after = decorators.get_name_decorators(opts, buf, modified, is_ambiguos)
	local prefix, prefix_len = decorators.get_prefix(opts, buf, is_ambiguos, modified)
	local suffix, suffix_len = decorators.get_suffix(opts, buf, is_ambiguos, modified)

	name = name_before .. name .. name_after
	local part = prefix .. utils.center_text(name, opts.bufs.min_width - prefix_len - suffix_len) .. suffix
	local len = #part

	if is_current then
		part = hl(opts.bufs.hl.active) .. part .. hl(opts.bufs.hl.inactive)
	else
		part = hl(opts.bufs.hl.inactive) .. part
	end

	return part, len
end

--- @param opts mantel-nvim.Opts
--- @return string part, integer len
function M.get(opts)
	local part = ""
	local total_len = 0

	local bufs = M._private.get_bufs()

	for i, buf in ipairs(bufs) do
		local buf_text, len =
			M._private.render_buf(opts, buf, buf.bufnr == vim.api.nvim_get_current_buf(), #vim.tbl_filter(function(b)
				return utils.evaluate_buf_aware_option(opts.bufs.overwrites.name, b)
					== utils.evaluate_buf_aware_option(opts.bufs.overwrites.name, buf)
			end, bufs) > 1)

		part = part .. buf_text
		total_len = total_len + len

		if i == #bufs then
			part = part .. hl(opts.bufs.hl.fill)
		elseif opts.bufs.decorators.sep then
			local sep = utils.evaluate_buf_aware_option(opts.bufs.decorators.sep, buf)

			part = part .. hl(opts.bufs.hl.separator) .. sep
			total_len = total_len + #sep
		end
	end

	return part, total_len
end

return M
