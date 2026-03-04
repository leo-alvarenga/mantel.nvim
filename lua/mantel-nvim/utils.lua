local M = {}

M.fmt = string.format

--- @param hl string
function M.hl(hl)
	if type(hl) ~= "string" or #hl < 1 then
		return ""
	end

	return M.fmt("%%#%s#", hl)
end

return M
