--- @meta

--- @alias mantel-nvim.HlEntry
--- | vim.api.keyset.highlight
--- | fun(buf: vim.fn.getbufinfo.ret.item): vim.api.keyset.highlight

--- @class mantel-nvim.HighlightOverwrites
--- @field fill mantel-nvim.HlEntry
--- @field inactive mantel-nvim.HlEntry
--- @field active mantel-nvim.HlEntry
--- @field modified mantel-nvim.HlEntry
--- @field duplicate mantel-nvim.HlEntry
--- @field separator mantel-nvim.HlEntry
--- @field diagnostics_error mantel-nvim.HlEntry
--- @field diagnostics_warn mantel-nvim.HlEntry
--- @field diagnostics_info mantel-nvim.HlEntry
--- @field diagnostics_hint mantel-nvim.HlEntry
--- @field diagnostics_error_inactive mantel-nvim.HlEntry
--- @field diagnostics_warn_inactive mantel-nvim.HlEntry
--- @field diagnostics_info_inactive mantel-nvim.HlEntry
--- @field diagnostics_hint_inactive mantel-nvim.HlEntry

--- Represents the highlight groups used by a component/section of mantel-nvim. These groups should be:
---
--- * valid highlight groups defined in Neovim
---     OR
--- * defined by the user's colorscheme
---     OR
--- * defined by mantel-nvim's setup function (default values).
--- @class mantel-nvim.HighlightGroups
--- @field fill string
--- @field inactive mantel-nvim.BufAwareStr
--- @field active mantel-nvim.BufAwareStr
--- @field modified mantel-nvim.BufAwareStr
--- @field duplicate mantel-nvim.BufAwareStr
--- @field separator mantel-nvim.BufAwareStr
--- @field diagnostics_error mantel-nvim.BufAwareStr
--- @field diagnostics_warn mantel-nvim.BufAwareStr
--- @field diagnostics_info mantel-nvim.BufAwareStr
--- @field diagnostics_hint mantel-nvim.BufAwareStr
--- @field diagnostics_error_inactive mantel-nvim.BufAwareStr
--- @field diagnostics_warn_inactive mantel-nvim.BufAwareStr
--- @field diagnostics_info_inactive mantel-nvim.BufAwareStr
--- @field diagnostics_hint_inactive mantel-nvim.BufAwareStr

------------------------------------------
---  Buffers
------------------------------------------

--- @alias mantel-nvim.BufAwareNumber
--- | number
--- | fun(buf: vim.fn.getbufinfo.ret.item): number

--- @alias mantel-nvim.BufAwareStr
--- | string
--- | fun(buf: vim.fn.getbufinfo.ret.item): string

--- @alias mantel-nvim.Positionable
--- | 'name_before'
--- | 'name_after'
--- | 'prefix'
--- | 'suffix'

--- @class mantel-nvim.PositionableDecorator
--- @field disabled boolean?
--- @field name string A user-friendly name for the decorator, useful for configuration and debugging
--- @field order mantel-nvim.BufAwareNumber
--- @field text mantel-nvim.BufAwareStr
--- @field position mantel-nvim.Positionable
--- @field hl mantel-nvim.BufAwareStr?

--- @class mantel-nvim.Decorators
--- @field sep mantel-nvim.BufAwareStr?
--- @field prefix mantel-nvim.BufAwareStr?
--- @field suffix mantel-nvim.BufAwareStr?
--- @field native mantel-nvim.PositionableDecorator[]? Native decorators are those that mantel-nvim provides out of the box, such as diagnostics, modified status, and duplicate status
--- @field extras mantel-nvim.PositionableDecorator[]?

--- @class mantel-nvim.BufContentOverwrites
--- @field ambiguos mantel-nvim.BufAwareStr
--- @field name mantel-nvim.BufAwareStr
--- @field no_name mantel-nvim.BufAwareStr

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
--- @field debug boolean?
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
