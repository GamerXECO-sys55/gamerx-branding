# GamerX OS — Color Palette

The official color spec. Used by every theme package, GRUB, Plymouth, SDDM,
hyprlock, walker, swaync, Waybar, Quickshell, GTK, Qt, terminal, and the
website.

## Brand colors

| Token | Hex | RGB | Use |
|---|---|---|---|
| `--gx-cyan` | `#00D9FF` | `0, 217, 255` | Primary accent — system tone |
| `--gx-magenta` | `#FF2EC4` | `255, 46, 196` | Secondary accent — agent (Aria) tone |
| `--gx-purple` | `#7C3AED` | `124, 58, 237` | Tertiary accent — default brand color |
| `--gx-deep` | `#0A0E1A` | `10, 14, 26` | Deepest background |
| `--gx-base` | `#11162A` | `17, 22, 42` | Default background |
| `--gx-surface` | `#1B2241` | `27, 34, 65` | Surface (cards, panels) |
| `--gx-surface-2` | `#2A3158` | `42, 49, 88` | Elevated surface |
| `--gx-text` | `#E6EAF8` | `230, 234, 248` | Primary text |
| `--gx-muted` | `#8A93B8` | `138, 147, 184` | Secondary text |
| `--gx-warn` | `#FFB347` | `255, 179, 71` | Warnings |
| `--gx-error` | `#FF5C7C` | `255, 92, 124` | Errors / destructive |
| `--gx-success` | `#5BE3A1` | `91, 227, 161` | Success |

## Default palette: GamerX Purple

The out-of-the-box palette. Chosen because:
- Purple sits between the cyan/magenta accents, so the duotone identity feels
  unified rather than competing.
- Reads as "premium gamer" without leaning into cliché red/green.
- Matches well with cyberpunk wallpapers we'll bundle.

```toml
[gamerx-purple]
name        = "GamerX Purple"
mode        = "dark"
bg          = "#11162A"
bg_alt      = "#1B2241"
fg          = "#E6EAF8"
fg_dim      = "#8A93B8"
accent      = "#7C3AED"   # purple
accent_alt  = "#00D9FF"   # cyan
highlight   = "#FF2EC4"   # magenta
warn        = "#FFB347"
error       = "#FF5C7C"
success     = "#5BE3A1"
border      = "#2A3158"
```

## Bundled palettes

All bundled palettes follow the same TOML schema. Files live in
`palettes/<name>.toml` and are consumed by `gamerx-theme`.

| Palette | Mode | Default? |
|---|---|---|
| `gamerx-purple` | dark | ✅ |
| `gamerx-cyber` | dark | |
| `catppuccin-mocha` | dark | |
| `tokyo-night` | dark | |
| `gruvbox-dark` | dark | |
| `rose-pine` | dark | |
| `nord` | dark | |

## Matugen integration

`gamerx-theme set palette auto` runs `matugen` against the current wallpaper to
generate a Material You palette and writes it as `~/.config/gamerx/palettes/_auto.toml`.
The CLI then applies it like any bundled palette.

## Gradients

Branding-grade gradients for posters, wallpapers, splash:

| Name | Stops | Use |
|---|---|---|
| `gx-aurora` | `#00D9FF → #7C3AED → #FF2EC4` | Hero gradient, GRUB, Plymouth |
| `gx-eclipse` | `#0A0E1A → #1B2241 → #7C3AED` | Subtle backgrounds |
| `gx-pulse` | `#7C3AED → #FF2EC4` | Buttons, focus rings |
| `gx-deep` | `#0A0E1A → #11162A` | Wallpaper baselines |

## Contrast ratios (WCAG AA target)

| Foreground | Background | Ratio | Pass |
|---|---|---|---|
| `--gx-text` | `--gx-base` | 13.9 : 1 | AAA |
| `--gx-text` | `--gx-surface` | 11.2 : 1 | AAA |
| `--gx-muted` | `--gx-base` | 5.8 : 1 | AA |
| `--gx-cyan` | `--gx-base` | 9.2 : 1 | AAA |
| `--gx-magenta` | `--gx-base` | 5.4 : 1 | AA |
| `--gx-purple` | `--gx-base` | 4.6 : 1 | AA Large |

> Purple at AA Large means we don't use it on small body text (we use it on
> headings, accents, large UI surfaces). For small text on dark bg use cyan or
> the text color.
