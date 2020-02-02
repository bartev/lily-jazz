\version "2.18.2"

% this is the full score

\include "score15-definitions.ly"

\header {
  title = "no clever title here"
  composer = "joe"
  subtitle = "for 2 instruments"
}

\score {
  <<
    \new Staff \playerone
    \new Staff \playertwo
  >>
}