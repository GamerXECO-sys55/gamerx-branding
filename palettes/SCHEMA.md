# Palette TOML schema

Every bundled palette is a single TOML file under `palettes/`. The
`gamerx-theme` CLI loads one file at a time and renders configs for every
component.

## Sections

```toml
[meta]
id        = "string-id"   # used in CLI: gamerx-theme set palette <id>
name      = "Display name"
mode      = "dark" | "light"
default   = true | false  # at most one palette has default = true
author    = "GamerX" | "Catppuccin team" | ...
license   = "MIT" | "CC-BY-NC-SA-4.0" | ...

[base]
bg        = "#hex"  # primary background
bg_alt    = "#hex"  # alternate background (e.g. lockscreen, GRUB)
surface   = "#hex"  # cards, panels
surface_2 = "#hex"  # elevated surface
fg        = "#hex"  # primary text
fg_dim    = "#hex"  # secondary text
border    = "#hex"  # ui borders

[accent]
primary   = "#hex"  # main accent (window border, focus, brand)
secondary = "#hex"  # secondary accent
tertiary  = "#hex"  # third accent (highlights, emphasis)

[state]
warn      = "#hex"
error     = "#hex"
success   = "#hex"
info      = "#hex"

[terminal]
# Standard 16-color ANSI map
black through bright_white
```

## Bundled palettes

| ID | Name | Mode | Source |
|---|---|---|---|
| `gamerx-purple` | GamerX Purple | dark | original (default) |
| `gamerx-cyber` | GamerX Cyber | dark | original |
| `catppuccin-mocha` | Catppuccin Mocha | dark | upstream Catppuccin (MIT) |
| `tokyo-night` | Tokyo Night | dark | upstream (MIT) |
| `gruvbox-dark` | Gruvbox Dark | dark | upstream (MIT) |
| `rose-pine` | Rosé Pine | dark | upstream (MIT) |
| `nord` | Nord | dark | upstream (MIT) |

## Notes

- We always credit upstream palettes via `[meta].author` and `[meta].license`.
- Light-mode palettes are not bundled in v1.0 (deferred to v1.1).
- A user-imported palette goes to `~/.config/gamerx/palettes/` and is picked up automatically.
- A `matugen`-generated palette is written to `~/.config/gamerx/palettes/_auto.toml` and named "Auto".
