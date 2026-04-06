return {
	default_config = {
		tabpages = "auto",

		min_buffer_len = 24,
		buffer_padding = 4,

		preset = "arrow",
		separator = "",
		enable_icons = true,

		icons = {
			modified = "  ●",
		},

		ellipsis = "…",

		ignore_first_and_last_edges = true,

		hl = {
			fill = "MantelFill",
			active = "MantelActive",
			inactive = "MantelInactive",
			edge = "MantelEdge",
			edge_inactive = "MantelEdgeInactive",

			tab_active = "MantelTabActive",
			tab_inactive = "MantelTabInactive",
		},
	},

	edges_by_preset = {
		none = { left = "", right = "" },
		sloped = { left = "", right = "" },
		arrow = { left = "", right = "" },
		slanted = { left = "", right = "" },
	},
}
