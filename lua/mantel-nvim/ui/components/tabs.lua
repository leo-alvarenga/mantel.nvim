local utils = require("mantel-nvim.utils")
local hl = utils.hl

local M = {}

M._private = {}

--- @param opts mantel-nvim.Opts
--- @param tab_count integer
function M._private.is_enabled(opts, tab_count)
	if opts.tabs.enabled == "auto" then
		return tab_count > 1
	end

	return opts.tabs.enabled ~= false and opts.tabs.enabled ~= "never"
end

function M._private.get_tabs()
	return vim.fn.gettabinfo()
end

--- @param opts mantel-nvim.Opts
--- @param tab table
--- @param is_current boolean
--- @return string res, integer len
function M._private.render_tab(opts, tab, is_current)
	local label = utils.center_text(tostring(tab.tabnr or "?"), opts.tabs.min_width)

	if is_current then
		return hl(opts.hl.tabline_sel) .. label .. hl(opts.hl.tabfill), #label
	end

	return hl(opts.hl.tabfill) .. label, #label
end

--- @param opts mantel-nvim.Opts
--- @return string part, integer len
function M.get(opts)
	local part = ""
	local total_len = 0
	local tabs = M._private.get_tabs()

	if not M._private.is_enabled(opts, #tabs) then
		return part, total_len
	end

	local current_tab = vim.api.nvim_get_current_tabpage()

	for _, tab in ipairs(tabs) do
		local tab_text, len = M._private.render_tab(opts, tab, tab.tabnr == current_tab)

		part = part .. tab_text
		total_len = total_len + len
	end

	return part, total_len
end

return M
