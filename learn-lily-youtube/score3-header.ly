\version "2.18.2"

% this is my first score

% use s/f instead if is/es for sharp/flat
% \language "english"

\header {
  dedication = "dedication"
  title = "My Score"
  subtitle = "for solo viola"
  subsubtitle = "sub-subtitle"
  instrument = "alto sax"
  composer = "Composer"
  arranger = "arranger - bartev"
  poet = "poet - longfellow"
  meter = "meter"
  piece = "piece"
  opus = "opus"
  copyright = "copyright BJV"
  tagline = "tag, you're it!"
}

global = {
  \key c \major
  \numericTimeSignature
  \time 5/4
  \tempo "Insane"
}


oboe = \relative c'' {
  \global
  % music follows here
  c d e f
}

clarinet = \relative c'' {
  \global
  \transposition bes
  % music follows here
  c d e f
}

oboePart = \new Staff \with {
  instrumentName = "Oboe"
  midiInstrument = "oboe"
} \oboe

clarinetPart = \new Staff \with {
  instrumentName = "Clarinet"
  midiInstrument = "clarinet"
} \clarinet


\score {
  <<
  \oboePart
  \clarinetPart
  >>
}