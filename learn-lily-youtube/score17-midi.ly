\version "2.18.2"

\language "english"

global = {
  \time 4/4
}

cello = \relative c {
  \global
  c'\pp\< e! g, ef \! | 
  c1\mf |
  d4 e f c | 
  <c d e f g> d e f |
}

\score {
  \new Staff \with {
    instrumentName = "Cello"
    midiInstrument = "cello"
  }
  { \clef bass \cello }
  \layout {}
  \midi {}
}