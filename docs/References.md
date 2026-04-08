# References

Below are the options used by Mantel.

## Options

### mantel-nvim.Opts

| Field                    | Type                                               | Description                                    | Default Value                             |
| ------------------------ | -------------------------------------------------- | ---------------------------------------------- | ----------------------------------------- |
| `tabpages`               | `"auto"` or `boolean`                              | Tabpages display mode                          | `"auto"`                                  |
| `breadcrumbs_mode`       | `"auto"` or `"manual"` or `boolean`                | Breadcrumbs mode                               | `"auto"`                                  |
| `breadcrumbs_refresh_on` | `string[]`                                         | Events to refresh breadcrumbs                  | `{ "WinNew", "BufWinEnter", "WinEnter" }` |
| `min_buffer_len`         | `integer`                                          | Minimum buffer length                          | `16`                                      |
| `buffer_padding`         | `integer`                                          | Padding for buffer display                     | `2`                                       |
| `preset`                 | `"none"` or `"slanted"` or `"arrow"` or `"sloped"` | Preset name; Invalid names default to `"none"` | `"none"`                                  |
| `override`               | `mantel-nvim.PartialPreset`                        | Override preset options                        | See below                                 |
| `hl`                     | `mantel-nvim.HighlightGroups`                      | Highlight group names                          | See below                                 |
| `icons`                  | `mantel-nvim.Icons`                                | Icons configuration                            | See below                                 |

---

### mantel-nvim.Icons

| Field      | Type      | Description          | Default Value |
| ---------- | --------- | -------------------- | ------------- |
| `enabled`  | `boolean` | Enable icons         | `true`        |
| `modified` | `string`  | Modified icon string | `"  ●"`       |

---

### mantel-nvim.PartialPreset

| Field                         | Type               | Description                           | Example Value |
| ----------------------------- | ------------------ | ------------------------------------- | ------------- |
| `left`                        | `string` or `nil`  | Left preset override                  | `nil`         |
| `right`                       | `string` or `nil`  | Right preset override                 | `nil`         |
| `ellipsis`                    | `string` or `nil`  | Ellipsis preset override              | `nil`         |
| `separator`                   | `string` or `nil`  | Separator preset override             | `nil`         |
| `breadcrumbs_separator`       | `string` or `nil`  | Breadcrumbs separator preset override | `nil`         |
| `ignore_first_and_last_edges` | `boolean` or `nil` | Ignore edge override                  | `nil`         |

---

### mantel-nvim.HighlightGroups

| Field                    | Type     | Description                              | Default Value                  |
| ------------------------ | -------- | ---------------------------------------- | ------------------------------ |
| `fill`                   | `string` | Bufferline Bg highlight group            | `"MantelFill"`                 |
| `active`                 | `string` | Active Bufferline item highlight group   | `"MantelActive"`               |
| `inactive`               | `string` | Inactive Bufferline item highlight group | `"MantelInactive"`             |
| `edge`                   | `string` | Edge highlight group                     | `"MantelEdge"`                 |
| `edge_inactive`          | `string` | Inactive edge highlight group            | `"MantelEdgeInactive"`         |
| `tab_active`             | `string` | Active tab highlight group               | `"MantelTabActive"`            |
| `tab_inactive`           | `string` | Inactive tab highlight group             | `"MantelTabInactive"`          |
| `breadcrumbs_fill`       | `string` | Breadcrumbs fill highlight group         | `"MantelBreadcrumbsFill"`      |
| `breadcrumbs_item`       | `string` | Breadcrumbs item highlight group         | `"MantelBreadcrumbsItem"`      |
| `breadcrumbs_item_focus` | `string` | Focused breadcrumbs item group           | `"MantelBreadcrumbsItemFocus"` |
| `breadcrumbs_separator`  | `string` | Breadcrumbs separator group              | `"MantelBreadcrumbsSeparator"` |

[Back to README](../README.md)
