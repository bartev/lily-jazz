#!/usr/bin/env bash
set -euo pipefail

# Clear the symlinks from the bv-lilyjazz->Lilypond directory

LILY_APP_DIR=$(brew --prefix lilypond)
LILY_INSTALL_DIR=$(ls -d "$LILY_APP_DIR/share/lilypond/"* | sort -V | tail -n 1)
STYLE_DIR="plugins/bv-lilyjazz/stylesheets"

for file in "$STYLE_DIR"/*.ily; do
  target="$LILY_INSTALL_DIR/ly/$(basename "$file")"
  [[ -L "$target" ]] && rm "$target" && echo "❌ Removed symlink: $target"
done

echo "✅ Symlinks cleaned."
