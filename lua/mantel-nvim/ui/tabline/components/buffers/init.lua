local config = require("mantel-nvim.config")
local debug = require("mantel-nvim.debug")
local state = require("mantel-nvim.state")
local utils = require("mantel-nvim.utils")

local _buffer = require("mantel-nvim.ui.tabline.components.buffers.buffer")

local M = {}

--- @param buf vim.fn.getbufinfo.ret.item
--- @param i integer
--- @param bufs vim.fn.getbufinfo.ret.item[]
--- @param remaining integer
--- @param direction mantel-nvim.HorizontalDirection
--- @return string? text, integer remaining, integer len
function M.get_rendered_buffer(buf, bufs, i, remaining, direction)
	if not buf or not buf.bufnr then
		debug.log({ "Invalid buffer at index " .. i })

		return nil, remaining, 0
	end

	local is_current = utils.is_current_buf(buf.bufnr)

	local ambiguity_list = vim.tbl_filter(function(b)
		return utils.evaluate_buf_aware_option(config.opts.bufs.overwrites.name, b)
			== utils.evaluate_buf_aware_option(config.opts.bufs.overwrites.name, buf)
	end, bufs)

	local is_ambiguos = #ambiguity_list > 1

	local buf_text, _remaining, len =
		_buffer.render_buf(buf, is_current, is_ambiguos, i < #bufs, i, remaining, direction)

	if remaining <= 0 then
		debug.log({ "Max length reached, stopping buffer render" })
		return nil, 0, 0
	end

	return buf_text, _remaining, len
end

--- @param bufs vim.fn.getbufinfo.ret.item[]
--- @param direction mantel-nvim.HorizontalDirection
--- @param max_len integer
--- @param index_offset integer?
--- @return string part, integer total_len, integer remaining
function M.get_rendered_side(bufs, direction, max_len, index_offset)
	local part = ""
	local total_len = 0
	local is_reversed = direction == "right-to-left"

	if is_reversed then
		vim.fn.reverse(bufs)
	end

	for i, buf in ipairs(bufs) do
		if max_len <= 0 then
			break
		end

		local rendered_buf, remaining, len =
			M.get_rendered_buffer(buf, bufs, i + (index_offset or 0), max_len, direction)

		if not rendered_buf then
			break
		end

		total_len = total_len + len
		max_len = remaining

		if is_reversed then
			part = rendered_buf .. part
		else
			part = part .. rendered_buf
		end
	end

	return part, total_len, max_len
end

--- @return string part, integer len
function M.get()
	local bufs, current_buffer_index = state.get_bufs_and_current_index()

	if #bufs < 1 then
		return "", 0
	end

	if not current_buffer_index then
		current_buffer_index = 1
	end

	debug.log({ "Starting buffer render now for " .. #bufs .. " buffers" })
	debug.start_timer("render_buffers")

	local part = ""
	local total_len = 0

	local max_len = vim.o.columns

	local left_side_bufs = vim.list_slice(bufs, 1, current_buffer_index - 1)
	local right_side_bufs = vim.list_slice(bufs, current_buffer_index + 1)

	local rendered_current_buffer, remaining, len =
		M.get_rendered_buffer(bufs[current_buffer_index], bufs, current_buffer_index, max_len, "left-to-right")

	max_len = remaining
	total_len = total_len + len

	part = part .. (rendered_current_buffer or "")

	local max_left_len = max_len
	if #right_side_bufs > 0 then
		max_left_len = math.floor(max_len / 2)
	end

	local left_side, left_len, left_remaining_len = M.get_rendered_side(left_side_bufs, "right-to-left", max_left_len)

	-- Avoid rendering right side otherwise
	if #right_side_bufs > 0 then
		local max_right_len = max_len - max_left_len + math.max(0, left_remaining_len)
		local right_side, right_len, right_remaining_len =
			M.get_rendered_side(right_side_bufs, "left-to-right", max_right_len, current_buffer_index)

		-- Greedy recalculation; Still less expensive than adding more complex logic to the initial render loop
		if right_remaining_len > 0 then
			left_side = M.get_rendered_side(left_side_bufs, "right-to-left", max_left_len + right_remaining_len)
		end

		total_len = total_len + right_len
		part = part .. right_side
	end

	total_len = total_len + left_len
	part = left_side .. part

	debug.log_timer("render_buffers")

	return part, total_len
end

return M
