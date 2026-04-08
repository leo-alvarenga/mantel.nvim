local M = {}

--- @param buf vim.fn.getbufinfo.ret.item
--- @return string?
local function try_nvim_web_devicons(buf)
	local ok, icons = pcall(require, "nvim-web-devicons")

	if not ok or not icons then
		return nil
	end

	if not icons.has_loaded() then
		return nil
	end

	local filename = vim.fn.fnamemodify(buf.name, ":t")
	local extension = vim.fn.fnamemodify(buf.name, ":e")
	local icon = icons.get_icon(filename, extension)

	if not icon then
		return nil
	end

	return icon
end

--- @param buf vim.fn.getbufinfo.ret.item
--- @return string?
local function try_mini_icons(buf)
	--- @diagnostic disable-next-line: undefined-global
	local icons = MiniIcons

	if not icons or type(icons) ~= "table" or type(icons.get) ~= "function" then
		return nil
	end

	local filename = vim.fn.fnamemodify(buf.name, ":t")
	local extension = vim.fn.fnamemodify(buf.name, ":e")

	local ok, icon = pcall(icons.get, filename, extension)

	if not ok or not icon then
		return nil
	end

	return icon
end

--- @param bufnr integer
--- @return string
function M.get_icon(bufnr)
	if not bufnr or not vim.api.nvim_buf_is_valid(bufnr) then
		return ""
	end

	local buf = vim.fn.getbufinfo(bufnr)[1]
	if not buf then
		return ""
	end

	return try_nvim_web_devicons(buf) or try_mini_icons(buf) or ""
end

return M
