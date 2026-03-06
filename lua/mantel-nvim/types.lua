--- @meta

--- @alias mantel-nvim.Positionable
--- | 'name_before'
--- | 'name_after'
--- | 'prefix'
--- | 'suffix'

--- @alias mantel-nvim.BufAwareText
--- | string
--- | fun(buf: vim.fn.getbufinfo.ret.item): string

--- @class mantel-nvim.PositionableDecorator
--- @field enabled nil|boolean|fun(): boolean?
--- @field order integer Order in which the decorator should be applied; Lower numbers are applied first
--- @field text mantel-nvim.BufAwareText
--- @field position mantel-nvim.Positionable

--- @class mantel-nvim.Decorators
--- @field sep string|fun(): string?
--- @field prefix string|fun(): string?
--- @field suffix string|fun(): string?
--- @field modified mantel-nvim.PositionableDecorator?
--- @field duplicate mantel-nvim.PositionableDecorator?
---
--- @alias mantel-nvim.HlEntry
--- |vim.api.keyset.highlight
--- |fun(): vim.api.keyset.highlight

--- @class mantel-nvim.HighlightOverwrites
--- @field fill mantel-nvim.HlEntry
--- @field inactive mantel-nvim.HlEntry
--- @field active mantel-nvim.HlEntry
--- @field modified mantel-nvim.HlEntry
--- @field duplicate mantel-nvim.HlEntry
--- @field separator mantel-nvim.HlEntry

--- @class mantel-nvim.BufContentOverwrites
--- @field ambiguos mantel-nvim.BufAwareText
--- @field name mantel-nvim.BufAwareText
--- @field no_name mantel-nvim.BufAwareText

--- @class mantel-nvim.HighlightGroups represents the highlight groups used by a component/section of mantel-nvim. These groups should be defined in the user's colorscheme or by mantel-nvim's setup function (default values).
--- @field fill string
--- @field inactive string
--- @field active string
--- @field modified string
--- @field duplicate string
--- @field separator string

--- @class mantel-nvim.Bufs
--- @field decorators mantel-nvim.Decorators
--- @field hl mantel-nvim.HighlightGroups
--- @field min_width integer Minimum width for each buffer in the tabline
--- @field overwrites mantel-nvim.BufContentOverwrites

--- @alias mantel-nvim.TabBehavior
--- | "auto"
--- |"always"
--- |"never"

--- @class mantel-nvim.Tabs
--- @field decorators mantel-nvim.Decorators
--- @field hl mantel-nvim.HighlightGroups
--- @field enabled boolean|mantel-nvim.TabBehavior "auto" to enable only when more than 1 tab is open; 'true' 'always' to always enable; 'false' or 'never' to disable
--- @field min_width integer Minimum width for each tab in the tabline

--- @class mantel-nvim.Opts
--- @field bufs mantel-nvim.Bufs
--- @field tabs mantel-nvim.Tabs
--- @field highlight_overwrites mantel-nvim.HighlightOverwrites

return {}
