# mantel.nvim

A dead-simple, lightweight, customizable and _cozy_ tabline/bufferline for Neovim

## Table of Contents

- [Table of Contents](#table-of-contents)
- [Motivation](#motivation)
- [Installation](#installation)
- [Usage](#usage)
- [Concepts](#concepts)
- [License](#license)
- More
  - [References](./docs/References.md)
  - [Configuration](./docs/Configuration.md)
  - [Commands](./docs/Commands.md)
  - [Recipes](./docs/Recipes.md)

## Motivation

Neovim’s built-in tabline works well... but can certainly look better. Many plugins offer powerful bufferline features, but often introduce heavy abstractions or complex configuration.

`mantel.nvim` aims to provide a **simple, predictable, and hackable tabline layer** that stays close to Neovim’s native behavior while still allowing deep customization (if and when desired).

The idea is simple: give users a **clean way to render buffer and tab indicators** without too much hassle.

### Roadmap

- [x] Basic bufferline rendering
- [x] Tabline support
- [x] Decorator system
- [x] Icon support
- [x] Diagnostic indicators
- [x] Configurable highlights
- [ ] Document new sleek look! <- Currently in progress
- [ ] Add buffer count indicators on overflow
- [ ] Always center on the current buffer

## Preview

Default configuration:

![Default preview](./docs/images/with_icons.png)

Or without icons:

![Default preview](./docs/images/default.png)

Custom configuration example:

![Custom preview](./docs/images/custom.png)

## Features

- **No dependencies**
- Works with **buffers and tabs**
- Flexible decorator system
- Configurable highlight groups
- Colorscheme-friendly defaults
- Simple, predictable configuration
- Icon support (optional)
- Diagnostic indicators (optional)
- Minimal runtime overhead

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

For more details on configuration options, see the [Configuration](./docs/Configuration.md) page.

## Concepts

`mantel.nvim` organizes the tabline around two main components.

### Buffers

Buffers represent open files.

Each buffer entry supports:

- decorators
- custom names
- highlight groups
- minimum width

### Tabs

Tabs represent Neovim tabpages.

They can be enabled or disabled independently from buffers.

## License

This project is licensed under the GPLv3 License. See the [LICENSE](LICENSE) file for details.
