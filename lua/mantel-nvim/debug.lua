local config = require("mantel-nvim.config")

local M = {}

M.log_file = vim.fs.joinpath(vim.fn.stdpath("log"), "mantel-nvim.log")
M.file = io.open(M.log_file, "w+")

vim.api.nvim_create_autocmd("VimLeave", {
	callback = function()
		if M and M.file then
			M.file:close()
		end
	end,
})

--- @type table<string, number>
M.timers = {}

--- @param msgs any[]
function M.log(msgs)
	if not config.opts.debug then
		return
	end

	if not M.file then
		return
	end

	for _, arg in ipairs(msgs) do
		local line = os.date("%Y-%m-%d %H:%M:%S") .. " - "

		if type(arg) == "table" then
			line = line .. vim.inspect(arg)
		else
			line = line .. tostring(arg)
		end

		M.file:write("[mantel-nvim] " .. line .. "\n")
	end

	M.file:flush()
end

--- @param name string
function M.start_timer(name)
	if not config.opts.debug then
		return
	end

	--- @diagnostic disable-next-line
	local start = vim.uv.hrtime()
	M.timers[name] = start

	return start
end

--- @param name string
function M.stop_timer(name)
	if not config.opts.debug then
		return
	end

	local start = M.timers[name]
	if not start then
		return nil
	end

	--- @diagnostic disable-next-line
	local stop = vim.uv.hrtime()
	local elapsed = stop - start

	M.timers[name] = nil

	return elapsed
end

--- @param name string
function M.log_timer(name)
	if not config.opts.debug then
		return
	end

	local elapsed = M.stop_timer(name)
	if not elapsed then
		return
	end

	local elapsed_ms = string.format("%.4f", elapsed / 1e6)
	M.log({ name .. " took " .. elapsed_ms .. " ms" })
end

return M
