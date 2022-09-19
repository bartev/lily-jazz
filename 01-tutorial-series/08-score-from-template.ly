\version "2.22.2"

\header {
  title = "This is awesome"
  composer = "Bartev"
}

global = {
  \key c \major
  \numericTimeSignature
  \time 5/4
  \tempo "Insane"
}

sopranoSax = \relative c'' {
  \global
  \transposition bes
  % Music follows here.
  c4 d e f
}

altoSax = \relative c'' {
  \global
  \transposition es
  % Music follows here.
  c4 d e f
}

sopranoSaxPart = \new Staff \with {
  instrumentName = "Soprano Sax"
  midiInstrument = "soprano sax"
} \sopranoSax

altoSaxPart = \new Staff \with {
  instrumentName = "Alto Sax"
  midiInstrument = "alto sax"
} \altoSax

\score {
  <<
    \sopranoSaxPart
    \altoSaxPart
  >>
  \layout { }
  \midi {
    \tempo 4=100
  }
}
