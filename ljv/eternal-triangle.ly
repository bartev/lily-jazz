\version "2.20.0"

#(set-global-staff-size 20)
\include "jazzchords.ily"
\include "lilyjazz.ily"
\include "jazzextras.ily"
\include "roman_numeral_analysis_tool.ily"
\include "bv_definitions.ily"

title = "The Eternal Triangle"
% composer = "E-flat transcription"
composer = \markup \with-color #blue "Alto Sax"
arranger = ""
tagline = ""
meter = "240"
copyright = "Sonny Rollins solo - Transcribed by Jazz Music Lab"

realBookTitle = \markup {
  \score {
    {
      \override TextScript.extra-offset = #'(0 . -4.5)
      s4
      s^\markup{
        \fill-line {
          \fontsize #1 \lower #2 \rotate #7 \concat {\note #"4" #1 " = " #meter }
          \fontsize #5
          \override #'(offset . 7)
          \override #'(thickness . 6)
          \underline \larger #title
          \fontsize #1 \lower #1 \concat { #composer " " }
        }
      }
      s
    }
    \layout {
      \omit Staff.Clef
      \omit Staff.TimeSignature
      \omit Staff.KeySignature
      ragged-right = ##f
      ragged-bottom = ##f
      last-ragged-bottom = ##t
    }
  }
}

\header {
  title = \realBookTitle
  tagline = ##f
  copyright = \copyright
  %% The following fields are evenly spread on one line
  %% the field "instrument" also appears on following pages
  %% instrument = \markup \with-color #blue "Alto Sax"
}

\paper {
  #(set-paper-size "letter")
  #(define fonts
    (set-global-fonts
     #:music "lilyjazz"
     #:brace "lilyjazz"
     #:roman "lilyjazz-text"
     #:sans "lilyjazz-chord"
     #:factor (/ staff-height pt 18)
   ))

  top-margin = 0.5\in
  bottom-margin = 0.5\in
  left-margin = 0.5\in
  right-margin = 0.5\in
  indent = 0\mm

  %% between-system-space = 2.\cm
  %% between-system-padding = #0

  %%set to ##t if your score is less than one page:
  ragged-last-bottom = ##t
  ragged-bottom = ##t

  %% markup-system-spacing = #'((basic-distance . 23)
%%                            (minimum-distance . 8)
%%                            (padding . 1))
  oddHeaderMarkup = \markup
  \fill-line {
    \title
    %% \fromproperty #'header:title " "
    \on-the-fly #print-page-number-check-first
    \fromproperty #'page:page-number-string
  }
  evenHeaderMarkup = \markup
  \fill-line {
    \on-the-fly #print-page-number-check-first
    \fromproperty #'page:page-number-string " "
    %% \fromproperty #'header:title
    \title
  }
}

\layout {
  \context {
    \Lyrics \override LyricText.font-name = #"serif"
  }
  \numericTimeSignature
}

global = {
  \numericTimeSignature
  %% http://lilypond.org/doc/v2.18/Documentation/notation/displaying-rhythms#time-signature
  \key g \major
  %% %% beam across 4 eighth notes
  %% \time #'(4) 2/4

  %% make only the first clef visible
  \override Score.Clef #'break-visibility = #'#(#f #f #f)

  %% make only the first time signature visible
  \override Score.KeySignature #'break-visibility = #'#(#f #f #f)

  %% allow single-staff system bars
  \override Score.SystemStartBar #'collapse-height = #1

  \set Score.markFormatter = #format-mark-box-alphabet

  \override Score.RehearsalMark.self-alignment-X = #LEFT
}

eternal_triangle_chord_names = \chordmode {
  %% A
  g2 e:7
  a2:min d:7
  b2:min e:7
  a2:min d:7

  d2:min g:7
  c2 f:7
  b2:min e:7
  a2:min d:7

  %% A (modified)
  g2 e:7
  a2:min d:7
  b2:min e:7
  a2:min d:7

  d2:min g:7
  c2 f:7
  a2:min d:7
  g1

  %% B
  gis1:min
  cis1:7
  g1:min
  c1:7

  fis2:min b:7
  f2:min bes:7
  e2:min a:7
  dis2:min gis:7

  %% A (modified again)
  g2 e:7
  a2:min d:7
  b2:min e:7
  a2:min d:7

  d2:min g:7
  c2 f:7
  a2:min d:7
  g2 d:7

}

empty_bars = {
  \repeat unfold 4 {
    \repeat unfold 4 { s1 } \break
    \repeat unfold 4 { s1 } \bar "||" \break
  }
}

