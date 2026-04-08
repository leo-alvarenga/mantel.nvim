# mantel.nvim

Lightweight, clean tabline and winbars for Neovim

`mantel.nvim` provides a simple, predictable and ready-to-use tabline layer that works with Neovim's native buffer and tab model; no magic, just clean rendering with straightforward configuration options.

## Table of Contents

- [Table of Contents](#table-of-contents)
- [Installation](#installation)
- [Usage](#usage)
- [Concepts](#concepts)
- [License](#license)
- More
  - [References](./docs/References.md)
  - [Configuration](./docs/Configuration.md)
  - [Commands](./docs/Commands.md)

## Preview

Default configuration (using the `default` style preset):

![Default preview](./docs/images/with_icons.png)

Or without icons:

![Default preview without icons](./docs/images/default.png)

With the `slanted` style preset:

![Slanted preview](./docs/images/style_slanted.png)

With the `sloped` style preset:

![Sloped preview](./docs/images/style_sloped.png)

With a custom separator:

![Separator preview](./docs/images/separator_example1.png)

With the Breadcrumbs enable:
![Breadcrumbs preview](./docs/images/breadcrumbs.png)

## Features

- **No dependencies**
- Zero runtime dependencies
- **State-less**, **pull-based** rendering architecture
- Configurable highlight groups
- Colorscheme-friendly defaults
- Simple, predictable configuration
- Icon support (optional)
- Diagnostic indicators (optional)

## Installation

> `mantel.nvim` requires Neovim **0.10** or higher

### Using vim-plug

```vim
Plug 'leo-alvarenga/mantel.nvim'
```

### Using lazy.nvim

```lua
{
  "leo-alvarenga/mantel.nvim",
  opts = {},
}
```

## Usage

Setup is straightforward:

```lua
require("mantel-nvim").setup({})
```

No configuration is required.

For more details, read the Concepts section below and check out the [Configuration](./docs/Configuration.md) and [Commands](./docs/Commands.md) documentation.

## Concepts

> Read the section below to understand the core concepts behind `mantel.nvim` and how to use them to customize your experience and only **after** that, check out the [Configuration](./docs/Configuration.md) documentation for concrete examples of how to apply these concepts in practice.

`mantel.nvim` offers two main components for displaying information: the **bufferline** (or tabline) and the **breadcrumbs** (or winbar). These components can be enabled independently, allowing you to choose which information you want to see and how you want to see it.

Both components are designed to be simple and ready-to-use, while providing sensible defaults that work well out of the box.

> `mantel.nvim` provides a powerful buffer reordering system that allows you to easily move buffers around in the bufferline, either with commands or keybindings

### Bufferline (Tabline)

> `tabline` is the name of the Neovim option that controls the display of tabs (or arbitrary text) at the top of your view. In `mantel.nvim`, we use this term to refer to the entire line that can show both buffers and tabs.

In `mantel.nvim`, the bufferline is designed to show both buffers and tabs in a cohesive way, while balancing flexibility and simplicity.

![Sloped preview](./docs/images/style_sloped.png)

#### Buffers

Buffers represent open files.

Each buffer entry supports:

- icons (optional)
- custom names
- highlight groups
- minimum width

#### Tabs

Tabs represent Neovim tabpages.

They can be enabled or disabled independently from buffers.

There are three modes for tabs, configured via the `opts.tabs.enabled` option:

- `"auto"`: (Default) tabs are shown when there are more than 1 tabpages open, otherwise they are hidden
- `true`: tabs are always shown, even if there is only 1 tabpage open
- `false`: tabs are never shown, even if there are multiple tabpages open

### Breadcrumbs (Winbar)

> `winbar` is a Neovim option that allows you to display information at the top of each window (windows refer to **splits** in Neovim's terminology). In `mantel.nvim`, we use this term to refer to the line that can show breadcrumbs, which typically include the file path (by default).

**Breadcrumbs** are a separate component that can be enabled to show the current file path and context in the `winbar`.

![Breadcrumbs preview](./docs/images/breadcrumbs.png)

Different from the bufferline, breadcrumbs are designed to show the location of the current file within the project.

Breadcrumbs can be **toggled**, meaning you can show or hide them on demand (e.g., with a keybinding). This is useful if you want to quickly check the file path and then hide it again to save space.

There are two breadcrumbs behavior modes, configured via the `opts.breadcrumbs.mode` option:

- `"auto"` or `true`: (Default) breadcrumbs are shown in all windows, automatically. You can toggle individual windows on or off, but by default they are all on
- `"manual"` or `false`: breadcrumbs are hidden by default, and you have to toggle them on for each window you want to see them

## License

This project is licensed under the GPLv3 License. See the [LICENSE](LICENSE) file for details.
