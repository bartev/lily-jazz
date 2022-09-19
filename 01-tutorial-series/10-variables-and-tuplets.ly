\version "2.22.2"

% this is my first score

\header {
  title = "My Score"
  composer = "Composer"
  subtitle = "for solo viola"
}

\language "english"

ives = { c4 g f f }

\relative c'
{
  cs4\pp-3 d8\<([ ef f) g->-.] a4
  f16\! g a e a4 d f
  \time 3/2
  e2\ff^"Intense" b f
  \clef alto
  \numericTimeSignature \time 4/4
  < c e>1
  \ives
  \tuplet 3/2 { f8 g f }
}
