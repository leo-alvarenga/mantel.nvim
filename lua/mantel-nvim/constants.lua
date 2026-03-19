local prefix = "Mantel"

return {
	prefix = prefix,

	augrops = {
		winbar = prefix .. "Breadcrumbs",
	},

	styles = {
		slanted = {
			prefix = "",
			suffix = "",
		},
		slanted_inverted = {
			prefix = "",
			suffix = "",
		},
		sloped = {
			prefix = "",
			suffix = "",
		},
		sloped_inverted = {
			prefix = "",
			suffix = "",
		},
	},

	hl_groups = {
		fill = prefix .. "Fill",
		inactive = prefix .. "Inactive",
		active = prefix .. "Active",
		modified = prefix .. "Modified",
		duplicate = prefix .. "Duplicate",
		separator = prefix .. "Separator",
		prefix = prefix .. "Prefix",
		suffix = prefix .. "Suffix",
		prefix_inactive = prefix .. "PrefixInactive",
		suffix_inactive = prefix .. "SuffixInactive",
		diagnostics_error = prefix .. "DiagnosticsError",
		diagnostics_warn = prefix .. "DiagnosticsWarn",
		diagnostics_info = prefix .. "DiagnosticsInfo",
		diagnostics_hint = prefix .. "DiagnosticsHint",
		diagnostics_error_inactive = prefix .. "DiagnosticsErrorInactive",
		diagnostics_warn_inactive = prefix .. "DiagnosticsWarnInactive",
		diagnostics_info_inactive = prefix .. "DiagnosticsInfoInactive",
		diagnostics_hint_inactive = prefix .. "DiagnosticsHintInactive",

		breadcrumb_fill = prefix .. "BreadcrumbFill",
		breadcrumb_item = prefix .. "BreadcrumbItem",
		breadcrumb_item_focus = prefix .. "BreadcrumbItemFocus",
		breadcrumb_separator = prefix .. "BreadcrumbSeparator",
	},
}
