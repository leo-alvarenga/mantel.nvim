local config = require("mantel-nvim.config")
local buffers = require("mantel-nvim.ui.tabline.components.buffers")
local tabs = require("mantel-nvim.ui.tabline.components.tabs")
local utils = require("mantel-nvim.utils")

local M = {}

--- @param diff integer
--- @param hl string?
local function get_left_spacing(diff, hl)
	return (hl and utils.hl(hl) or "") .. string.rep(" ", math.max(0, vim.o.columns - diff))
end

--- @param line string
--- @param component fun(): (string, integer)
--- @param prev_len integer
--- @return string line, integer len
local function add_component(line, component, prev_len)
	local part, part_len = component()

	return line .. part, prev_len + part_len
end

function M.render()
	local line = ""
	local len = 0

	line, len = add_component(line, buffers.get, 0)
	line = add_component(line, function()
		-- Wrap the tabs component in a function to get the length of the tabs part, so we can calculate the padding correctly
		local tabs_part, tabs_len = tabs.get()
		local padding = get_left_spacing(len + tabs_len, config.opts.tabs.hl.fill)

		return padding .. tabs_part, tabs_len
	end, len)

	return line
end

function M.setup()
	if not config.opts.style.preset or config.opts.style.preset == "disabled" then
		return
	end

	vim.o.showtabline = 2
	vim.o.tabline = "%!v:lua.require'mantel-nvim'.render()"
end

return M
