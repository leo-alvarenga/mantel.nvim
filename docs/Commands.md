# Commands

There are a few user commands exposed for interacting with the `mantel.nvim` at runtime.

- [Command list](#commands)
  - [`:MantelBufPrev`](#mantelbufprev)
  - [`:MantelBufNext`](#mantelbufnext)
  - [`:MantelMoveBufLeft`](#mantelmovebufleft)
  - [`:MantelMoveBufRight`](#mantelmovebufright)
  - [`:MantelReloadColors`](#mantelreloadcolors)
  - [`:MantelBreadcrumbs`](#mantelbreadcrumbs)

### `:MantelBufPrev`

Focuses the previous buffer in the tabline.

Example mapping:

```lua
vim.keymap.set("n", "<leader>h", "<cmd>MantelBufPrev<CR>")
```

### `:MantelBufNext`

Focuses the next buffer in the tabline.

Example mapping:

```lua
vim.keymap.set("n", "<leader>l", "<cmd>MantelBufNext<CR>")
```

### `:MantelMoveBufLeft`

Moves the current buffer **one position to the left** in the tabline.

Example mapping:

```lua
vim.keymap.set("n", "<leader>bh", "<cmd>MantelMoveBufLeft<CR>")
```

### `:MantelMoveBufRight`

Moves the current buffer **one position to the right** in the tabline.

Example mapping:

```lua
vim.keymap.set("n", "<leader>bl", "<cmd>MantelMoveBufRight<CR>")
```

### `:MantelReloadColors`

Reloads the highlight groups used by `mantel.nvim`.

This can be useful when:

- changing colorschemes
- tweaking highlight overrides
- testing colors during development

### `:MantelBreadcrumbs`

Toggles the breadcrumbs (winbar) component.

> The behavior of this command depends on the value of `opts.breadcrumbs_mode`
> See README for a full explanation of breadcrumb behavior modes

[Back to README](../README.md)
