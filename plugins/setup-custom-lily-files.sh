#!/usr/bin/env bash

# Copy relevant files to correct location

LILY_INSTALL_DIR=/usr/local/Cellar/lilypond/2.22.2_1/share/lilypond/2.22.2
# LILY_INSTALL_DIR=/Users/bartev/dev/throwaway/lily-test-install

# Roman numeral analysis
cp lilypond-roman-numeral-tool/roman_numeral_analysis_tool.ily $LILY_INSTALL_DIR/ly/

# Lilyjazz
cp bv-lilyjazz/stylesheets/*.ily $LILY_INSTALL_DIR/ly/

# Fonts
LILY_FONT_DIR=$LILY_INSTALL_DIR/fonts
cp lilyjazz/otf/*.otf $LILY_FONT_DIR/otf/
cp lilyjazz/supplementary-files/lilyjazz-text/*.otf $LILY_FONT_DIR/otf/
cp lilyjazz/supplementary-files/lilyjazz-chord/*.otf $LILY_FONT_DIR/otf/

cp lilyjazz/svg/*.svg $LILY_FONT_DIR/svg/
