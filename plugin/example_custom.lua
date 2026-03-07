-- Youll need a nerd font for this one, but it looks pretty nice. You can also customize the colors by changing the highlight_overwrites function

return {
	"leo-alvarenga/mantel.nvim",
	branch = "nightly",
	opts = {
		bufs = {
			decorators = {
				prefix = " ",
				suffix = " ",
			},
		},

		highlight_overwrites = function()
			local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
			local statusline = vim.api.nvim_get_hl(0, { name = "StatusLine" })

			return {
				inactive = {
					fg = statusline.bg,
					bg = normal.bg,
				},
				active = {
					fg = statusline.bg,
					bg = statusline.fg,
					bold = true,
				},
			}
		end,
	},
}
