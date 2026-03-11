--- @param buf vim.fn.getbufinfo.ret.item
--- @return string?
local function try_nvim_web_devicons(buf)
	local ok, icons = pcall(require, "nvim-web-devicons")

	if not ok then
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

	return icon .. " "
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

	return icon .. " "
end

--- @type mantel-nvim.PositionableDecorator
return {
	name = "fileicon",
	order = 1,
	position = "prefix",
	--- @type fun(buf: vim.fn.getbufinfo.ret.item): string
	text = function(buf)
		local icon = try_nvim_web_devicons(buf) or try_mini_icons(buf)

		return icon or ""
	end,
}
