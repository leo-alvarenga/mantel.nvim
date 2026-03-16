--- @meta

--- @alias mantel-nvim.HlEntry
--- | vim.api.keyset.highlight
--- | fun(buf: vim.fn.getbufinfo.ret.item): vim.api.keyset.highlight

--- @class mantel-nvim.HighlightOverwrites
--- @field fill mantel-nvim.HlEntry
--- @field inactive mantel-nvim.HlEntry
--- @field active mantel-nvim.HlEntry
--- @field separator mantel-nvim.HlEntry
--- @field prefix mantel-nvim.HlEntry
--- @field suffix mantel-nvim.HlEntry
--- @field prefix_inactive mantel-nvim.HlEntry
--- @field suffix_inactive mantel-nvim.HlEntry
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
--- @field prefix mantel-nvim.BufAwareStr
--- @field suffix mantel-nvim.BufAwareStr
--- @field prefix_inactive mantel-nvim.BufAwareStr
--- @field suffix_inactive mantel-nvim.BufAwareStr
--- @field diagnostics_error mantel-nvim.BufAwareStr
--- @field diagnostics_warn mantel-nvim.BufAwareStr
--- @field diagnostics_info mantel-nvim.BufAwareStr
--- @field diagnostics_hint mantel-nvim.BufAwareStr
--- @field diagnostics_error_inactive mantel-nvim.BufAwareStr
--- @field diagnostics_warn_inactive mantel-nvim.BufAwareStr
--- @field diagnostics_info_inactive mantel-nvim.BufAwareStr
--- @field diagnostics_hint_inactive mantel-nvim.BufAwareStr

--- @class mantel-nvim.TabHighlightGroups
--- @field fill string
--- @field inactive string
--- @field active string
--- @field modified string
--- @field duplicate string
--- @field separator string
--- @field diagnostics_error string
--- @field diagnostics_warn string
--- @field diagnostics_info string
--- @field diagnostics_hint string
--- @field diagnostics_error_inactive string
--- @field diagnostics_warn_inactive string
--- @field diagnostics_info_inactive string
--- @field diagnostics_hint_inactive string

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
--- @field name string A user-friendly name for the decorator, useful for configuration
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
--- @field min_padding integer Minimum padding (blank spaces) on each side of the buffer name
--- @field overwrites mantel-nvim.BufContentOverwrites

------------------------------------------
---  Tabs
------------------------------------------

--- @alias mantel-nvim.TabBehavior
--- | "auto"
--- | "always"
--- | "never"

--- @class mantel-nvim.Tabs
--- @field hl mantel-nvim.TabHighlightGroups
--- @field enabled boolean|mantel-nvim.TabBehavior "auto" to enable only when more than 1 tab is open (default); 'true' 'always' to always enable; 'false' or 'never' to disable
--- @field min_width integer Minimum width for each tab in the tabline

------------------------------------------
---  Opts
------------------------------------------

--- @alias mantel-nvim.OptsBehavior
--- | "classic"
--- | "enhanced"

--- @alias mantel-nvim.StylePreset
--- | "default"
--- | "slanted"
--- | "slanted_inverted"
--- | "sloped"
--- | "sloped_inverted"

--- @class mantel-nvim.Style
--- @field preset mantel-nvim.StylePreset
--- @field ignore_first_buffer_prefix boolean? If true, the first buffer (left to right) will not have a custom prefix

--- @class mantel-nvim.Opts
--- @field displayWarning boolean? If true, mantel-nvim will show the warning message when the user tries to use it
--- @field mode mantel-nvim.OptsBehavior "classic" for a traditional tabline/bufferline xp (default); "enhanced" for a more dynamic approach, keeping buffers in order of opening
--- @field style mantel-nvim.Style "default" for straight edges (default); "slanted" for slanted edges; "sloped" for sloped edges
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
