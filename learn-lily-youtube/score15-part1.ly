\version "2.20.0"

% this is part for PlayerOne

\include "score15-definitions.ly"

\header {
  title = "no clever title here"
  composer = "joe"
  subtitle = "for 2 instruments"
}

\score {
\new Staff \with {instrumentName = "Part One" } \playerone
}