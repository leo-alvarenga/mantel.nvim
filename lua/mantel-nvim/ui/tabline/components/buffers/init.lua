local config = require("mantel-nvim.config")
local debug = require("mantel-nvim.debug")
local state = require("mantel-nvim.state")
local utils = require("mantel-nvim.utils")

local _buffer = require("mantel-nvim.ui.tabline.components.buffers.buffer")

local M = {}

M._private = {}

--- @return string part, integer len
function M.get()
	local part = ""
	local total_len = 0

	local max_len = vim.o.columns

	local bufs = state.get_bufs()

	debug.log({ "Starting buffer render now for " .. #bufs .. " buffers" })
	debug.start_timer("render_buffers")

	for i, buf in ipairs(bufs) do
		local is_current = utils.is_current_buf(buf.bufnr)

		local ambiguity_list = vim.tbl_filter(function(b)
			return utils.evaluate_buf_aware_option(config.opts.bufs.overwrites.name, b)
				== utils.evaluate_buf_aware_option(config.opts.bufs.overwrites.name, buf)
		end, bufs)

		local is_ambiguos = #ambiguity_list > 1

		local buf_text, remaining, len =
			_buffer.render_buf(buf, is_current, is_ambiguos, i < #bufs, i, max_len, "left-to-right")

		total_len = total_len + len
		max_len = remaining

		part = part .. buf_text

		if max_len <= 0 then
			debug.log({ "Max length reached, stopping buffer render" })
			break
		end
	end

	debug.log_timer("render_buffers")

	return part, total_len
end

return M
