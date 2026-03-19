# Commands

`mantel.nvim` exposes a few user commands for interacting with the tabline.

- [Command list](#commands)
  - [`:MantelBufPrev`](#mantelbufprev)
  - [`:MantelBufNext`](#mantelbufnext)
  - [`:MantelMoveBufLeft`](#mantelmovebufleft)
  - [`:MantelMoveBufRight`](#mantelmovebufright)
  - [`:MantelReloadColors`](#mantelreloadcolors)

### `:MantelBufPrev`

Focuses the previous buffer in the tabline.

This command only works when `mode = "enhanced"` is enabled.

Example mapping:

```lua
vim.keymap.set("n", "<leader>h", "<cmd>MantelBufPrev<CR>")
```

### `:MantelBufNext`

Focuses the next buffer in the tabline.

This command also requires `mode = "enhanced"`.

Example mapping:

```lua
vim.keymap.set("n", "<leader>l", "<cmd>MantelBufNext<CR>")
```

### `:MantelMoveBufLeft`

Moves the current buffer **one position to the left** in the tabline.

This command only works when `mode = "enhanced"` is enabled.

Example mapping:

```lua
vim.keymap.set("n", "<leader>bh", "<cmd>MantelMoveBufLeft<CR>")
```

### `:MantelMoveBufRight`

Moves the current buffer **one position to the right** in the tabline.

This command also requires `mode = "enhanced"`.

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

> The behavior of this command depends on the value of `opts.breadcrumbs.mode`

> There are two breadcrumbs behavior modes, configured via the `opts.breadcrumbs.behavior` option:
>
> - `auto-inclusive`: (Default) breadcrumbs are shown in all windows, automatically. You can toggle individual windows on or off, but by default they are all on
> - `manual`: breadcrumbs are hidden by default, and you have to toggle them on for each window you want to see them

[Back to README](../README.md)
