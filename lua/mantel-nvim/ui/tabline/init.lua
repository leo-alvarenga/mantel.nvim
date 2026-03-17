local lazy = require("mantel-nvim.lazy")

local utils = lazy.require("mantel-nvim.utils")
local buffers = lazy.require("mantel-nvim.ui.tabline.components.buffers")
local tabs = lazy.require("mantel-nvim.ui.tabline.components.tabs")

local M = {}

--- @param diff integer
--- @param hl string?
local function get_left_spacing(diff, hl)
	return (hl and utils.hl(hl) or "") .. string.rep(" ", math.max(0, vim.o.columns - diff))
end

--- @param opts mantel-nvim.Opts
--- @param line string
--- @param component fun(opts: mantel-nvim.Opts): (string, integer)
--- @param prev_len integer
--- @return string line, integer len
local function add_component(opts, line, component, prev_len)
	local part, part_len = component(opts)

	return line .. part, prev_len + part_len
end

--- @param opts mantel-nvim.Opts
function M.render(opts)
	local line = ""
	local len = 0

	line, len = add_component(opts, line, buffers.get, 0)
	line = add_component(opts, line, function(opts_cpy)
		-- Wrap the tabs component in a function to get the length of the tabs part, so we can calculate the padding correctly
		local tabs_part, tabs_len = tabs.get(opts_cpy)
		local padding = get_left_spacing(len + tabs_len, opts.tabs.hl.fill)

		return padding .. tabs_part, tabs_len
	end, len)

	return line
end

return M
