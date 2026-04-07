--- @meta

--- @alias mantel-nvim.PresetName
--- | "none"
--- | "sloped"
--- | "arrow"
--- | "slanted"

--- @class mantel-nvim.Preset
--- @field left string
--- @field right string
--- @field separator string
--- @field ellipsis string
--- @field ignore_first_and_last_edges boolean

--- @class mantel-nvim.PartialPreset
--- @field left string?
--- @field right string?
--- @field separator string?
--- @field ellipsis string?
--- @field ignore_first_and_last_edges boolean?

--- @alias mantel-nvim.PresetTable table<mantel-nvim.PresetName, mantel-nvim.Preset>

--- @class mantel-nvim.Icons
--- @field enabled boolean
--- @field modified string

--- @class mantel-nvim.HighlightGroups
--- @field fill string
--- @field active string
--- @field inactive string
--- @field edge string
--- @field edge_inactive string
--- @field tab_active string
--- @field tab_inactive string

--- @class mantel-nvim.Opts
--- @field tabpages string
--- @field min_buffer_len integer
--- @field buffer_padding integer
--- @field preset mantel-nvim.PresetName
--- @field override mantel-nvim.PartialPreset
--- @field hl mantel-nvim.HighlightGroups
--- @field icons mantel-nvim.Icons

return {}
