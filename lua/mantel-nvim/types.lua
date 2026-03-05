--- @meta

--- @class mantel-nvim.Bufs
--- @field min_width integer Minimum width for each buffer in the tabline
--- @field no_name_overwrite string|fun(): string

--- @class mantel-nvim.HL
--- @field tabline_sel string
--- @field tabfill string
--- @field tabline string
--- @field tabsep string

--- @alias mantel-nvim.TabBehavior
--- | "auto"
--- |"always"
--- |"never"

--- @class mantel-nvim.Tabs
--- @field enabled boolean|mantel-nvim.TabBehavior "auto" to enable only when more than 1 tab is open; 'true' 'always' to always enable; 'false' or 'never' to disable
--- @field min_width integer Minimum width for each tab in the tabline

--- @class mantel-nvim.Opts
--- @field bufs mantel-nvim.Bufs
--- @field hl mantel-nvim.HL
--- @field tabs mantel-nvim.Tabs

return {}
