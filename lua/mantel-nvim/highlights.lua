local M = {}

function M.blend(fg, bg, alpha)
	return vim.api.nvim_get_color_by_name(string.format("#%06x", math.floor((1 - alpha) * fg + alpha * bg)))
end

--- @param opts mantel-nvim.Opts
function M.setup_autocmd(opts)
	vim.api.nvim_create_autocmd("ColorScheme", {
		callback = function()
			M.reload_colors(opts)
		end,
	})
end

function M.setup_cmd(opts)
	local const = require("mantel-nvim.constants")

	vim.api.nvim_create_user_command(const.prefix .. "ReloadColors", function()
		M.reload_colors(opts)
	end, {})
end

--- @param opts mantel-nvim.Opts
function M.reload_colors(opts)
	local get_default_highlights = require("mantel-nvim.config.default.highlight_overwrites")
	local const = require("mantel-nvim.constants")
	local utils = require("mantel-nvim.utils")

	if not opts or not opts.highlight_overwrites then
		return
	end

	local hl_overwrites = vim.tbl_deep_extend(
		"force",
		{},
		get_default_highlights(),
		utils.evaluate_table_option(opts.highlight_overwrites)
	)

	for key, hl in pairs(hl_overwrites) do
		local value = utils.evaluate_table_option(hl)

		--- @type string|nil
		local hl_group = const.hl_groups[key]

		if value and type(value) == "table" and hl_group then
			vim.api.nvim_set_hl(0, hl_group, value)
		end
	end

	M.setup_autocmd(opts)
end

return M
