local utils = require("mantel-nvim.utils")

local M = {}

--- @type mantel-nvim.State
M._state = {
	mode = "classic",
	buf_positions = {},
	next_position = 1,
}

function M.get_state()
	return M._state
end

function M.reset()
	M._state.buf_positions = {}
	M._state.next_position = 1
end

--- @param bypass_sorting boolean?
function M.get_bufs(bypass_sorting)
	local bufs = vim.fn.getbufinfo({ buflisted = 1 })

	if M._state.mode == "classic" or bypass_sorting == true then
		return bufs
	end

	for _, buf in ipairs(bufs) do
		M.add_buf(buf.bufnr)
	end

	table.sort(bufs, function(a, b)
		local pos_a = M._state.buf_positions[a.bufnr] or math.huge
		local pos_b = M._state.buf_positions[b.bufnr] or math.huge

		return pos_a < pos_b
	end)

	return bufs
end

--- @param bufnr integer
function M.add_buf(bufnr)
	local existing_position = M._state.buf_positions[bufnr]

	if not existing_position or type(existing_position) ~= "number" then
		M._state.buf_positions[bufnr] = M._state.next_position
		M._state.next_position = M._state.next_position + 1
	end
end

function M.sync_bufs()
	local bufs = M.get_bufs(true)
	local existing_bufs = {}

	for _, buf in ipairs(bufs) do
		existing_bufs[buf.bufnr] = true

		if not M._state.buf_positions[buf.bufnr] then
			M.add_buf(buf.bufnr)
		end
	end

	for bufnr in pairs(M._state.buf_positions) do
		if not existing_bufs[bufnr] then
			M._state.buf_positions[bufnr] = nil
		end
	end
end

function M.call_update()
	M.sync_bufs()

	vim.cmd("redrawtabline")
end

--- @param delta integer How much to move (positive for right, negative for left)
--- @param call_update boolean? Whether to trigger an update after
function M.go_to_buf_delta(delta, call_update)
	if M._state.mode ~= "enhanced" then
		utils.notify("Buffer movement is only available in 'enhanced' mode", vim.log.levels.WARN)
		return
	end

	local bufs = M.get_bufs()

	if #bufs <= 1 then
		return
	end

	local current_bufnr = vim.api.nvim_get_current_buf()

	--- @type integer|nil
	local target_index = nil

	for i, buf in ipairs(bufs) do
		if buf.bufnr == current_bufnr then
			target_index = i + delta
			break
		end
	end

	if target_index then
		if target_index < 1 then
			target_index = #bufs
		elseif target_index > #bufs then
			target_index = 1
		end

		if not bufs[target_index] then
			return
		end

		vim.api.nvim_set_current_buf(bufs[target_index].bufnr)
	end

	if call_update == true then
		M.call_update()
	end
end

--- @param delta integer How much to move
--- @param call_update boolean? Whether to trigger an update after moving
function M.move_current_buf(delta, call_update)
	if M._state.mode ~= "enhanced" then
		utils.notify("Buffer movement is only available in 'enhanced' mode", vim.log.levels.WARN)
		return
	end

	local current_bufnr = vim.api.nvim_get_current_buf()
	local current_position = M._state.buf_positions[current_bufnr]

	if delta == 0 or delta < -1 or delta > 1 then
		return
	end

	if not current_position then
		M.add_buf(current_bufnr)
		M.move_current_buf(delta, call_update)

		return
	end

	if #M._state.buf_positions <= 1 then
		return
	end

	local new_position = current_position + delta

	for bufnr, pos in pairs(M._state.buf_positions) do
		if pos == new_position then
			M._state.buf_positions[bufnr] = current_position
			break
		end
	end

	M._state.buf_positions[current_bufnr] = new_position

	if call_update == true then
		M.call_update()
	end
end

function M.setup_cmds()
	vim.api.nvim_create_user_command("MantelBufNext", function()
		M.go_to_buf_delta(1, true)
	end, {})

	vim.api.nvim_create_user_command("MantelBufPrev", function()
		M.go_to_buf_delta(-1, true)
	end, {})

	vim.api.nvim_create_user_command("MantelMoveBufLeft", function()
		M.move_current_buf(-1, true)
	end, {})

	vim.api.nvim_create_user_command("MantelMoveBufRight", function()
		M.move_current_buf(1, true)
	end, {})
end

--- @param opts mantel-nvim.Opts
function M.init(opts)
	M.reset()
	M._state.mode = opts.mode

	M.setup_cmds()
end

return M
