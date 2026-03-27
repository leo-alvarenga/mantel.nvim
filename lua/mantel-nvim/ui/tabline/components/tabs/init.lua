local config = require("mantel-nvim.config")
local utils = require("mantel-nvim.utils")

local M = {}

M._private = {}

--- @param tab_count integer
function M._private.is_enabled(tab_count)
	if config.opts.tabline.tabs.enabled == "auto" then
		return tab_count > 1
	end

	return config.opts.tabline.tabs.enabled ~= false and config.opts.tabline.tabs.enabled ~= "never"
end

function M._private.get_tabs()
	return vim.fn.gettabinfo()
end

--- @return string part, integer len
function M.get()
	local part = ""
	local total_len = 0
	local tabs = M._private.get_tabs()

	if not M._private.is_enabled(#tabs) then
		return part, total_len
	end

	local hl = ""
	for _, tab in ipairs(config.opts.tabline.tabs.content()) do
		hl = config.opts.tabline.hl.tab_inactive
		if tab.active then
			hl = config.opts.tabline.hl.tab_active
		end

		part = part .. utils.hl(hl) .. tab.text
		total_len = total_len + tab.len
	end

	local pl, pr =
		utils.get_padding_len(total_len, config.opts.tabline.tabs.min_width, config.opts.tabline.tabs.min_padding)
	total_len = total_len + pl + pr

	local prefix = utils.hl(config.opts.tabline.hl.prefix) .. config.opts.tabline.tabs.prefix
	total_len = total_len + utils.strlen(config.opts.tabline.tabs.prefix)

	hl = config.opts.tabline.hl.tab_inactive
	local padding_left = utils.hl(hl) .. string.rep(" ", pl)
	local padding_right = utils.hl(hl) .. string.rep(" ", pr)

	part = prefix .. padding_left .. part .. padding_right

	if not config.opts.style.ignore_tabs_suffix then
		local suffix = utils.hl(config.opts.tabline.hl.suffix) .. config.opts.tabline.tabs.suffix
		part = part .. suffix
		total_len = total_len + utils.strlen(config.opts.tabline.tabs.suffix)
	end

	local separator = config.opts.tabline.section_separator
	if separator and utils.strlen(separator) > 0 then
		part = utils.hl(config.opts.tabline.hl.section_separator) .. separator .. part
		total_len = total_len + utils.strlen(separator)
	end

	return part, total_len
end

return M
