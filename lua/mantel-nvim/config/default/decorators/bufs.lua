local utils = require("mantel-nvim.utils")
local default_hl = require("mantel-nvim.config.default.highlights")

--- @type mantel-nvim.Decorators
return {
	sep = "",
	prefix = "| ",
	suffix = " ",
	modified = {
		name = "modified",
		order = 1,
		text = " ●",
		position = "suffix",
	},

	diagnostics = {
		name = "diagnostics",
		order = 2,
		position = "name_before",
		hl = function(buf)
			local hl = default_hl.diagnostics_error_inactive

			if utils.is_current_buf(buf.bufnr) then
				hl = default_hl.diagnostics_error
			end

			return utils.evaluate_buf_aware_option(hl, buf)
		end,
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

			local res = ""

			local symbols = {
				[vim.diagnostic.severity.ERROR] = " ",
				[vim.diagnostic.severity.WARN] = " ",
			}

			if symbols[diag] then
				res = symbols[diag] .. " "
			end

			return res
		end,
	},
}
