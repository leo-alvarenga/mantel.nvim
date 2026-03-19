# Recipes

The examples below cover common customization scenarios. For a full list of available options, see the [References](./References.md) guide.

## Bufferline

### Change buffer prefix

```lua
require("mantel-nvim").setup({
  bufs = {
    decorators = {
      prefix = "▎ ",
    },
  },
})
```

### Disable modified indicator

```lua
require("mantel-nvim").setup({
  bufs = {
    decorators = {
      native = {
        {
          name = "modified",
          disabled = true, -- this is the recommended way to disable an indicator
          text = "", -- empty strings are skipped, so this also disables the indicator
        }
      },
    },
  },
})
```

### Always show tabs

```lua

require("mantel-nvim").setup({
  tabs = {
    enabled = "always", -- `true` is an alias for "always"
  },
})
```

### Custom separator

```lua
require("mantel-nvim").setup({
  bufs = {
    decorators = {
      sep = ">",
    },
  },
})
```

### Custom buffer name

```lua
require("mantel-nvim").setup({
  bufs = {
    overwrites = {
      -- buf is an item from the return of `vim.fn.getbufinfo()` (see type `vim.fn.getbufinfo.ret.item`)
      name = function(buf) -- Use a function to generate the name however you want!
        return vim.fn.fnamemodify(buf.name, ":~:.")
      end,

      -- `ambiguos` is used when there are multiple buffers with the same name (determined by the `name` option above),
      -- and the bufferline needs to disambiguate them. It receives the same `buf` argument as `name`.
      ambiguos = function(buf)
        return vim.fn.fnamemodify(buf.name, ":.")
      end,

      -- `no_name` is used when the buffer has no name (e.g. a new unsaved buffer)
      no_name = "Empty Buffer", -- plain string for static names
    },
  },
})
```

## Breadcrumbs

### Static separator

```lua
require("mantel-nvim").setup({
  breadcrumbs = {
    sep = " > ",
  },
})
```

### Dynamic separator

```lua
require("mantel-nvim").setup({
  breadcrumbs = {
    sep = function()
      local mode = vim.api.nvim_get_mode().mode
      if mode == "n" then
        return " > "
      elseif mode == "i" then
        return " >> "
      else
        return " > "
      end
    end,

    -- for this to work, we need to also include the 'ModeChanged' event to trigger a refresh of the breadcrumbs
    -- whenever the mode changes
    refresh_on = { "WinNew", "BufWinEnter", "WinEnter", "ModeChanged" },
  },
})

```

### Buffer aware separator

```lua
require("mantel-nvim").setup({
  breadcrumbs = {
    -- `buf` is an item from the return of `vim.fn.getbufinfo()` (see type `vim.fn.getbufinfo.ret.item`)
    -- this will update the separator based on whether the buffer has unsaved changes (indicated by `buf.changed == 1`)
    sep = function(buf)
      if buf.changed == 1 then
        return " > "
      end

        return " >> "
      end,
  },
})
```

### Custom breadcrumb root indicator

````lua
require("mantel-nvim").setup({
  breadcrumbs = {
    dir_root = {
      text = " ", -- the text to indicate the root directory in the breadcrumbs
      len = 1, -- characther count of the root indicator (used for truncation calculations)
      focused = false, -- whether to apply the `breadcrumb_item_focus` highlight to the root indicator when the window is focused
    },
  }
})

## Highlights

## Custom highlight groups

You can override the highlight definitions used internally

```lua
require("mantel-nvim").setup({
  highlight_overwrites = function()
    return {
      active = { bold = true },
      inactive = { italic = true },
    }
  end,
})
````

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

[Back to README](../README.md)
