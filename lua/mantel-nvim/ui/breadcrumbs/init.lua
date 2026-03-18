local utils = require("mantel-nvim.utils")

local M = {}

--- @param winid integer?
function M.is_win_valid(winid)
	if not winid or not vim.api.nvim_win_is_valid(winid) then
		return false
	end

	local win_cfg = vim.api.nvim_win_get_config(winid)
	local is_win_floating = win_cfg.relative ~= ""

	local curr_buf = vim.api.nvim_win_get_buf(winid)
	local bufinfo = vim.bo[curr_buf]

	local is_buf_valid = vim.api.nvim_buf_is_valid(curr_buf)
		and bufinfo
		and bufinfo.buflisted
		and bufinfo.filetype ~= ""
		and bufinfo.buftype == ""

	return not is_win_floating and is_buf_valid
end

--- @param opts mantel-nvim.Opts
--- @param winid integer?
function M.render(opts, winid)
	local contents = ""

	if not winid or not M.is_win_valid(winid) then
		vim.wo[winid].winbar = contents
		return contents
	end

	local bufid = vim.api.nvim_win_get_buf(winid)
	local buf = vim.fn.getbufinfo(bufid)[1]

	local win_width = vim.api.nvim_win_get_width(winid)

	--- @type mantel-nvim.BreadcrumbPart[]
	local parts = {}
	local raw_parts = opts.breadcrumbs.parts

	if type(raw_parts) == "function" then
		parts = raw_parts(buf)
	elseif type(raw_parts) == "table" then
		parts = raw_parts
	end

	local active_hl = utils.evaluate_buf_aware_option(opts.breadcrumbs.hl.breadcrumb_item_focus, buf)
	local item_hl = utils.evaluate_buf_aware_option(opts.breadcrumbs.hl.breadcrumb_item, buf)
	local fill_hl = utils.evaluate_buf_aware_option(opts.breadcrumbs.hl.breadcrumb_fill, buf)
	local sep_hl = utils.evaluate_buf_aware_option(opts.breadcrumbs.hl.breadcrumb_separator, buf)

	local len = 0
	local expected_total_len = 0
	for i = #parts, 1, -1 do
		::continue::
		local part = parts[i]

		local text = utils.evaluate_buf_aware_option(part.text, buf)
		if part.len <= 0 then
			goto continue
		end

		expected_total_len = len
			+ opts.breadcrumbs.padding_left
			+ opts.breadcrumbs.padding_right
			+ utils.strlen(opts.ellipsis)
			+ part.len

		if expected_total_len >= win_width then
			contents = utils.hl(item_hl) .. opts.ellipsis .. contents
			break
		end

		if part.focused then
			text = utils.hl(active_hl) .. text
		else
			text = utils.hl(item_hl) .. text
		end

		len = len + part.len
		contents = text .. contents

		if i > 1 then
			local sep = utils.evaluate_buf_aware_option(opts.breadcrumbs.sep, buf)

			len = len + utils.strlen(sep)
			contents = utils.hl(sep_hl) .. sep .. contents
		end
	end

	contents = utils.hl(fill_hl) .. string.rep(" ", opts.breadcrumbs.padding_left) .. contents
	contents = contents .. utils.hl(fill_hl) .. string.rep(" ", opts.breadcrumbs.padding_right)

	vim.wo[winid].winbar = contents
	return contents
end

--- @param opts mantel-nvim.Opts
function M.setup_winbar(opts)
	local consts = require("mantel-nvim.constants")
	local augroup = vim.api.nvim_create_augroup(consts.augrops.winbar, { clear = true })

	vim.api.nvim_create_autocmd({ "WinNew", "BufWinEnter", "WinEnter" }, {
		group = augroup,
		callback = function()
			M.render(opts, vim.api.nvim_get_current_win())
		end,
	})
end

return M
