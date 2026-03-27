local consts = require("mantel-nvim.constants")

--- @type mantel-nvim.HighlightGroups
return {
	fill = consts.hl_groups.fill,
	inactive = consts.hl_groups.inactive,
	active = consts.hl_groups.active,
	section_separator = consts.hl_groups.section_separator,
	tab_inactive = consts.hl_groups.tab_inactive,
	tab_active = consts.hl_groups.tab_active,
	modified = consts.hl_groups.modified,
	duplicate = consts.hl_groups.duplicate,
	separator = consts.hl_groups.separator,
	prefix = consts.hl_groups.prefix,
	suffix = consts.hl_groups.suffix,
	prefix_inactive = consts.hl_groups.prefix_inactive,
	suffix_inactive = consts.hl_groups.suffix_inactive,
	diagnostics_error = consts.hl_groups.diagnostics_error,
	diagnostics_warn = consts.hl_groups.diagnostics_warn,
	diagnostics_info = consts.hl_groups.diagnostics_info,
	diagnostics_hint = consts.hl_groups.diagnostics_hint,
	diagnostics_error_inactive = consts.hl_groups.diagnostics_error_inactive,
	diagnostics_warn_inactive = consts.hl_groups.diagnostics_warn_inactive,
	diagnostics_info_inactive = consts.hl_groups.diagnostics_info_inactive,
	diagnostics_hint_inactive = consts.hl_groups.diagnostics_hint_inactive,
}
