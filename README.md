# gamerx-branding

All visual assets for GamerX OS — logos, wallpapers, GRUB / Plymouth / SDDM /
hyprlock themes.

## Layout (planned)

```
logos/
├── wordmark.svg
├── wordmark-light.svg
├── orb.svg
├── orb-mono.svg
└── icon-set/                # 16, 32, 64, 128, 256, 512 px PNGs

wallpapers/
├── default/                 # 8 bundled in the ISO
└── extra/                   # available via repo

themes/
├── gamerx-grub-theme/       # GRUB 2 theme
├── gamerx-plymouth-theme/   # Plymouth animation
├── gamerx-sddm-theme/       # SDDM greeter
├── gamerx-hyprlock-theme/   # hyprlock styling
└── gamerx-icon-theme/       # symlink set on top of Papirus

palettes/
├── gamerx-cyber.json        # default
├── gamerx-purple.json
├── catppuccin-mocha.json
├── tokyo-night.json
├── gruvbox-dark.json
├── rose-pine.json
└── nord.json

os-release-template
lsb-release-template
```

## Asset generation policy

- v0 assets are generated programmatically (SVG, gradients, simple Plymouth animation).
- High-quality assets are commissioned/generated later (Midjourney, Stable Diffusion, Flux).
- Every placeholder is marked with `# v0-placeholder` so we know what to swap.
- License: branding/assets are CC-BY-NC-SA 4.0 (we keep commercial brand rights).

## Status

🛠 **Phase 1 — in progress.**

## See also

- [Meta repo](https://github.com/GamerXECO-sys55/gamerx-os) — spec, roadmap, decisions

## License

CC-BY-NC-SA 4.0 (assets) — see individual file headers.
GPL-3.0 for any tooling scripts.
