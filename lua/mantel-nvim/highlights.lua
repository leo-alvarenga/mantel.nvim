local M = {}

--- @param name string
--- @return table
function M.get_hl(name)
	local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = name, link = false })

	if not ok then
		return {}
	end

	return hl
end

function M.get_default_highlights()
	local normal = M.get_hl("Normal")
	local comment = M.get_hl("Comment")
	local statusline = M.get_hl("StatusLine")
	local tabsel = M.get_hl("TabLineSel")
	local tabline = M.get_hl("TabLine")

	local diag_info = M.get_hl("DiagnosticInfo")

	return {
		-- Tabline
		["MantelFill"] = {
			fg = tabline.fg,
			bg = statusline.bg,
		},
		["MantelInactive"] = {
			fg = comment.fg or tabsel.bg,
			bg = statusline.bg,
		},
		["MantelActive"] = {
			fg = diag_info.fg or statusline.fg,
			bg = normal.bg,
			bold = true,
			italic = true,
		},
		["MantelSeparator"] = {
			fg = diag_info.fg or statusline.fg,
			bg = statusline.bg,
		},
		["MantelEdge"] = {
			bg = normal.bg,
			fg = statusline.bg,
		},
		["MantelEdgeInactive"] = {
			fg = statusline.bg,
			bg = statusline.bg,
		},

		["MantelTabInactive"] = {
			fg = comment.fg or tabsel.bg,
			bg = normal.bg,
		},
		["MantelTabActive"] = {
			fg = diag_info.fg or statusline.fg,
			bg = normal.bg,
			bold = true,
		},

		-- Winbar
		["MantelBreadcrumbsFill"] = {
			fg = tabline.fg,
			bg = normal.bg,
		},
		["MantelBreadcrumbsItem"] = {
			fg = comment.fg or statusline.fg,
			bg = normal.bg,
		},
		["MantelBreadcrumbsItemFocus"] = {
			fg = diag_info.fg or statusline.fg,
			bg = normal.bg,
			bold = true,
			italic = true,
		},
		["MantelBreadcrumbsSeparator"] = {
			fg = comment.fg or statusline.fg,
			bg = normal.bg,
		},
	}
end

function M.load_colors()
	local highlights = M.get_default_highlights()

	for name, hl in pairs(highlights) do
		vim.api.nvim_set_hl(0, name, hl)
	end

	M.setup_autocmd()
	M.setup_cmd()
end

function M.setup_autocmd()
	vim.api.nvim_create_autocmd("ColorScheme", {
		callback = function()
			M.load_colors()
		end,
	})
end

function M.setup_cmd()
	vim.api.nvim_create_user_command("MantelReloadColors", function()
		M.load_colors()
	end, {})
end

return M
