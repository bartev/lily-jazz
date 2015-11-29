\version "2.19.31"

mychords = \chordmode { c4:min f:min7 }
\chords {
  \mychords
  \set minorChordModifier = \markup { "-" }
  \break
  \mychords
}
