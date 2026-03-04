local hl = require("mantel-nvim.utils").hl

local M = {}

M._private = {}

function M._private.get_tabs()
	return vim.fn.gettabinfo()
end

--- @param opts mantel-nvim.Opts
--- @param tab table
--- @param is_current boolean
--- @return string res, integer len
function M._private.render_tab(opts, tab, is_current)
	local label = tostring(tab.tabnr or "?")

	local width = 5
	local padding = math.max(0, math.floor((width - #label) / 2))
	label = string.rep(" ", padding) .. label .. string.rep(" ", width - padding - #label)

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

	if #tabs <= 1 then
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
