--- @meta

--- @alias mantel-nvim.HlEntry
--- | vim.api.keyset.highlight
--- | fun(): vim.api.keyset.highlight

--- @class mantel-nvim.HighlightOverwrites
--- @field fill mantel-nvim.HlEntry
--- @field inactive mantel-nvim.HlEntry
--- @field active mantel-nvim.HlEntry
--- @field modified mantel-nvim.HlEntry
--- @field duplicate mantel-nvim.HlEntry
--- @field separator mantel-nvim.HlEntry

--- Represents the highlight groups used by a component/section of mantel-nvim. These groups should be:
---
--- * valid highlight groups defined in Neovim
---     OR
--- * defined by the user's colorscheme
---     OR
--- * defined by mantel-nvim's setup function (default values).
--- @class mantel-nvim.HighlightGroups
--- @field fill string
--- @field inactive string
--- @field active string
--- @field modified string
--- @field duplicate string
--- @field separator string

------------------------------------------
---  Buffers
------------------------------------------

--- @alias mantel-nvim.BufAwareNumber
--- | number
--- | fun(buf: vim.fn.getbufinfo.ret.item): number

--- @alias mantel-nvim.BufAwareText
--- | string
--- | fun(buf: vim.fn.getbufinfo.ret.item): string

--- @alias mantel-nvim.Positionable
--- | 'name_before'
--- | 'name_after'
--- | 'prefix'
--- | 'suffix'

--- @class mantel-nvim.PositionableDecorator
--- @field order mantel-nvim.BufAwareNumber Order in which the decorator should be applied; Lower numbers are applied first
--- @field text mantel-nvim.BufAwareText
--- @field position mantel-nvim.Positionable

--- @class mantel-nvim.Decorators
--- @field sep mantel-nvim.BufAwareText?
--- @field prefix mantel-nvim.BufAwareText?
--- @field suffix mantel-nvim.BufAwareText?
--- @field git mantel-nvim.PositionableDecorator?
--- @field diagnostics mantel-nvim.PositionableDecorator?
--- @field modified mantel-nvim.PositionableDecorator?
--- @field duplicate mantel-nvim.PositionableDecorator?

--- @class mantel-nvim.BufContentOverwrites
--- @field ambiguos mantel-nvim.BufAwareText
--- @field name mantel-nvim.BufAwareText
--- @field no_name mantel-nvim.BufAwareText

--- @class mantel-nvim.Bufs
--- @field decorators mantel-nvim.Decorators
--- @field hl mantel-nvim.HighlightGroups
--- @field min_width integer Minimum width for each buffer in the tabline
--- @field overwrites mantel-nvim.BufContentOverwrites

------------------------------------------
---  Tabs
------------------------------------------

--- @alias mantel-nvim.TabBehavior
--- | "auto"
--- | "always"
--- | "never"

--- @class mantel-nvim.Tabs
--- @field hl mantel-nvim.HighlightGroups
--- @field enabled boolean|mantel-nvim.TabBehavior "auto" to enable only when more than 1 tab is open (default); 'true' 'always' to always enable; 'false' or 'never' to disable
--- @field min_width integer Minimum width for each tab in the tabline

------------------------------------------
---  Opts
------------------------------------------

--- @alias mantel-nvim.OptsBehavior
--- | "classic"
--- | "enhanced"

--- @class mantel-nvim.Opts
--- @field mode mantel-nvim.OptsBehavior "classic" for a traditional tabline/bufferline xp (default); "enhanced" for a more dynamic approach, keeping buffers in order of opening
--- @field bufs mantel-nvim.Bufs
--- @field tabs mantel-nvim.Tabs
--- @field highlight_overwrites mantel-nvim.HighlightOverwrites|fun(): mantel-nvim.HighlightOverwrites

------------------------------------------
---  State
------------------------------------------

--- @class mantel-nvim.State
--- @field mode mantel-nvim.OptsBehavior
--- @field buf_positions table<integer, integer>
--- @field next_position integer

return {}
