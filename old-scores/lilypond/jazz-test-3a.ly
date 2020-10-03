\version "2.20.0"

\paper {
  #(define fonts
    (set-global-fonts
    #:music "lilyjazz"
    #:brace "lilyjazz"
    #:roman "lilyjazz-text"
    #:sans "lilyjazz-chord"
      (/ staff-height pt 20)))
}

\paper { indent = #10 }

\layout {
  \override Staff.Slur.thickness = #3
}


\relative c' {
  \set Staff.instrumentName = "Trumpet"
  \clef treble
  \key es \major
  \time 4/4
  \tempo "Medium Swing"
   r8 es4->\mf f8-. g--  as4-^ bes8-^  |
   r4. b8\trill\fff ~ b2 |
   bes?16-> r as4\mp r8 g4( \times 2/3 { es8 f e\pp ~ } |
   e1) \fermata |
   \bar "||"
   \mark \markup \musicglyph "scripts.varsegno" 
   \clef bass
   \time 5/4
   \key g \major
   geses,4_"Various Accidentals" ges g gis gisis |
}


\score {
  \new StaffGroup <<
    \new Staff \relative c'' {
      \clef treble
      \numericTimeSignature
      \time 4/4
      r8 a \times 2/3 { r e' cis } a2 |
      r8 b \times 2/3 { r a' fis } d2 |
      r8 e \times 2/3 { r d' b } g2 |
      r4 \times 2/3 { r8 b d } \times 2/3 { a' fis d ~ } d4 |
      r4 \times 2/3 { r8 e, g } \times 2/3 { d' b c ~ } c4 |
      r4 r16 d, fis a c8 a bes bes, ~ |
      \times 2/3 { bes8 fis' a } fis g ~ g g, ~ \times 2/3 { g d' f } |
      d8 es ~ es16 es, g d' b?8 c4. | \bar "||"
    }
    \new Staff \relative c {
      \clef bass
      \numericTimeSignature
      \time 4/4
      <cis' d fis>1 |
      <b c e> |
      <g a c e> |
      r8 <fis g b> ~ q4 ~ q2 |
      r8 <b c e>4. <f a c e>2 |
      r8 <a bes d>4. ~ q <es g bes d>8 ~ |
      q1 |
      <g as c>1 | \bar "||"
    }
  >>

  \header { piece = 
	\markup { \roman \fontsize #3 
		"Beginning of a Bill Evans Solo Transcription — “Time Remembered”" } }
  \layout { indent = 0 }
  \midi { \tempo 4 = 140 }
}

%\markup { \override #'(font-name . "LilyJAZZ Text") "(Example taken from Frank Sikora’s “Neue Jazz-Harmonielehre”)" }
\markup { \sans "(Example taken from Frank Sikora’s “Neue Jazz-Harmonielehre”, p. 264)" }
