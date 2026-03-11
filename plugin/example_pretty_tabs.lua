return {
	"leo-alvarenga/mantel.nvim",
	branch = "nightly",
	opts = {
		mode = "enhanced",

		bufs = {
			decorators = {
				sep = " ",
				prefix = "",
				suffix = "",

				extras = {
					{
						order = 1,
						position = "prefix",
						name = "prefix_custom",
						text = " ",
					},

					{
						order = 1,
						position = "suffix",
						name = "prefix_suffix",
						text = " ",
					},
				},
			},
		},

		highlight_overwrites = function()
			local statusline = vim.api.nvim_get_hl(0, { name = "StatusLine" })
			local tabsel = vim.api.nvim_get_hl(0, { name = "TabLineSel" })
			local diag_info = vim.api.nvim_get_hl(0, { name = "DiagnosticInfo" })

			return {
				inactive = {
					bg = tabsel.bg,
					fg = statusline.bg,
				},
				active = {
					bg = diag_info.fg,
					fg = statusline.bg,
					bold = true,
				},
				separator = {
					bg = statusline.bg,
					fg = statusline.bg,
				},
			}
		end,
	},
}
