# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a **LilyPond** music notation repository focused on **jazz transcriptions, lead sheets, and practice materials**. LilyPond is a text-based music engraving system that produces publication-quality sheet music from `.ly` source files.

### Primary Tools
- **LilyPond**: Music notation compiler (installed via Homebrew)
- **File types**: `.ly` (LilyPond source files), `.ily` (include files), `.pdf` (compiled output)

### Repository Structure
- `ljv/`: Main working directory for lead sheets and transcriptions (150+ files)
- `real-book-scores/`: Real Book style jazz standards
- `templates/`: Reusable templates for different ensemble types
- `plugins/`: Custom LilyPond extensions and fonts
  - `plugins/bv-lilyjazz/stylesheets/`: Custom functions and stylesheets
  - `plugins/lilyjazz/`: Jazz fonts (LilyJazz, LilyJazzText, LilyJazzChord)
  - `plugins/lilypond-roman-numeral-tool/`: Roman numeral harmonic analysis
  - `plugins/snippets/`: Reusable LilyPond code snippets
- `learning-2022-08/`, `demos/`, `scheme/`: Learning materials and examples
- `org-files/`, `org-doc-2025-01/`: Org-mode documentation

## Compiling LilyPond Files

### Basic Compilation
```bash
# Compile a single file to PDF
lilypond filename.ly

# Output is filename.pdf in the same directory
```

### Copy to iCloud (common workflow)
```bash
# Compile and copy to iCloud Documents folder
lilypond eternal-triangle.ly && cp eternal-triangle.pdf ~/Documents/ljv-pdfs/
```

**Note**: LilyPond may not be in PATH. Check installation with:
```bash
brew list --versions lilypond
readlink -f $(brew --prefix lilypond)
```

## Custom Plugins and Setup

### Installing Custom Files
After modifying custom stylesheets or fonts, install them to the LilyPond directory:

```bash
cd plugins
./setup-custom-lily-files.sh
```

This script copies:
- `bv-lilyjazz/stylesheets/*.ily` → LilyPond `ly/` directory
- `lilyjazz/otf/*.otf` → LilyPond fonts
- `lilypond-roman-numeral-tool/roman_numeral_analysis_tool.ily` → LilyPond `ly/` directory

### Custom Functions (bv_definitions.ily)

Located in `plugins/bv-lilyjazz/stylesheets/bv_definitions.ily`, provides:

- `\timestop "0:11"` - Add colored timestamp above staff
- `\markManualBox "A"` - Manual rehearsal mark in box
- `\markBlue "text"` - Blue markup text
- `\blueChord`, `\redChord`, `\greenChord` - Colored chord symbols
- `\marksans` - Sans-serif markup in blue
- `date` - Auto-generated date variable
- `bvTagline` - "Bartev - YYYY-MM-DD"

## Typical File Structure

LilyPond files in this repo follow these patterns:

### Standard Includes (at top of file)
```lilypond
\version "2.24.0"
\include "jazzchords.ily"
\include "lilyjazz.ily"
\include "jazzextras.ily"
\include "roman_numeral_analysis_tool.ily"
\include "bv_definitions.ily"
```

### Common Patterns
- **Staff size**: `#(set-global-staff-size 18)` - Adjust to fit content on pages
- **Global settings**: Key, time signature, rehearsal marks, bar visibility
- **Structure**: Separate variables for chords, melody, harmonic analysis, scale degrees
- **Real Book style headers**: Custom `realBookTitle` markup with title, composer, meter

### Template Files
- `templates/template-transcribe.ly` - Full-featured transcription template
- `templates/real-book-template.ly` - Real Book style lead sheet
- `templates/Lead sheet.ly` - Simple lead sheet
- `templates/Jazz combo, 2 horns.ly` etc. - Ensemble templates

## File Organization Best Practices

### When Creating New Files
1. Use descriptive kebab-case names: `song-name.ly`
2. Include version declaration: `\version "2.24.0"`
3. Set appropriate staff size for content
4. Use template files as starting points
5. Reference includes with relative or absolute paths

### Working with Includes
- Stylesheet includes use relative paths: `\include "../stylesheets/jazzchords.ily"`
- Custom functions from `bv_definitions.ily` are available after include
- Include order matters - load fonts/styles before using them

## LilyPond Language Specifics

### Syntax Overview
- **Comments**: `%` for single line, `%{ ... %}` for blocks
- **Variables**: `varName = { music }` or `varName = #"string"`
- **Scheme expressions**: `#(scheme code)` for calculations/scripting
- **Markup**: `\markup { ... }` for formatted text
- **Relative pitch**: `\relative c' { c d e f }` - most common entry mode
- **Chord mode**: `\chordmode { c:m7 f:7 bes }` for jazz chord symbols

### Key Constructs in This Repo
- `\global`: Shared settings (time, key, rehearsal marks, bar visibility)
- `\chordmode`: Jazz chord notation
- `\score { << ... >> }`: Combines staves, chord names, lyrics
- `\layout { ... }`: Page formatting and spacing
- `\paper { ... }`: Paper size, margins, headers/footers
- `\markup \rN { ... }`: Roman numeral analysis

## Common Development Tasks

### Creating a New Lead Sheet
1. Copy appropriate template from `templates/`
2. Update version, title, composer, meter, key, time signature
3. Define chord changes in `\chordmode`
4. Enter melody in `\relative` notation
5. Optionally add harmonic analysis with `\lyricmode` and `\markup \rN`
6. Compile with `lilypond filename.ly`

### Creating a Transcription
1. Start with `templates/template-transcribe.ly`
2. Set staff size (18-24 typical range)
3. Define head and solo sections separately
4. Use `\timestop` for timing marks
5. Use `\markBlue` or `\markManualBox` for phrase markers
6. Add scale degrees with `\lyrics` if desired

### Modifying Custom Functions
1. Edit files in `plugins/bv-lilyjazz/stylesheets/`
2. Run `plugins/setup-custom-lily-files.sh` to install
3. Test in a sample `.ly` file
4. No compilation step needed for `.ily` files themselves

## Important Notes

- **LilyPond version**: Target version is 2.24.0 (declared in most files)
- **Font system**: Uses custom LilyJazz fonts for authentic jazz appearance
- **Homebrew install path**: LilyPond installed via Homebrew, typically in `/opt/homebrew/Cellar/lilypond/`
- **PDF output**: Always accompanies `.ly` files (check git tracking if needed)
- **Scheme/Guile**: LilyPond uses Guile Scheme for scripting and custom functions
- **Roman numeral analysis**: Uses custom `roman_numeral_analysis_tool.ily` plugin

## Key Directories to Know

- **Working files**: `ljv/` (main active scores)
- **Templates**: `templates/` (copy, don't modify originals)
- **Custom code**: `plugins/bv-lilyjazz/stylesheets/`
- **Examples**: `learning-2022-08/`, `demos/`, `book-examples/`
- **Real Book scores**: `real-book-scores/`

## LilyPond Documentation

- Notation Reference: http://lilypond.org/doc/v2.18/Documentation/notation-big-page.html
- Application Usage: http://lilypond.org/doc/v2.18/Documentation/usage-big-page.html
- Learning Manual: http://lilypond.org/doc/v2.22/Documentation/learning/
