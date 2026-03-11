# Recipes

## Change buffer prefix

```lua
require("mantel-nvim").setup({
  bufs = {
    decorators = {
      prefix = "▎ ",
    },
  },
})
```

## Disable modified indicator

```lua
require("mantel-nvim").setup({
  bufs = {
    decorators = {
      native = {
        {
          name = "modified",
          text = "",
        }
      },
    },
  },
})
```

## Always show tabs

```lua

require("mantel-nvim").setup({
  tabs = {
    enabled = "always",
  },
})
```

## Custom separator

```lua
require("mantel-nvim").setup({
  bufs = {
    decorators = {
      prefix = " ",
      suffix = " ",
      sep = ">",
    },
  },
})
```

![Default preview](./docs/default.png)

## Custom buffer name

```lua
require("mantel-nvim").setup({
  bufs = {
    overwrites = {
      -- buf is an item from the return of `vim.fn.getbufinfo()` (see type `vim.fn.getbufinfo.ret.item`)
      name = function(buf) -- Use a function to generate the name however you want!
        return vim.fn.fnamemodify(buf.name, ":~:.")
      end,
      no_name = "Empty Buffer", -- Or just a string for static names
    },
  },
})
```

## Custom highlight groups

You can override the highlight definitions used internally...

```lua
require("mantel-nvim").setup({
  highlight_overwrites = function()
    return {
      active = { bold = true },
      inactive = { italic = true },
    }
  end,
})
```

... or use other groups (maybe even your own groups) in the configuration:

```lua
require("mantel-nvim").setup({
  bufs = {
    hl = {
      active = "TabLineSel", -- Neovim's default active tab highlight
      inactive = "MyInactiveHighlight", -- your own custom highlight group!
    },
  },
})

```

## Pretty tabs with custom decorators and highlights

```lua

return {
	"leo-alvarenga/mantel.nvim",
	branch = "nightly",
	opts = {
		mode = "enhanced",

		bufs = {
			decorators = {
				sep = " ",

        -- To achieve this, Ill use custom decorators to give me more control over the styling of the tabs
				prefix = "",
				suffix = "",

				extras = {
					{
						order = 1,
						position = "prefix",
						name = "prefix_custom",
						text = " ",
					},

					{
						order = 1,
						position = "suffix",
						name = "prefix_suffix",
						text = " ",
					},
				},
			},
		},

		highlight_overwrites = function()
			local statusline = vim.api.nvim_get_hl(0, { name = "StatusLine" })
			local tabsel = vim.api.nvim_get_hl(0, { name = "TabLineSel" })
			local diag_info = vim.api.nvim_get_hl(0, { name = "DiagnosticInfo" })

			return {
				inactive = {
					bg = tabsel.bg,
					fg = statusline.bg,
				},
				active = {
					bg = diag_info.fg,
					fg = statusline.bg,
					bold = true,
				},
				separator = {
					bg = statusline.bg,
					fg = statusline.bg,
				},
			}
		end,
	},
}
```

![Pretty tabs preview](./images/pretty_tabs.png)
