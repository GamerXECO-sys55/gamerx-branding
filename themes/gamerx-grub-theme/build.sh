#!/usr/bin/env bash
# Bake the SVG sources into the PNGs GRUB expects.
# Idempotent. Run before packaging or when assets change.
set -euo pipefail
cd "$(dirname "$(readlink -f "$0")")"

# Background
rsvg-convert -w 1920 -h 1080 background.svg -o background.png

# 9-patch boxes for the menu items.  Generated programmatically below as PNGs.
python3 - <<'PY'
from PIL import Image, ImageDraw
def stretch_box(name, fill, stroke, w=120, h=48, r=10, accent=False):
    img = Image.new("RGBA", (w, h), (0, 0, 0, 0))
    d = ImageDraw.Draw(img)
    d.rounded_rectangle((1, 1, w-2, h-2), radius=r, fill=fill, outline=stroke, width=2)
    if accent:
        d.line((6, h-3, 30, h-3), fill=stroke, width=2)
    img.save(name)

# Idle item
stretch_box("item_c.png", (27, 34, 65, 0), (42, 49, 88, 200))
# Selected item
stretch_box("selected_item_c.png", (124, 58, 237, 80), (124, 58, 237, 255), accent=True)
# Terminal box
stretch_box("terminal_box_c.png", (17, 22, 42, 230), (42, 49, 88, 255))
PY

# GRUB needs corner+edge pieces too. We use the same image for every slice
# (works because the radius is small enough that each tile is functionally
# identical at GRUB's rendering scale).
for prefix in item selected_item terminal_box; do
  for sfx in n s e w nw ne sw se; do
    cp "${prefix}_c.png" "${prefix}_${sfx}.png"
  done
done

echo "build.sh: ok"
