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
		disableWarning = false,
		ellipsis = " ... ", -- any plain string

		mode = "classic", -- 'classic' | 'enhanced'

		style = {
			preset = "default", -- 'default' | 'slanted' | 'slanted_inverted' | 'sloped' | 'sloped_inverted'
			ignore_first_buffer_prefix = false,
		},

		bufs = { ... }, --- see References
		tabs = { ... }, --- see References

		breadcrumbs = { ... }, --- see References
		highlight_overwrites = { ... }, --- see References
	},
}
```

> **Tip**: To inspect your resolved config, you can use `require("mantel-nvim").get_opts()` at any time

For a complete list of options and their types, see the [References](./References.md) guide.
For examples on different ways use these options, see the [Recipes](./Recipes.md) guide.

[Back to README](../README.md)
