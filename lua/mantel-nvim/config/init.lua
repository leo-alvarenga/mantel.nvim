local utils = require("mantel-nvim.utils")

local M = {}

local default_config = require("mantel-nvim.config.default")

--- @type mantel-nvim.Opts
M.opts = default_config

--- @type mantel-nvim.ConfigCache
M.cache = {
	decorators = {
		prefix = {},
		suffix = {},
		name_before = {},
		name_after = {},
	},
}

function M.apply_style()
	local consts = require("mantel-nvim.constants")

	local preset = consts.styles[M.opts.style.preset]
	if preset then
		M.opts.tabline.bufs.decorators.prefix = preset.prefix
		M.opts.tabline.bufs.decorators.suffix = preset.suffix

		M.opts.tabline.tabs.prefix = preset.prefix
		M.opts.tabline.tabs.suffix = preset.suffix

		M.opts.breadcrumbs.sep = preset.breadcrumbs_separator
	end
end

function M.cache_decorators()
	--- @type table<mantel-nvim.Positionable, mantel-nvim.PositionableDecorator[]>
	M.cache.decorators = {
		name_before = {},
		name_after = {},
		prefix = {},
		suffix = {},
	}

	--- @type mantel-nvim.PositionableDecorator[]
	local all_decorators = vim.tbl_extend(
		"keep",
		{},
		M.opts.tabline.bufs.decorators.extras or {},
		M.opts.tabline.bufs.decorators.native or {}
	)

	for i, decorator in ipairs(all_decorators) do
		::continue::

		if utils.strlen(decorator.name) <= 0 then
			utils.notify(
				"Extra decorator at position '" .. i .. "' is missing a name. Skipping...",
				vim.log.levels.WARN
			)

			goto continue
		end

		if decorator.disabled then
			goto continue
		end

		table.insert(M.cache.decorators[decorator.position], decorator)
	end

	for position, _ in pairs(M.cache.decorators) do
		table.sort(M.cache.decorators[position], function(a, b)
			return a.order < b.order
		end)
	end
end

function M.set_opts(user_opts)
	M.opts = vim.tbl_deep_extend("force", {}, default_config, user_opts or {})

	M.apply_style()
	M.cache_decorators()
end

function M.get_opts()
	return M.opts
end

return M
