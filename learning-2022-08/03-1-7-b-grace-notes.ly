\version "2.20.0"

\relative {
  c''2 \grace { a32 b } c2 |
  c2 \appoggiatura b16 c2 |
  c2 \acciaccatura b16 c2 |
}


%% https://lilypond.org/doc/v2.23/Documentation/notation/special-rhythmic-concerns#grace-notes

\relative {
  \acciaccatura d''8 c4
  \appoggiatura e8 d4
  \acciaccatura { g16 f } e2
  \slashedGrace a,8 g4
  \slashedGrace b16 a4(
  \slashedGrace b8 a2)
}

\relative { c''1 \afterGrace d1 { c16[ d] } c1 }
<<
  \new Staff \relative {
    c''1 \afterGrace d1 { c16[ d] } c1
  }
  \new Staff \relative {
    c''1 \afterGrace 15/16 d1 { c16[ d] } c1
  }
  \new Staff \relative {
    c''1 \afterGrace 1/2 d1 { c16[ d] } c1
  }
>>
