--- @meta

--- @alias mantel-nvim.Positionable
--- | 'name_before'
--- | 'name_after'
--- | 'prefix'
--- | 'suffix'

--- @class mantel-nvim.PositionableDecorator
--- @field enabled nil|boolean|fun(): boolean?
--- @field order integer Order in which the decorator should be applied; Lower numbers are applied first
--- @field text string|fun(): string
--- @field position mantel-nvim.Positionable

--- @class mantel-nvim.Decorators
--- @field sep string|fun(): string?
--- @field prefix string|fun(): string?
--- @field suffix string|fun(): string?
--- @field modified mantel-nvim.PositionableDecorator?
--- @field duplicate mantel-nvim.PositionableDecorator?

--- @class mantel-nvim.BufContentOverwrites
--- @field ambiguos string|fun(buf: vim.fn.getbufinfo.ret.item): string
--- @field name string|fun(buf: vim.fn.getbufinfo.ret.item): string
--- @field no_name string|fun(buf: vim.fn.getbufinfo.ret.item): string

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
--- @field decorators mantel-nvim.Decorators
--- @field hl mantel-nvim.HL
--- @field min_width integer Minimum width for each buffer in the tabline
--- @field overwrites mantel-nvim.BufContentOverwrites

--- @alias mantel-nvim.TabBehavior
--- | "auto"
--- |"always"
--- |"never"

--- @class mantel-nvim.Tabs
--- @field decorators mantel-nvim.Decorators
--- @field hl mantel-nvim.HL
--- @field enabled boolean|mantel-nvim.TabBehavior "auto" to enable only when more than 1 tab is open; 'true' 'always' to always enable; 'false' or 'never' to disable
--- @field min_width integer Minimum width for each tab in the tabline

--- @class mantel-nvim.Opts
--- @field bufs mantel-nvim.Bufs
--- @field tabs mantel-nvim.Tabs

return {}
