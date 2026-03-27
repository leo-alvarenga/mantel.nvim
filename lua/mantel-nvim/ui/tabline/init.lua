local buffers = require("mantel-nvim.ui.tabline.components.buffers")
local config = require("mantel-nvim.config")
local debug = require("mantel-nvim.debug")
local tabs = require("mantel-nvim.ui.tabline.components.tabs")
local utils = require("mantel-nvim.utils")

local M = {}

--- @param diff integer
--- @param hl string?
local function get_left_spacing(diff, hl)
	return (hl and utils.hl(hl) or "") .. string.rep(" ", math.max(0, vim.o.columns - diff))
end

function M.render()
	local max_len = vim.o.columns

	debug.clear_log()
	debug.start_timer("render_tabline")
	local tabs_part, tabs_len = tabs.get()
	max_len = max_len - tabs_len

	local buffers_part, buffers_len = buffers.get(max_len)
	local padding = ""

	if tabs_len > 0 or buffers_len < max_len then
		padding = get_left_spacing(buffers_len + tabs_len, config.opts.tabline.hl.fill)
	end

	local line = buffers_part .. padding .. tabs_part
	vim.schedule(function()
		vim.notify_once(
			vim.inspect({ tabs_len, max_len, vim.o.columns, buffers_len }),
			vim.log.levels.INFO,
			{ title = "Mantel Debug" }
		)
	end)

	debug.log_timer("render_tabline")

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
