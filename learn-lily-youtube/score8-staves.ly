\version "2.20.0"

\relative c'
{
  \new Staff \with { instrumentName = "Oboe" }
  { \clef "treble" \time 5/4 c2.(d4 e) }
}

\relative c'
{
<<
  \new Staff \with { instrumentName = "Oboe" }
  { \clef "treble" \time 5/4 c2.(d4 e) }
  \new Staff \with { instrumentName = "Viola" }
  { \clef "alto" \time 5/4 c2.(d4 e) }
  \new Staff \with { instrumentName = "Cello" }
  { \clef "bass" \time 5/4 c2.(d4 e) }
>>
}