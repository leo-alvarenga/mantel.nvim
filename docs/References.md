# References

Below are references for the options and types used by Mantel. For examples on different ways use these options, see the [Recipes](./Recipes.md) guide.

## Types

Below are the relevant types used by `mantel-nvim` for options. These types are used to ensure correct configuration and to provide structure for the plugin's behavior.

It's generally a good idea to refer to these types when configuring the plugin, especially if you're using a Lua language server that can provide type hints and autocompletion based on these definitions.

> Note: Types that include `BufAware` in their name indicate that they can either be a static value or a function that returns a value based on buffer information. This allows for dynamic configuration that can adapt to different buffers or logic related to the buffer's state

#### `mantel-nvim.HlEntry`

Defines how highlight groups are specified for mantel-nvim components. Can be a highlight table or a function returning one based on buffer info.

- Either a `vim.api.keyset.highlight` table or a function returning one for a buffer.

#### `mantel-nvim.HighlightOverwrites`

Allows users to override default highlight settings for specific buffer and tabline states. Used for customizing appearance.

> Use case: Use this if you want to provide different styles for certain states or parts of the buffer/tabline without registering your own new highlight groups to use with [`mantel-nvim.HighlightGroups`](#mantel-nvimhighlightgroups)

- Custom highlight definitions for various buffer/tabline states
  - `fill`: `HlEntry`
  - `inactive`: `HlEntry`
  - `active`: `HlEntry`
  - `separator`: `HlEntry`
  - `diagnostics_error`: `HlEntry`
  - `diagnostics_warn`: `HlEntry`
  - `diagnostics_info`: `HlEntry`
  - `diagnostics_hint`: `HlEntry`
  - `diagnostics_error_inactive`: `HlEntry`
  - `diagnostics_warn_inactive`: `HlEntry`
  - `diagnostics_info_inactive`: `HlEntry`
  - `diagnostics_hint_inactive`: `HlEntry`

#### `mantel-nvim.HighlightGroups`

Specifies the highlight group names used by mantel-nvim for various UI elements. Supports static or buffer-aware values

- Highlight group names for buffer/tabline components.
  - `fill`: `string` - This one is static, as it applies to the whole tabline, not individual buffers
  - `inactive`: `BufAwareStr`
  - `active`: `BufAwareStr`
  - `modified`: `BufAwareStr`
  - `duplicate`: `BufAwareStr`
  - `separator`: `BufAwareStr`
  - `diagnostics_error`: `BufAwareStr`
  - `diagnostics_warn`: `BufAwareStr`
  - `diagnostics_info`: `BufAwareStr`
  - `diagnostics_hint`: `BufAwareStr`
  - `diagnostics_error_inactive`: `BufAwareStr`
  - `diagnostics_warn_inactive`: `BufAwareStr`
  - `diagnostics_info_inactive`: `BufAwareStr`
  - `diagnostics_hint_inactive`: `BufAwareStr`

### Buffer Types

#### `mantel-nvim.BufAwareNumber`

Represents a number or a function returning a number based on buffer info. Used for dynamic configuration per buffer.

- Either a `number` or a function returning a number for a buffer.

#### `mantel-nvim.BufAwareStr`

Represents a string or a function returning a string based on buffer info. Used for dynamic text or highlight group names.

- Either a `string` or a function returning a string for a buffer.

#### `mantel-nvim.Positionable`

Enumerates possible positions for decorators relative to buffer names in the tabline.

- One of: `'name_before'`, `'name_after'`, `'prefix'`, `'suffix'`.

Buffer decorator positions:

```plaintext
{a}{prefix}{name_before}{b}{name_after}{suffix}{c}

- {a} prefix value
- {b} name value
- {c} suffix value
```

#### `mantel-nvim.PositionableDecorator`

Defines a decorator element for buffers or tabs, including its position, text, highlight, and order. Used to add custom or built-in decorations.

- Decorator for buffer/tabline elements.
  - `disabled`: `boolean?` (particularly useful to disable built-in decorators without removing them from the configuration table)
  - `name`: `string` (user-friendly name to identify the decorator, not used for display; only a single instance of a decorator with a given name will be shown, so use this to prevent duplicates if needed)
  - `order`: `BufAwareNumber` (determines display order; lower numbers are shown first)
  - `text`: `BufAwareStr` (the actual string to display, which can be dynamic based on buffer info)
  - `position`: `Positionable`
  - `hl`: `BufAwareStr?`

#### `mantel-nvim.Decorators`

Groups all decorators for buffers, including separators, prefixes, suffixes, and arrays of native or extra decorators.

Notice that the `sep`, `prefix`, and `suffix` fields are separate from the `native` and `extras` arrays. This is because they serve a different purpose: they are simple string decorators that are commonly used and have a fixed position relative to the buffer name, while the `native` and `extras` arrays can contain any number of decorators with more flexible positioning and ordering.

- Collection of decorators for buffers.
  - `sep`: `BufAwareStr?`
  - `prefix`: `BufAwareStr?`
  - `suffix`: `BufAwareStr?`
  - `native`: `PositionableDecorator[]?` (built-in decorators, hackable and completely customizable)
  - `extras`: `PositionableDecorator[]?` (user-defined decorators; it's a good idea to use this if you want to add custom decorators without modifying the built-in ones)

#### `mantel-nvim.BufContentOverwrites`

Allows custom strings for ambiguous, named, or unnamed buffers. Used to control buffer display text.

- Custom buffer content strings.
  - `ambiguos`: `BufAwareStr`
  - `name`: `BufAwareStr`
  - `no_name`: `BufAwareStr`

#### `mantel-nvim.Bufs`

Main buffer configuration object. Controls decorators, highlights, minimum width, and content overwrites for buffers in the tabline.

- Buffer configuration.
  - `decorators`: `Decorators`
  - `hl`: `HighlightGroups`
  - `min_width`: `integer`
  - `overwrites`: `BufContentOverwrites`

### Tab Types

#### `mantel-nvim.TabBehavior`

Controls when tabs are shown in the tabline: automatically, always, or never.

- One of: `"auto"`, `"always"`, `"never"`.

#### `mantel-nvim.Tabs`

Main tab configuration object. Sets highlight groups, enable behavior, and minimum width for tabs in the tabline.

- Tab configuration.
  - `hl`: `HighlightGroups`
  - `enabled`: `boolean | TabBehavior`
  - `min_width`: `integer`

### Option Types

#### `mantel-nvim.OptsBehavior`

Selects the plugin's operational mode: "classic" for traditional tabline, "enhanced" for dynamic buffer ordering.

- One of: `"classic"`, `"enhanced"`.

#### `mantel-nvim.Opts`

Top-level plugin options. Includes debug mode, operational mode, buffer and tab settings, and highlight overwrites.

- Main plugin options.
  - `debug`: `boolean?`
  - `mode`: `OptsBehavior`
  - `bufs`: `Bufs`
  - `tabs`: `Tabs`
  - `highlight_overwrites`: `HighlightOverwrites | fun(): HighlightOverwrites`

[Back to README](../README.md)
