#!/usr/bin/env bash
# Lossless, in-place image optimization for Hexo post assets.
# Usage:  bash .claude/skills/new-post/scripts/optimize-images.sh <directory>
# Run from the repo root. Re-encodes JPEGs (jpegtran, EXIF preserved) and PNGs
# (optipng) routing by REAL MIME type, keeping each result only if it is smaller.
set -euo pipefail

DIR="${1:?usage: optimize-images.sh <directory> (run from repo root)}"
JT=./node_modules/.bin/jpegtran
OP=./node_modules/.bin/optipng

# node_modules may have been populated on Windows -> vendor binaries are broken on Linux.
if [ ! -x node_modules/jpegtran-bin/vendor/jpegtran ] || [ ! -x node_modules/optipng-bin/vendor/optipng ]; then
  echo "[optimize-images] rebuilding imagemin binaries for this platform..."
  npm rebuild jpegtran-bin optipng-bin gifsicle mozjpeg pngquant-bin >/dev/null 2>&1 || true
fi

tb=0; ta=0; n=0
while IFS= read -r -d '' f; do
  mt=$(file -b --mime-type "$f")
  b=$(stat -c%s "$f"); a=$b; tmp="$f.__opt"
  case "$mt" in
    image/jpeg)
      if "$JT" -copy all -optimize -progressive -outfile "$tmp" "$f" 2>/dev/null && [ -s "$tmp" ]; then
        na=$(stat -c%s "$tmp"); if [ "$na" -lt "$b" ]; then mv "$tmp" "$f"; a=$na; else rm -f "$tmp"; fi
      else rm -f "$tmp"; echo "[optimize-images] WARN jpeg failed: $f" >&2; fi ;;
    image/png)
      cp "$f" "$tmp"
      if "$OP" -o2 -quiet "$tmp" 2>/dev/null; then
        na=$(stat -c%s "$tmp"); if [ "$na" -lt "$b" ]; then mv "$tmp" "$f"; a=$na; else rm -f "$tmp"; fi
      else rm -f "$tmp"; echo "[optimize-images] WARN png failed: $f" >&2; fi ;;
    *) ;; # leave other types untouched
  esac
  tb=$((tb+b)); ta=$((ta+a)); n=$((n+1))
done < <(find "$DIR" -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' \) -print0)

printf '[optimize-images] %s: %d files, %d -> %d bytes (saved %d)\n' "$DIR" "$n" "$tb" "$ta" "$((tb-ta))"
