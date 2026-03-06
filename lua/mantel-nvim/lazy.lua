local lazy = {}

--- Requires the module after the first index of a module; Module MUST be a table
---@param require_path string
---@return table
function lazy.require(require_path)
	return setmetatable({}, {
		__index = function(_, key)
			return require(require_path)[key]
		end,

		__newindex = function(_, key, value)
			require(require_path)[key] = value
		end,
	})
end

return lazy
