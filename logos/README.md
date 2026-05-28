# Logos

| File | Description | Use |
|---|---|---|
| `wordmark.svg` | "GamerX OS" with hex+GX mark, aurora gradient, dark backgrounds | Website hero, README, GRUB, splash |
| `wordmark-light.svg` | Same wordmark tuned for light backgrounds | Print, light mode docs |
| `orb.svg` | Hex+orb mark, full-color, gradient | Favicons, tray, app icon, watermark |
| `orb-mono.svg` | Single-color version that uses `currentColor` | Status bars, tray icons, anywhere needing tinting |
| `png/` | Rendered PNG previews at common sizes | Quick visual reference; do not edit |

## Status

🛠 **v0 — programmatically generated.** These are intentionally simple so we
can iterate. Replace with high-quality versions from generative tooling
(Midjourney / Stable Diffusion / Flux) before v1.0 release.

Each file is marked `# v0-placeholder` in its header where applicable.

## Construction notes

The mark is a hexagonal container (a respectful nod to Arch's geometric
heritage without copying it) wrapping a stylized **G** with an **X** crossed
through it. The hex is duotone aurora cyan→purple→magenta. The orb variant
swaps the GX for a glowing core, used when we need a "live" mark for animation
(Plymouth, Aria status, app icon).

## Regenerating PNG previews

```bash
cd logos
mkdir -p png
rsvg-convert -h 256 orb.svg -o png/orb-256.png
rsvg-convert -h 64  orb-mono.svg -o png/orb-mono-64.png
rsvg-convert -h 200 wordmark.svg -o png/wordmark-200.png
rsvg-convert -h 200 wordmark-light.svg -o png/wordmark-light-200.png
```

## License

CC-BY-NC-SA 4.0 (attribution required, non-commercial, share-alike).
GamerX brand identity rights reserved.
