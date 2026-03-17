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

	local len = 0

	local active_hl = utils.evaluate_buf_aware_option(opts.breadcrumbs.hl.active, buf)
	local fill_hl = active_hl
	local sep_hl = active_hl

	for i, part in ipairs(parts) do
		::continue::

		local text = utils.evaluate_buf_aware_option(part.text, buf)
		if part.len <= 0 then
			goto continue
		end

		if i > 1 then
			local sep = utils.evaluate_buf_aware_option(opts.breadcrumbs.sep, buf)

			len = len + utils.strlen(sep)
			contents = contents .. utils.hl(sep_hl) .. sep
		end

		len = len + part.len
		contents = contents .. utils.hl(active_hl) .. text
	end

	local expected_total_len = len + opts.breadcrumbs.padding_left + opts.breadcrumbs.padding_right

	if expected_total_len > win_width then
		local diff = win_width - expected_total_len

		contents = opts.ellipsis .. string.sub(contents, diff + utils.strlen(opts.ellipsis))
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
