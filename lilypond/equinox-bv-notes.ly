% Treble clef part

melody = \new Staff \relative c'' {
  \clef treble
  \numericTimeSignature
  \time 4/4
  \partial 8 g8 \bar ".|"
  es'4. c8~ c2~          | c2.~ c8 g8    | es'8 c8~ c2~ c8 g8 | \break
  c8 es r4 r4 r8 es8 | f4. c8~ c2~    | c2.. f8          | \break
  es4. c8~ c4. g8      | c8 es r4 r2 | r8 d8 r4 d4. c8  | \break
  d4. c8 es c es4    | c1~           | c2.. g8          |
  \bar "||"
}

bassline = \new Staff \relative c {
  \clef bass
  \numericTimeSignature
  \time 4/4
  \partial 8 r8 |
  c4. c8~c4 c~ | c2 g4 bes | c4. c8~ c4 c~ |
  c2 c4 es     | f4. f8~ f4 f4~ | f2 g,4 bes |
  c4. c8~ c4 c4~ | c1        | aes1       |
  g1             | c4. c8~ c4 c~ | c2 g4 bes | \bar "||"
}

chordmusic = \chordmode {
  \partial 8 r8 |
  c1:min7 | c1:min7 | c1:min7 |
  c1:min7 | f1:min7 | f1:min7 |
  c1:min7 | c1:min7 | aes1:7  |
  g1:7    | c1:min7 | c1:min7 |
}
