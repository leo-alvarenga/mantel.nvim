return {
	--- @type mantel-nvim.Opts
	default_config = {
		tabpages = "auto",
		breadcrumbs_mode = "auto",
		breadcrumbs_refresh_on = { "WinNew", "BufWinEnter", "WinEnter" },

		min_buffer_len = 16,
		buffer_padding = 2,

		preset = "none",

		icons = {
			enabled = true,
			modified = "  ●",
		},

		override = {
			left = nil,
			right = nil,
			ellipsis = nil,
			breadcrumbs_separator = nil,
			separator = nil,
			ignore_first_and_last_edges = nil,
		},

		hl = {
			fill = "MantelFill",
			active = "MantelActive",
			inactive = "MantelInactive",
			edge = "MantelEdge",
			edge_inactive = "MantelEdgeInactive",

			tab_active = "MantelTabActive",
			tab_inactive = "MantelTabInactive",

			breadcrumbs_fill = "MantelBreadcrumbsFill",
			breadcrumbs_item = "MantelBreadcrumbsItem",
			breadcrumbs_item_focus = "MantelBreadcrumbsItemFocus",
			breadcrumbs_separator = "MantelBreadcrumbsSeparator",
		},
	},

	--- @type mantel-nvim.PresetTable
	presets = {
		none = {
			ellipsis = "…",
			left = "",
			right = "",
			separator = "",
			breadcrumbs_separator = " > ",
			ignore_first_and_last_edges = false,
		},

		sloped = {
			ellipsis = "…",
			left = "",
			right = "",
			separator = "",
			breadcrumbs_separator = " > ",
			ignore_first_and_last_edges = false,
		},

		arrow = {
			ellipsis = "…",
			left = "",
			right = "",
			separator = "",
			breadcrumbs_separator = " > ",
			ignore_first_and_last_edges = true,
		},

		slanted = {
			ellipsis = "…",
			left = "",
			right = "",
			separator = "",
			breadcrumbs_separator = " > ",
			ignore_first_and_last_edges = true,
		},
	},

	edges_by_preset = {
		none = { left = "|", right = "" },
		sloped = { left = "", right = "" },
		arrow = { left = "", right = "" },
		slanted = { left = "", right = "" },
	},
}
