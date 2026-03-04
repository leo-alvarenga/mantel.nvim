local M = {}

--- @param diff integer
local function get_left_spacing(diff)
	return string.rep(" ", math.max(0, vim.o.columns - diff))
end

--- @param opts mantel-nvim.Opts
function M.render(opts)
	local buffers = require("mantel-nvim.ui.components.buffers")
	local tabs = require("mantel-nvim.ui.components.tabs")

	local line = ""
	local len = 0

	local bufs_part, bufs_len = buffers.get(opts)
	line = line .. bufs_part
	len = len + bufs_len

	local tabs_part, tabs_len = tabs.get(opts)
	line = line .. get_left_spacing(len + tabs_len) .. tabs_part

	return line
end

return M
