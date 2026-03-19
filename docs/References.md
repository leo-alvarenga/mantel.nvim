# References

Below are the options used by Mantel. For examples on different ways use these options, see the [Recipes](./Recipes.md) guide.

## Options

> Types with `BufAware` in their name are functions that receive buffer information and returns a value based on that. For example, `BufAwareStr` can be a string or a function that returns a string based on the buffer's state (active, modified, etc). This allows for dynamic configuration that can adapt to different buffer states.

### Global Options

| Field                | Type / Alias                                 | Description                                                                                 | Example                       |
| -------------------- | -------------------------------------------- | ------------------------------------------------------------------------------------------- | ----------------------------- |
| mode                 | `mantel-nvim.OptsBehavior`                   | Controls bufferline mode: "classic" (traditional) or "enhanced" (enables buffer reordering) | `"classic"`                   |
| style                | `mantel-nvim.Style`                          | Visual style preset and options. If preset is "disabled", disables rendering                | `{ preset = "slanted" }`      |
| bufs                 | `mantel-nvim.Bufs`                           | Buffer-related configuration (decorators, highlights, etc)                                  | See Buffer Options table      |
| tabs                 | `mantel-nvim.Tabs`                           | Tab-related configuration (highlights, enable mode, etc)                                    | See Tab Options table         |
| breadcrumbs          | `mantel-nvim.Breadcrumbs`                    | Breadcrumbs configuration.                                                                  | See Breadcrumbs Options table |
| ellipsis             | `string`                                     | String used to indicate overflow in tabline. Default: `' ... '`                             | `" ... "`                     |
| highlight_overwrites | `mantel-nvim.HighlightOverwrites` or `fun()` | Custom highlight group overwrites for advanced theming                                      | `function() return {...} end` |

### Buffer Options

| Field       | Type / Alias                       | Description                                                             | Example                            |
| ----------- | ---------------------------------- | ----------------------------------------------------------------------- | ---------------------------------- |
| decorators  | `mantel-nvim.Decorators`           | Buffer decorators (prefix, suffix, native, extras).                     | `{ prefix = ">", native = {...} }` |
| hl          | `mantel-nvim.HighlightGroups`      | Highlight groups for buffer elements (active, inactive, modified, etc). | See Buffer Highlight Groups table  |
| min_width   | `integer`                          | Minimum width for each buffer in the tabline.                           | `min_width = 10`                   |
| min_padding | `integer`                          | Minimum padding (spaces) on each side of buffer name.                   | `min_padding = 2`                  |
| overwrites  | `mantel-nvim.BufContentOverwrites` | Custom content for ambiguous, named, or unnamed buffers.                | `"[No Name]"`                      |

#### Buffer Highlight Groups

| Field                      | Type / Alias              | Description                                                                    | Default                            |
| -------------------------- | ------------------------- | ------------------------------------------------------------------------------ | ---------------------------------- |
| fill                       | `string`                  | Highlight group for background fill of buffer section.                         | `"MantelFill"`                     |
| inactive                   | `mantel-nvim.BufAwareStr` | Highlight for inactive buffer. Can be a string or function returning a string. | `"MantelInactive"`                 |
| active                     | `mantel-nvim.BufAwareStr` | Highlight for active buffer.                                                   | `"MantelActive"`                   |
| modified                   | `mantel-nvim.BufAwareStr` | Highlight for modified buffer.                                                 | `"MantelModified"`                 |
| duplicate                  | `mantel-nvim.BufAwareStr` | Highlight for duplicate buffer names.                                          | `"MantelDuplicate"`                |
| separator                  | `mantel-nvim.BufAwareStr` | Highlight for separator between buffers.                                       | `"MantelSeparator"`                |
| prefix                     | `mantel-nvim.BufAwareStr` | Highlight for prefix before buffer name.                                       | `"MantelPrefix"`                   |
| suffix                     | `mantel-nvim.BufAwareStr` | Highlight for suffix after buffer name.                                        | `"MantelSuffix"`                   |
| prefix_inactive            | `mantel-nvim.BufAwareStr` | Highlight for prefix in inactive buffer.                                       | `"MantelPrefixInactive"`           |
| suffix_inactive            | `mantel-nvim.BufAwareStr` | Highlight for suffix in inactive buffer.                                       | `"MantelSuffixInactive"`           |
| diagnostics_error          | `mantel-nvim.BufAwareStr` | Highlight for error diagnostics indicator.                                     | `"MantelDiagnosticsError"`         |
| diagnostics_warn           | `mantel-nvim.BufAwareStr` | Highlight for warning diagnostics indicator.                                   | `"MantelDiagnosticsWarn"`          |
| diagnostics_info           | `mantel-nvim.BufAwareStr` | Highlight for info diagnostics indicator.                                      | `"MantelDiagnosticsInfo"`          |
| diagnostics_hint           | `mantel-nvim.BufAwareStr` | Highlight for hint diagnostics indicator.                                      | `"MantelDiagnosticsHint"`          |
| diagnostics_error_inactive | `mantel-nvim.BufAwareStr` | Highlight for error diagnostics in inactive buffer.                            | `"MantelDiagnosticsErrorInactive"` |
| diagnostics_warn_inactive  | `mantel-nvim.BufAwareStr` | Highlight for warning diagnostics in inactive buffer.                          | `"MantelDiagnosticsWarnInactive"`  |
| diagnostics_info_inactive  | `mantel-nvim.BufAwareStr` | Highlight for info diagnostics in inactive buffer.                             | `"MantelDiagnosticsInfoInactive"`  |
| diagnostics_hint_inactive  | `mantel-nvim.BufAwareStr` | Highlight for hint diagnostics in inactive buffer.                             | `"MantelDiagnosticsHintInactive"`  |

