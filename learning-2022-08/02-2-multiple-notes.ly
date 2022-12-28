\version "2.24.0"

<<
  \new Staff { \clef "treble" c''4 }
  \new Staff { \clef "bass" c4 }
>>

  
<<
  \new Staff { \clef "treble" c''4 }
  \new Staff { \clef "treble" d''4 }
  \new Staff { \clef "bass" c4 }
>>

  %% Score, Staff, Voice: melodic notation
  %% Lyrics: lyrics text
  %% ChordNames: print chord names

 %% Note: when using `PianoStaff`, the bar lines extend between staves
<<
  \new Staff \relative { \time 2/4 c''4 e | g g, | }
  \new Staff \relative { \clef "bass" c4 c' | e c | }
>>

  
\new PianoStaff <<
  \new Staff \relative { \time 2/4 c''4 e | g g, | }
  \new Staff \relative { \clef "bass" c4 c' | e c | }
>>

\new GrandStaff <<
  \new Staff \relative { \time 2/4 c''4 e | g g, | }
  \new Staff \relative { \clef "bass" c4 c' | e c | }
>>

\new ChoirStaff <<
  \new Staff \relative { \time 2/4 c''4 e | g g, | }
  \new Staff \relative { \clef "bass" c4 c' | e c | }
>>
