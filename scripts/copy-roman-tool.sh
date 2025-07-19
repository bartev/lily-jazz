#!/usr/bin/env bash
set -euo pipefail

# Copy the roman number analysist tool to Lilypond
LILY_APP_DIR=$(brew --prefix lilypond)
LILY_INSTALL_DIR=$(ls -d "$LILY_APP_DIR/share/lilypond/"* | sort -V | tail -n 1)

TOOL_DIR="plugins/lilypond-roman-numeral-tool"
cp "$TOOL_DIR"/roman_numeral_analysis_tool.ily "$LILY_INSTALL_DIR/ly/"

echo "✅ Roman numeral analysis tool copied to: $LILY_INSTALL_DIR/ly/"
