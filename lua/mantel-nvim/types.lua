--- @meta

--- @class mantel-nvim.HL
--- @field fill string
--- @field background string
--- @field inactive string
--- @field visible string
--- @field active string
--- @field modified string
--- @field duplicate string
--- @field error string
--- @field warn string
--- @field info string
--- @field hint string
--- @field separator string
--- @field breadcrumb string

--- @class mantel-nvim.Bufs
--- @field hl mantel-nvim.HL
--- @field min_width integer Minimum width for each buffer in the tabline
--- @field no_name_overwrite string|fun(): string

--- @alias mantel-nvim.TabBehavior
--- | "auto"
--- |"always"
--- |"never"

--- @class mantel-nvim.Tabs
--- @field hl mantel-nvim.HL
--- @field enabled boolean|mantel-nvim.TabBehavior "auto" to enable only when more than 1 tab is open; 'true' 'always' to always enable; 'false' or 'never' to disable
--- @field min_width integer Minimum width for each tab in the tabline

--- @class mantel-nvim.Opts
--- @field bufs mantel-nvim.Bufs
--- @field tabs mantel-nvim.Tabs

return {}
