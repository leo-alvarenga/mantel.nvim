local config = require("mantel-nvim.config")

local M = {}

M._private = {}

--- @param tab_count integer
function M._private.is_enabled(tab_count)
	if config.opts.tabs.enabled == "auto" then
		return tab_count > 1
	end

	return config.opts.tabs.enabled ~= false and config.opts.tabs.enabled ~= "never"
end

function M._private.get_tabs()
	return vim.fn.gettabinfo()
end

--- @param tab table
--- @param is_current boolean
--- @return string res, integer len
function M._private.render_tab(tab, is_current)
	local utils = require("mantel-nvim.utils")
	local hl = utils.hl

	local label = utils.center_text({ text = tostring(tab.tabnr or "?"), width = config.opts.tabs.min_width })

	if is_current then
		return hl(config.opts.tabs.hl.active) .. label .. hl(config.opts.tabs.hl.inactive), utils.strlen(label)
	end

	return hl(config.opts.tabs.hl.inactive) .. label, utils.strlen(label)
end

--- @return string part, integer len
function M.get()
	local part = ""
	local total_len = 0
	local tabs = M._private.get_tabs()

	if not M._private.is_enabled(#tabs) then
		return part, total_len
	end

	local current_tab = vim.api.nvim_get_current_tabpage()

	for _, tab in ipairs(tabs) do
		local tab_text, len = M._private.render_tab(tab, tab.tabnr == current_tab)

		part = part .. tab_text
		total_len = total_len + len
	end

	return part, total_len
end

return M
