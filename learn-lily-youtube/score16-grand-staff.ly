\version "2.20.0"

\header {
  title = "happy friday"
  composer = "composer"
}

% Piano setup
upper = \relative c'' {
  \clef treble
  \key c \major
  \numericTimeSignature \time 4/4

  f4 g( a b) |
  g4 g e e |
}

lower = \relative c {
  \clef bass
  \key c \major
  \numericTimeSignature \time 4/4

  a2 c |
  <f, a b c> 1 |
}

% score block
\score {
  \new PianoStaff <<
    \new Staff \upper
    \new Staff \lower
  >>
}