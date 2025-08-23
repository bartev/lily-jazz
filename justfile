_list:
    just --list

# Create symlinks of stylesheets to the Lilypond homebrew install location
[group: "setup"]
link-styles:
    ./scripts/link-lilypond-styles.sh

# Clear the symlinks from the bv-lilyjazz->Lilypond directory
[group: "setup"]
clean-links:
    ./scripts/clean-lilypond-links.sh

# Copy lilyjazz fonts to Lilypond
[group: "setup"]
copy-fonts:
    ./scripts/copy-lilypond-fonts.sh

# Copy the roman number analysist tool to Lilypond
[group: "setup"]
copy-roman-tool:
    ./scripts/copy-roman-tool.sh

# Setup everything
[group: "setup"]
setup-all: link-styles clean-links copy-fonts copy-roman-tool

# show available fonts
show-fonts:
    lilypond -dshow-available-fonts

alias all := setup-all
alias ls := link-styles
