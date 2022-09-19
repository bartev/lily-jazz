\version "2.22.2"

% this is my first score

\header {
  title = "My Score"
  composer = "Composer"
  subtitle = "for solo viola"
}

\language "english"

\relative c'
{
  cs4\pp-3 d8\<([ ef f) g->-.] a4
  f8\!\startTrillSpan g\stopTrillSpan a e a4 d f
  \time 3/2
  e2\ff b\pp f
  \clef alto
  \numericTimeSignature \time 4/4
  c1
}
