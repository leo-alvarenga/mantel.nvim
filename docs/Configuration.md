# Configuration

In `mantel.nvim`, everything has a default value, so configuration is optional.

```lua
-- This will give a very polished look and feel out of the box, with no extra configuration required
require("mantel-nvim").setup({})
```

Below is the full default configuration. All options are optional, any value you omit will fall back to its default. For a detailed explanation of each option and its accepted values, see the [References guide](./References.md).

```lua
-- With lazy.nvim

return {
	"leo-alvarenga/mantel.nvim",
	branch = "nightly",

	-- If you have a file icon plugin, you can add it as a dependency to have icons in the bufferline and breadcrumbs (tabline and winbar)
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		-- or 'nvim-mini/mini.icons',
	},

	opts = {
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

        -- use this in case you want customize a preset!
		override = {
			left = nil, -- left edge on each bufferline item
			right = nil, -- right edge on each bufferline item
			ellipsis = nil,
			separator = nil, -- separator between each item
			ignore_first_and_last_edges = nil, -- whether or not to forego rendering the left edge in the 1st item and the right one on the last
		},

		hl = {
			fill = "MantelFill", -- The background of the bufferline
			active = "MantelActive", -- The active buffer
			inactive = "MantelInactive", -- The inactive buffers
			edge = "MantelEdge", -- The edges of each item in the bufferline
			edge_inactive = "MantelEdgeInactive", -- The edges of inactive items in the bufferline

			tab_active = "MantelTabActive", -- The active tab (tabpage) in the bufferline
			tab_inactive = "MantelTabInactive", -- The inactive tabs (tabpages) in the bufferline

			breadcrumbs_fill = "MantelBreadcrumbsFill", -- The background of the breadcrumbs (winbar)
			breadcrumbs_item = "MantelBreadcrumbsItem", -- The breadcrumbs item (winbar)
			breadcrumbs_item_focus = "MantelBreadcrumbsItemFocus", -- The focused breadcrumbs item (winbar)
			breadcrumbs_separator = "MantelBreadcrumbsSeparator",
		},
	},
}
```

> **Tip**: To inspect your resolved config, you can use `require("mantel-nvim").get_opts()` at any time

For a complete list of options and their types, see the [References](./References.md) guide.

[Back to README](../README.md)
