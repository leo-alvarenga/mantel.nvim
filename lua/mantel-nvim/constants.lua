local prefix = "Mantel"

return {
	prefix = prefix,

	hl_groups = {
		fill = "MantelFill",
		inactive = "MantelInactive",
		active = "MantelActive",
		modified = "MantelModified",
		duplicate = "MantelDuplicate",
		separator = "MantelSeparator",
	},

	notifications = {
		invalid_buf_movement = {
			title = "Mantel: Invalid Buffer Movement",
			message = "Buffer movement is only available in 'enhanced' mode",
			level = vim.log.levels.WARN,
		},
	},
}
