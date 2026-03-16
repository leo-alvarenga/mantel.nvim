# Configuration

Everything has a default value, so configuration is optional.

```lua
-- This will give a very close to native xp
require("mantel-nvim").setup({})
```

Another common use case is to keep the default look and feel, but enable the `enhanced` mode:

```lua
-- With lazy.nvim

return {
	"leo-alvarenga/mantel.nvim",
	branch = "nightly",

	-- If you have a file icon plugin, you can add it as a dependency to have icons in the bufferline
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		-- or
		'nvim-mini/mini.icons',
	},

	config = function()
		local mantel = require("mantel-nvim")

		local opts = {
			mode = "enhanced",

			style = {
				preset = "slanted", -- This applies slanted glyphs to the buffers listed in the bufferline. The default is "default", which applies NO glyphs
			}
		}

		mantel.setup(opts)

    vim.keymap.set("", "<leader>h", ":MantelBufPrev<CR>", { desc = "Focus previous buffer" })
    vim.keymap.set("", "<leader>l", ":MantelBufNext<CR>", { desc = "Focus previous buffer" })
    vim.keymap.set("", "<leader>H", ":MantelMoveBufLeft<CR>", { desc = "Move current buffer to the left" })
    vim.keymap.set("", "<leader>L", ":MantelMoveBufRight<CR>", { desc = "Move current buffer to the right" })
	end,
}
```

For a complete list of options and their types, see the [References](./References.md) guide.
For examples on different ways use these options, see the [Recipes](./Recipes.md) guide.

[Back to README](../README.md)
