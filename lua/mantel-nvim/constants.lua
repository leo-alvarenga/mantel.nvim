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
			breadcrumbs_separator = "  ",
		},
		slanted_inverted = {
			prefix = "",
			suffix = "",
			breadcrumbs_separator = "  ",
		},
		sloped = {
			prefix = "",
			suffix = "",
			breadcrumbs_separator = "  ",
		},
		sloped_inverted = {
			prefix = "",
			suffix = "",
			breadcrumbs_separator = "  ",
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

		tab_inactive = prefix .. "TabInactive",
		tab_active = prefix .. "TabActive",
		section_separator = prefix .. "SectionSeparator",

		breadcrumb_fill = prefix .. "BreadcrumbFill",
		breadcrumb_item = prefix .. "BreadcrumbItem",
		breadcrumb_item_focus = prefix .. "BreadcrumbItemFocus",
		breadcrumb_separator = prefix .. "BreadcrumbSeparator",
	},
}
