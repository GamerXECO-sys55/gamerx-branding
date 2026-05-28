#!/usr/bin/env bash
# Render PNG assets for the Plymouth theme from SVG sources.
set -euo pipefail
cd "$(dirname "$(readlink -f "$0")")"

# Background reuses the same SVG as GRUB
rsvg-convert -w 1920 -h 1080 ../gamerx-grub-theme/background.svg -o background.png

# Orb (256px is enough — Plymouth scales)
rsvg-convert -h 256 ../../logos/orb.svg -o orb.png

# Wordmark (small; positioned under the orb)
rsvg-convert -h 60 ../../logos/wordmark.svg -o wordmark.png

# Password prompt box
python3 - <<'PY'
from PIL import Image, ImageDraw
img = Image.new("RGBA", (480, 64), (0, 0, 0, 0))
d = ImageDraw.Draw(img)
d.rounded_rectangle((1, 1, 478, 62), radius=14, fill=(17, 22, 42, 220), outline=(124, 58, 237, 255), width=2)
img.save("box.png")
PY

echo "build.sh: ok"
