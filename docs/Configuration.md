# Configuration

Everything has a default value, so configuration is optional.

```lua
require("mantel-nvim").setup({
  mode = "classic",

  bufs = {
    decorators = {
      sep = "",
      prefix = "| ",
      suffix = " ",

      native = {},
      extras = {},
    },

    min_width = 10,

    hl = {
      fill = "MantelFill",
      inactive = "MantelInactive",
      active = "MantelActive",
      separator = "MantelSeparator",
    },

    overwrites = {
      ambiguos = function(buf)
        return vim.fn.fnamemodify(buf.name, ":.")
      end,

      name = function(buf)
        return vim.fn.fnamemodify(buf.name, ":t")
      end,

      no_name = "[No name]",
    },
  },

  tabs = {
    decorators = {
      sep = "",
      prefix = " ",
      suffix = " ",
    },

    enabled = "auto",
    min_width = 5,

    hl = {
      fill = "MantelFill",
      inactive = "MantelInactive",
      active = "MantelActive",
      separator = "MantelSeparator",
    },
  },

  highlight_overwrites = function()
    -- derived from colorscheme-agnostic defaults
  end,
})
```
