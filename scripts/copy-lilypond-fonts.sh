#!/usr/bin/env bash
set -euo pipefail

LILY_APP_DIR=$(brew --prefix lilypond)
LILY_INSTALL_DIR=$(ls -d "$LILY_APP_DIR/share/lilypond/"* | sort -V | tail -n 1)
LILY_FONT_DIR="$LILY_INSTALL_DIR/fonts"

JAZZ_FONT_SRC="plugins/lilyjazz"

cp "$JAZZ_FONT_SRC"/otf/*.otf "$LILY_FONT_DIR/otf/"
cp "$JAZZ_FONT_SRC"/supplementary-files/lilyjazz-chord/*.otf "$LILY_FONT_DIR/otf/"
cp "$JAZZ_FONT_SRC"/supplementary-files/lilyjazz-text/*.otf "$LILY_FONT_DIR/otf/"
cp "$JAZZ_FONT_SRC"/svg/*.svg "$LILY_FONT_DIR/svg/"

echo "✅ Fonts copied to: $LILY_FONT_DIR"
