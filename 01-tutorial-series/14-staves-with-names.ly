\version "2.22.2"
\language "english"

% Can also include info in the score block.
\relative c' {
  <<
  \new Staff \with { instrumentName = "Sop" }
  { \clef "treble" \time 5/4 d2. e4 fs }
 \new Staff \with { instrumentName = "Alto" }
 { \clef "treble" \time 5/4 a2.( b4 cs) }
 \new Staff \with { instrumentName = "Cello" }
  { \clef "bass" \time 5/4 c,,,2.( d4 e) }
  >>
}