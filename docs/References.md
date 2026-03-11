# References

## Options

| Field                  | Type                                          | Description                          | Default                  |
| ---------------------- | --------------------------------------------- | ------------------------------------ | ------------------------ |
| `mode`                 | `"classic" \| "enhanced"`                     | Buffer ordering behavior             | `"classic"`              |
| `bufs`                 | `mantel-nvim.Bufs`                            | Buffer configuration                 | see below                |
| `tabs`                 | `mantel-nvim.Tabs`                            | Tab configuration                    | see below                |
| `highlight_overwrites` | `mantel-nvim.HighlightOverwrites \| function` | Highlight definitions used by Mantel | derived from colorscheme |

### Buffer Options

| Field                | Type                                  | Default       |
| -------------------- | ------------------------------------- | ------------- |
| `decorators.sep`     | `string`                              | `""`          |
| `decorators.prefix`  | `string`                              | `""`          |
| `decorators.suffix`  | `string`                              | `" "`         |
| `decorators.native`  | `mantel-nvim.PositionableDecorator[]` | `table`       |
| `decorators.extras`  | `mantel-nvim.PositionableDecorator[]` | `table`       |
| `min_width`          | `integer`                             | `10`          |
| `overwrites.no_name` | `string`                              | `"[No name]"` |

### Tab Options

| Field       | Type                            | Default  |
| ----------- | ------------------------------- | -------- |
| `enabled`   | `"auto" \| "always" \| "never"` | `"auto"` |
| `min_width` | `integer`                       | `5`      |

## Types

Requiring the `mantel-nvim.types` module exposes types for autocompletion and other goodies:

```lua
require("mantel-nvim.types")
```

```lua
--- @class mantel-nvim.Opts
--- @field mode "classic"|"enhanced"
--- @field bufs mantel-nvim.Bufs
--- @field tabs mantel-nvim.Tabs
--- @field highlight_overwrites mantel-nvim.HighlightOverwrites|fun(): mantel-nvim.HighlightOverwrites
```
