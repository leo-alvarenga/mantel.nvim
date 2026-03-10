local utils = require("mantel-nvim.utils")
local default_hl = require("mantel-nvim.config.default.highlights")

--- @param bufnr integer
--- @return integer?
local function get_relevant_diagnostics(bufnr)
	local diagnostics = vim.diagnostic.get(bufnr)

	if #diagnostics == 0 then
		return nil
	end

	--- @type integer
	local diag = vim.iter(diagnostics):fold(vim.diagnostic.severity.HINT, function(acc, diagnostic)
		if diagnostic.severity < acc then
			return diagnostic.severity
		end

		return acc
	end)

	return diag
end

--- @param buf vim.fn.getbufinfo.ret.item
--- @return mantel-nvim.BufAwareStr
local function get_diagnostics_hl(buf)
	local is_curr = utils.is_current_buf(buf.bufnr)
	local diag = get_relevant_diagnostics(buf.bufnr)

	if not diag then
		return ""
	end

	local options = {
		[vim.diagnostic.severity.ERROR] = is_curr and default_hl.diagnostics_error
			or default_hl.diagnostics_error_inactive,
		[vim.diagnostic.severity.WARN] = is_curr and default_hl.diagnostics_warn
			or default_hl.diagnostics_warn_inactive,
	}

	return options[diag] or ""
end

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
		position = "prefix",
		hl = function(buf)
			local hl = get_diagnostics_hl(buf)

			return utils.evaluate_buf_aware_option(hl, buf)
		end,
		text = function(buf)
			local diag = get_relevant_diagnostics(buf.bufnr) or 0

			local symbols = {
				[vim.diagnostic.severity.ERROR] = " ",
				[vim.diagnostic.severity.WARN] = " ",
			}

			if symbols[diag] then
				return symbols[diag] .. " "
			end

			return ""
		end,
	},
}
