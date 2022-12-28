\version "2.24.0"

mychords = \chordmode { c4:min f:min7 }
\chords {
  \mychords
  \set minorChordModifier = \markup { "-" }
  \break
  \mychords
}