### Tab Options

| Field     | Type / Alias                           | Description                                                                     | Example                        |
| --------- | -------------------------------------- | ------------------------------------------------------------------------------- | ------------------------------ |
| hl        | `mantel-nvim.TabHighlightGroups`       | Highlight groups for tab elements (active, inactive, modified, etc).            | See Tab Highlight Groups table |
| enabled   | `boolean` or `mantel-nvim.TabBehavior` | Controls tab rendering: "auto" (only if >1 tab), "always", "never", or boolean. | `"auto"` or `true`             |
| min_width | `integer`                              | Minimum width for each tab in the tabline.                                      | `min_width = 12`               |

#### Tab Highlight Groups

| Field                      | Type / Alias | Description                                         | Default                    |
| -------------------------- | ------------ | --------------------------------------------------- | -------------------------- |
| fill                       | `string`     | Highlight group for background fill of tab section. | `"MantelTabFill"`          |
| inactive                   | `string`     | Highlight for inactive tab.                         | `"MantelTabInactive"`      |
| active                     | `string`     | Highlight for active tab.                           | `"MantelTabActive"`        |
| modified                   | `string`     | Highlight for modified tab.                         | `"MantelTabModified"`      |
| duplicate                  | `string`     | Highlight for duplicate tab names.                  | `"MantelTabDuplicate"`     |
| separator                  | `string`     | Highlight for separator between tabs.               | `"MantelTabSeparator"`     |
| diagnostics_error          | `string`     | Highlight for error diagnostics indicator in tab.   | `"MantelTabError"`         |
| diagnostics_warn           | `string`     | Highlight for warning diagnostics indicator in tab. | `"MantelTabWarn"`          |
| diagnostics_info           | `string`     | Highlight for info diagnostics indicator in tab.    | `"MantelTabInfo"`          |
| diagnostics_hint           | `string`     | Highlight for hint diagnostics indicator in tab.    | `"MantelTabHint"`          |
| diagnostics_error_inactive | `string`     | Highlight for error diagnostics in inactive tab.    | `"MantelTabErrorInactive"` |
| diagnostics_warn_inactive  | `string`     | Highlight for warning diagnostics in inactive tab.  | `"MantelTabWarnInactive"`  |
| diagnostics_info_inactive  | `string`     | Highlight for info diagnostics in inactive tab.     | `"MantelTabInfoInactive"`  |
| diagnostics_hint_inactive  | `string`     | Highlight for hint diagnostics in inactive tab.     | `"MantelTabHintInactive"`  |

### Breadcrumbs Options

| Field         | Type / Alias                            | Description                                                                                         | Example                                                     |
| ------------- | --------------------------------------- | --------------------------------------------------------------------------------------------------- | ----------------------------------------------------------- |
| enabled       | `boolean`                               | If false, breadcrumbs will not be rendered at all. Default: true.                                   | `enabled = true`                                            |
| refresh_on    | `string[]`                              | Array of events that trigger breadcrumb refresh. Default: `{ "WinNew", "BufWinEnter", "WinEnter" }` | `refresh_on = { "WinNew", "BufWinEnter", "WinEnter" }`      |
| mode          | `mantel-nvim.BreadcrumbBehavior`        | Controls breadcrumb rendering: 'auto-inclusive' (default) or 'manual-only'.                         | `"auto-inclusive"`                                          |
| sep           | `mantel-nvim.BufAwareStr`               | Separator string between breadcrumb items.                                                          | `"/"`                                                       |
| padding_left  | `integer?`                              | Blank space to add at the start of breadcrumbs.                                                     | `padding_left = 1`                                          |
| padding_right | `integer?`                              | Blank space to add at the end of breadcrumbs.                                                       | `padding_right = 1`                                         |
| hl            | `mantel-nvim.BreadcrumbHighlightGroups` | Highlight groups for breadcrumb elements.                                                           | See Breadcrumb Highlight Groups                             |
| parts         | `mantel-nvim.BufAwareBreadcrumbParts`   | Array of breadcrumb parts, can be function or array.                                                | `{ { text = "src", len = 3 }, { text = "main", len = 4 } }` |
| dir_root      | `mantel-nvim.BreadcrumbPart`            | Special part for workdir's root. Default: `''`                                                      | `{ text = "/", len = 1, focused = true }`                   |

#### Breadcrumb Highlight Groups

| Field                 | Type / Alias              | Description                                                | Example                       |
| --------------------- | ------------------------- | ---------------------------------------------------------- | ----------------------------- |
| breadcrumb_fill       | `string`                  | Highlight group for background fill of breadcrumb section. | `"MantelBreadcrumbFill"`      |
| breadcrumb_item       | `mantel-nvim.BufAwareStr` | Highlight for breadcrumb item.                             | `"MantelBreadcrumbItem"`      |
| breadcrumb_item_focus | `mantel-nvim.BufAwareStr` | Highlight for focused breadcrumb item.                     | `"MantelBreadcrumbItemFocus"` |
| breadcrumb_separator  | `mantel-nvim.BufAwareStr` | Highlight for separator between breadcrumb items.          | `"MantelBreadcrumbSeparator"` |

## Types

Types are available for all options in the plugin, and they are defined in the `types` module. These types provide a clear definition of what kind of values each option can accept, which can be especially helpful when configuring the plugin or when using a Lua language server that supports type hints.

[Back to README](../README.md)
