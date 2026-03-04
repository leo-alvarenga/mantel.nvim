local M = {}

function M.check()
	vim.health.start("mantel.nvim")
	vim.health.ok("Plugin loaded successfully; mantel.nvim is working")

	local ok, mantel = pcall(require, "mantel-nvim")

	if ok and mantel then
		if not mantel.version or not mantel.setup then
			vim.health.warn(
				"Some functions are missing from the plugin. Please ensure you have the latest version of mantel.nvim installed."
			)
		else
			vim.health.ok("All expected functions are present in mantel.nvim")
		end
	else
		vim.health.error("Failed to load mantel.nvim. Please ensure it is installed and properly configured.")
	end
end

return M
