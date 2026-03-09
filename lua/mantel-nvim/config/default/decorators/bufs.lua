--- @type mantel-nvim.Decorators
return {
	sep = "",
	prefix = "| ",
	suffix = " ",
	modified = {
		order = 1,
		text = " ●",
		position = "suffix",
	},

	diagnostics = {
		order = 2,
		position = "name_before",
		text = function(buf)
			local diagnostics = vim.diagnostic.get(buf.bufnr)

			if #diagnostics == 0 then
				return ""
			end

			--- @type integer
			local diag = vim.iter(diagnostics):fold(vim.diagnostic.severity.HINT, function(acc, diagnostic)
				if diagnostic.severity < acc then
					return diagnostic.severity
				end

				return acc
			end)

			local symbols = {
				[vim.diagnostic.severity.ERROR] = " ",
				[vim.diagnostic.severity.WARN] = " ",
				[vim.diagnostic.severity.INFO] = " ",
				[vim.diagnostic.severity.HINT] = " ",
			}

			return symbols[diag] or ""
		end,
	},
}
