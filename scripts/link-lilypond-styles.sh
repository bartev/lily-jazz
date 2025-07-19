#!/usr/bin/env bash

# Create symlinks of stylesheets to the Lilypond homebrew install location

set -euo pipefail

# === Config ===
# Directory is relative to the project root
STYLESHEET_DIR="plugins/bv-lilyjazz/stylesheets"

# === Locate LilyPond from Homebrew ===
echo "🔍 Locating LilyPond installation via Homebrew..."
LILY_APP_DIR=$(brew --prefix lilypond)

# Get the latest installed version directory (e.g., 2.24.4)
LILY_INSTALL_DIR=$(
  ls -d "$LILY_APP_DIR/share/lilypond/"* 2>/dev/null |
  sort -V | tail -n 1
)

if [[ -z "$LILY_INSTALL_DIR" || ! -d "$LILY_INSTALL_DIR/ly" ]]; then
  echo "❌ Error: Could not locate LilyPond 'ly/' directory under $LILY_APP_DIR/share/lilypond/"
  exit 1
fi

echo "✅ Found LilyPond install: $LILY_INSTALL_DIR"

# === Symlink .ily files ===
echo "🔗 Linking stylesheets from: $STYLESHEET_DIR → $LILY_INSTALL_DIR/ly/"

for file in "$STYLESHEET_DIR"/*.ily; do
  [[ -e "$file" ]] || { echo "⚠️ No .ily files found in $STYLESHEET_DIR"; exit 1; }
  abs_file="$(realpath "$file")"
  ln -sf "$abs_file" "$LILY_INSTALL_DIR/ly/"
  echo "  → Linked $(basename "$file")"
done

echo "✅ Done. Your local .ily files are now linked into LilyPond."