eternal_triangle = \relative c' {
  %% A
  \markManualBox "1"
  \timestop "0:38"
  r1
  r4. d8 g b d4~
  d2 b8 d c g
  b8 g a bes fis ees d c
  \break

  \timestop "0:41"
  b8 d e f a4 fis8 d
  g8 f \tuplet 3/2 {e8 g b} d c g c
  b8 g d b \glissando fis'4. g8~
  g2. r4
  \bar "||"
  \break

  %% A
  \timestop "0:45"
  r4 << g8 g,8 >> d' g \xNote g d' g~
  g8 g cis,4~ cis2
  e8 cis d b g e c'4~
  c4 b8 g bes fis r4
  \break

  \timestop "0:48"
  r2 r8 e8 g16 a b c
  e4. b8 d b \tuplet 3/2 {c d c}
  a8 bes g ees d c b a'
  fis8 g b d fis e r4
  \bar "||"
  \break

  %% B
  \timestop "0:52"
  r1
  r2 fis8 dis b gis
  e'8 f d bes g bes d f~
  \tuplet 3/2 { f8 e d } d4 r2
  \break

  \timestop "0:55"
  r4 cis8 a fis dis'~ dis4~
  dis8 c aes fis d'4 d8 b
  g8 e cis'8  b a aes g4
  cis8 ais fis dis bis'4. r8
  \bar "||"
  \break

  %% A
  \timestop "0:59"
  r2 r4 e,16 g b d
  fis8 e d b c c b a
  g8 \parenthesize d g b gis e r4
  \grace b'8 c2 a8 fis g a
  \break

  \timestop "1:02"
  c8 e d4 r2
  r2 r4 r8 d8
  g8 d fis e d b \tuplet 3/2 { c d c }
  ais8 b g d bes b d \xNote b
  \bar "||"
  \break

  \markManualBox "2"
  \timestop "1:02"
  g'4 r4 \acciaccatura ais8 b4 g
  c4 g8 cis~ cis g d'4~
  d2 b4 d8 des
  c8 b a g fis ees d c
  \break

  \timestop "1:02"
  b8 d fis a f fis g f
  e8 g a b d4 r4
  r1
  r4 r8 d8 g d fis a
  \bar "||"
  \break

  \timestop "1:02"
  g8 d b c d4-. g-.
  d4 a'8 fis~ fis e d4
  g4-. g->~ g4. d8
  fis8 e d b \tuplet 3/2 { c d c } b8 a
  \break

  \timestop "1:02"
  g4 fis'8 dis b gis eis'4
  a,8 ais d cis r2
  r2 cis8 d g cis,
  \tuplet 3/2 { c8 cis c } bes8 g c b \xNote g4
  \bar "||"
  \break

  \timestop "1:02"
  r1
  \tuplet 3/2 { ais'8 b ais } gis8 fis eis dis cis4
  \tuplet 3/2 { a'8 bes a } g8 f e d c b
  bes8 d a g c a bes c
  \break

  \timestop "1:02"
  cis8 a fis cis gis' eis fis gis
  g8 e f g aes bes c d
  dis8 cis d b g e cis' ais
  fis8 dis c' a ais fis dis? cis
  \bar "||"
  \break

  \timestop "1:02"
  d8 c b a' fis g b d
  fis8 e d b \tuplet 3/2 { c8 d c } b8 a
  g8 d e fis g a b c
  d8 cis e cis d b g e
  \break

  \timestop "1:02"
  c'8 b g e f4 e'8 d
  c8 fis, g a bes g e ees
  d8 c' a ais b4 r4
  r4. d8~ d4. a8
  \bar "||"
  \break


  \markManualBox "3"
  \timestop "1:02"
  cis8 d \tuplet 3/2 { cis d cis } d8 b g e
  c'8 g cis4~ cis e8 cis
  d4 r4 r2
  r4 f4~ f d
  \break

  \timestop "1:02"
  \repeat unfold 4 { s1 }
  \bar "||"
  \break

  \timestop "1:02"
  \repeat unfold 4 { s1 }
  \break

  \timestop "1:02"
  \repeat unfold 4 { s1 }
  \bar "||"
  \break

  \timestop "1:02"
  \repeat unfold 4 { s1 }
  \break

  \timestop "1:02"
  \repeat unfold 4 { s1 }
  \bar "||"
  \break

  \timestop "1:02"
  \repeat unfold 4 { s1 }
  \break

  \timestop "1:02"
  \repeat unfold 4 { s1 }
  \bar "||"
  \break
}

scaleDegrees = \lyrics {
  ""1
  ""4.
  \markup \scaleDegree { 4 }8
  \markup \scaleDegree { 4 }
  \markup \scaleDegree { 6 }
  \markup \scaleDegree { 1 }4

  \markup \scaleDegree { f3 }2
  \markup \scaleDegree { 5 }8
  \markup \scaleDegree { f7 }
  \markup \scaleDegree { 6 }
  \markup \scaleDegree { 3 }

  \markup \scaleDegree { 2 }8
  \markup \scaleDegree { f7 }
  \markup \scaleDegree { 1 }
  \markup \scaleDegree { f8 }
  \markup \scaleDegree { 3 }
  \markup \scaleDegree { f9 }
  \markup \scaleDegree { 1 }
  \markup \scaleDegree { f7 }

  \markup \scaleDegree { 6 }8
  \markup \scaleDegree { 1 }
  \markup \scaleDegree { 2 }
  \markup \scaleDegree { f3 }
  \markup \scaleDegree { 2 }4
  \markup \scaleDegree { n7 }8
  \markup \scaleDegree { 5 }

  \markup \scaleDegree { 5 }8
  \markup \scaleDegree { 4 }
  \tuplet 3/2 { \markup \scaleDegree { 3 }8
                \markup \scaleDegree { 5 }
                \markup \scaleDegree { 7 } }
  \markup \scaleDegree { 6 }8
  \markup \scaleDegree { 5 }
  \markup \scaleDegree { 2 }
  \markup \scaleDegree { 5 }

  \markup \scaleDegree { 1 }8
  \markup \scaleDegree { 6 }
  \markup \scaleDegree { f3 }
  \markup \scaleDegree { 1 }
  \markup \scaleDegree { 2 }4.
  \markup \scaleDegree { f3 }8

  \markup \scaleDegree { f7 }2.
  ""4

  ""4
  \markup \scaleDegree { 1 }8
  \markup \scaleDegree { 5 }
  \markup \scaleDegree { f3 }4
  \markup \scaleDegree { f7 }8
  \markup \scaleDegree { f3 }

  \markup \scaleDegree { f7 }8
  \markup \scaleDegree { f7 }
  \markup \scaleDegree { n3 }4
  \markup \scaleDegree { n7 }2

  \markup \scaleDegree { 4 }8
  \markup \scaleDegree { 2 }
  \markup \scaleDegree { 3 }
  \markup \scaleDegree { 1 }
  \markup \scaleDegree { 6 }
  \markup \scaleDegree { 4 }
  \markup \scaleDegree { f6 }4

  \markup \scaleDegree { f3 }4
  \markup \scaleDegree { 2 }8
  \markup \scaleDegree { f7 }
  \markup \scaleDegree { f6 }
  \markup \scaleDegree { 3 }
  ""4

  ""2 ""8
  \markup \scaleDegree { 6 }8
  \markup \scaleDegree { 1 }16
  \markup \scaleDegree { 2 }
  \markup \scaleDegree { 3 }
  \markup \scaleDegree { 4 }

  \markup \scaleDegree { 3 }4.
  \markup \scaleDegree { 7 }8
  \markup \scaleDegree { 6 }
  \markup \scaleDegree { 4 }
  \tuplet 3/2 { \markup \scaleDegree { 5 }8
                \markup \scaleDegree { 6 }
                \markup \scaleDegree { 5 } }
  \markup \scaleDegree { 1 }8
  \markup \scaleDegree { f2 }
  \markup \scaleDegree { f7 }
  \markup \scaleDegree { f6 }
  \markup \scaleDegree { 1 }
  \markup \scaleDegree { f7 }
  \markup \scaleDegree { 6 }
  \markup \scaleDegree { 5 }

  \markup \scaleDegree { 7 }8
  \markup \scaleDegree { 1 }
  \markup \scaleDegree { 3 }
  \markup \scaleDegree { 5 }
  \markup \scaleDegree { 7 }
  \markup \scaleDegree { 6 }
  ""4

  ""1

  ""2
  \markup \scaleDegree { 4 }8
  \markup \scaleDegree { 2 }
  \markup \scaleDegree { f7 }
  \markup \scaleDegree { 5 }

  \markup \scaleDegree { 6 }8
  \markup \scaleDegree { f7 }
  \markup \scaleDegree { 5 }
  \markup \scaleDegree { f3 }
  \markup \scaleDegree { 1 }
  \markup \scaleDegree { f3 }
  \markup \scaleDegree { 5 }
  \markup \scaleDegree { f7 }

  \tuplet 3/2 { \markup \scaleDegree { 4 }8
                \markup \scaleDegree { 3 }
                \markup \scaleDegree { 2 } }
  \markup \scaleDegree { 2 }4
  ""2

  ""4
  \markup \scaleDegree { 5 }8
  \markup \scaleDegree { f3 }
  \markup \scaleDegree { 5 }
  \markup \scaleDegree { 3 }4.

  \markup \scaleDegree { 6 }8
  \markup \scaleDegree { 5 }
  \markup \scaleDegree { f3 }
  \markup \scaleDegree { 1 }
  \markup \scaleDegree { 3 }4
  \markup \scaleDegree { 3 }8
  \markup \scaleDegree { s1 }

  \markup \scaleDegree { f3 }8
  \markup \scaleDegree { 1 }
  \markup \scaleDegree { 6 }
  \markup \scaleDegree { 5 }
  \markup \scaleDegree { 1 }
  \markup \scaleDegree { f1 }
  \markup \scaleDegree { f7 }4

  \markup \scaleDegree { f7 }8
  \markup \scaleDegree { 5 }
  \markup \scaleDegree { f3 }
  \markup \scaleDegree { 1 }
  \markup \scaleDegree { 3 }4.
  ""8

}

\score {
  <<
    \new ChordNames { \repeat unfold 3 { \eternal_triangle_chord_names } }
    \new Staff {
      \global
      \eternal_triangle
    }
    \scaleDegrees
  >>
}
