\version "2.22.2"

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
      s^\markup
      \fill-line {
        %% meter
        \fontsize #2 \lower #2 \rotate #7 \concat { \note { 4 } #1  " = " #meter }
        %% title
        \fontsize #5
        \override #'(offset . 7) \override #'(thickness . 6)
        \underline \larger #title
        %% composer
        \fontsize #2 \lower #1 \concat { #composer " " }
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

eternal_triangle = \relative c' {
  %% A
  %% m1
  \markManualBox "1"
  \timestop "0:38"
  r1
  r4. d8 g b d4~
  d2 b8 d c g
  b8 g a bes fis ees d c
  \break

  %% m5
  \timestop "0:41"
  b8 d e f a4 fis8 d
  g8 f \tuplet 3/2 {e8 g b} d c g c
  b8 g d b \glissando fis'4. g8~
  g2. r4
  \bar "||"
  \break

  %% A
  %% m9
  \timestop "0:45"
  r4 << g8 g,8 >> d' g \xNote g d' g~
  g8 g cis,4~ cis2
  e8 cis d b g e c'4~
  c4 b8 g bes fis r4
  \break

  %% m13
  \timestop "0:48"
  r2 r8 e8 g16 a b c
  e4. b8 d b \tuplet 3/2 {c d c}
  a8 bes g ees d c b a'
  fis8 g b d fis e r4
  \bar "||"
  \break

  %% B
  %% m17
  \timestop "0:52"
  r1
  r2 fis8 dis b gis
  e'8 f d bes g bes d f~
  \tuplet 3/2 { f8 e d } e4 r2
  \break

  %% m21
  \timestop "0:55"
  r4 cis8 a fis dis'~ dis4~
  dis8 c aes fis d'4 d8 b
  g8 e cis'8  b a aes g4
  cis8 ais fis dis bis'4. r8
  \bar "||"
  \break

  %% A
  %% m25
  \timestop "0:59"
  r2 r4 e,16 g b d
  fis8 e d b c c b a
  g8 \parenthesize d g b gis e r4
  \grace b'8 c2 a8 fis g a
  \break

  %% m29
  \timestop "1:02"
  c8 e d4 r2
  r2 r4 r8 d8
  g8 d fis e d b \tuplet 3/2 { c d c }
  ais8 b g d bes b d \xNote b
  \bar "||"
  \break

  %% m33
  \markManualBox "2"
  \timestop "1:05"
  g'4 r4 \acciaccatura ais8 b4 g
  c4 g8 cis~ cis g d'4~
  d2 b4 d8 des
  c8 b a g fis ees d c
  \break

  %% m37
  \timestop "1:08"
  b8 d fis a f fis g f
  e8 g a b d4 r4
  r1
  r4 r8 d8 g d fis a
  \bar "||"
  \break

  %% m41
  \timestop "1:12"
  g8 d b c d4-. g-.
  d4 a'8 fis~ fis e d4
  g4-. g->~ g4. d8
  fis8 e d b \tuplet 3/2 { c d c } b8 a
  \break

  %% m45
  \timestop "1:15"
  g4 fis'8 dis b gis eis'4
  a,8 ais d cis r2
  r2 cis8 d g cis,!
  \tuplet 3/2 { c!8 cis c } bes8 g c? b \xNote g4
  \bar "||"
  \break

  %% m49
  \timestop "1:19"
  r1
  \tuplet 3/2 { ais'8 b ais } gis8 fis eis dis cis4
  \tuplet 3/2 { a'8 bes a } g8 f e d c b?
  bes8 d a g c a bes c
  \break

  %% m53
  \timestop "1:22"
  cis8 a fis cis gis' eis fis gis
  g?8 e f g aes bes c d
  dis8 cis d b g e cis'? ais
  fis8 dis c' a? ais fis dis? cis
  \bar "||"
  \break

  %% m57
  \timestop "1:25"
  d?8 c b a' fis g b d
  fis8 e d b \tuplet 3/2 { c8 d c } b8 a
  g8 d e fis g a b c
  d8 cis e cis d b g e
  \break

  %% m61
  \timestop "1:28 ?"
  c'8 b g e f4 e'8 d
  c8 fis, g a bes g e ees
  d8 c' a ais b4 r4
  r4. d8~ d4. a8
  \bar "||"
  \break

  %% m65
  \markManualBox "3"
  \timestop "1:32 ?"
  cis8 d \tuplet 3/2 { cis d cis } d8 b g e
  c'8 g cis4~ cis e8 cis
  d4 r4 r2
  r4 f4~ f d
  \break

  %% m69
  \timestop "1:35 ?"
  r8 f4 r8 r2
  r2 ees4 b'8 a
  g8 ees d c b a g e?
  a8 g a bes fis ees d c
  \bar "||"
  \break

  %% m73
  \timestop "1:38 ?"
  b4 r4 r2
  r2 r4 r8 d'~
  d8 g4 d8 g4-. d-.
  fis4-. e-. c e8 ees
  \break

  %% m77
  \timestop "1:41 ?"
  d8 b g e f4 r4
  r2 r4 r8 d'8
  g8 d fis e d b \tuplet 3/2 { c d c }
  b4. d8 a4 r4
  \bar "||"
  \break

  %% m81
  \timestop "1:45 ?"
  r2 ais'4 gis8 fis
  eis8 dis cis c b4 a'4
  g2 d8 f e c
  d4. bes8 g e c' cis~
  \break

  %% m85
  \timestop "1:48 ?"
  cis4 a gis fis
  c'4. aes8 g4 f
  b4 g fis e8 ais~
  ais4. fis8 eis4 dis
  \bar "||"
  \break

  %% m89
  \timestop "1:51 ?"
  r2 \tuplet 3/2 { r8 d e } fis8 a
  fis8 g b d fis e d b
  \tuplet 3/2 { c8 d c } b8 a gis f e d
  cis8 e g e b' bes fis d
  \break

  %% m93
  \timestop "1:54 ?"
  a'8 aes g e g \xNote f \tuplet 3/2 { e8 g b }
  d8 c g e ais cis~ cis4
  r1
  r2 \tuplet 3/2 { e8 f e } d8 e
  \bar "||"
  \break

  %% m97
  \markManualBox "4"
  \timestop "1:57 ?"
  f8 d r4 r2
  f8 d4 f d d8
  f4 d8 d f d r f~
  f8 d4-. f-. d-. d8
  \break

  %% m101
  \timestop "2:00 ?"
  f4 d8 d f d r c~
  c8 g4-. g-> c-. cis8~
  cis8 e4-. cis-. d-. b8~
  b8 g4-. c-. b -. f8
  \bar "||"
  \break

  %% m105
  \timestop "2:04 ?"
  r8 a r fis r g r b
  r8 d r fis~ fis2~
  fis2 r4 r8 e
  d8 b \tuplet 3/2 { c8 d c } bes8 fis ees cis
  \break

  %% m109
  \timestop "2:07 ?"
  d4 r fis'8 dis b gis
  f'4-^ bes,8 g ees c a'4
  r2 fis8 g b d
  fis8 e d b c b~ b4
  \bar "||"
  \break

  %% m113
  \timestop "2:10 ?"
  r4 r8 dis,8~ dis4 fis8 dis
  eis8 gis b dis ais4 r
  r8 fis g16 bes d f a2
  g8 f e d c b bes d
  \break

  %% m117
  \timestop "2:14 ?"
  cis8 a fis cis gis' e \xNote eis fis
  f8 g aes bes c ees d c
  d8 b g e cis'4 e8 f
  gis g fis eis dis cis c a?
  \bar "||"
  \break

  %% m121
  \timestop "2:17 ?"
  r2 fis8 g b d
  fis8 e d b \tuplet 3/2 { c8 d c } b8 a
  g4 r g'4. d8
  fis8 e d b c d \grace ais8 b4
  \break

  %% m125
  \timestop "2:20 ?"
  g4 f8 g a c e d
  c8 fis, g a bes g e ees
  d4 g'4( d b-.)
  e4. c8 a4 fis
  \bar "||"
  \break

  %% m129
  \markManualBox "5"
  \timestop "2:24 ?"
  g2 d'
  c2 e4 r
  r4 d g r8 a
  fis4 d r2
  \break

  %% m133
  \timestop "2:27 ?"
  ais'4 gis8 fis eis dis cis4
  f4 r8 ees d4. c8
  b4 r r2
  f'8 e d b \tuplet 3/2 { c8 d c } b8 a
  \bar "||"
  \break

  %% m137
  \timestop "2:30 ?"
  g8 d b c d g r4
  r2 r8 fis \tuplet 3/2 { g8 b d }
  fis8 d4 f8~ \tuplet 3/2 { f8 e dis } e4 ~
  e4 c8 a d b g e
  \break

  %% m141
  \timestop "2:34 ?"
  c'8 b g e g f \tuplet 3/2 { e8 g b }
  d8 c g e ees cis d c
  b8 a' r4 r2
  r2 fis'8 e d b
  \bar "||"
  \break

  %% m145
  \timestop "2:37 ?"
  \tuplet 3/2 { dis8 e dis } b8 ais gis d dis g~
  g4. dis8 fis dis eis gis
  b8 cis d bes g d f d
  e8 a r4 r2
  \break

  %% m149
  \timestop "2:40 ?"
  a4 gis' \tuplet 3/2 { fis8 e dis } r8 g~
  g4~ \tuplet 3/2 { g8 f ees } d4 r
  fis4~ \tuplet 3/2 { fis8 e d } cis8 d e eis~
  eis4~ \tuplet 3/2 { eis8 dis cis } c4 r
  \bar "||"
  \break

  %% m153
  \timestop "2:44 ?"
  r2 \tuplet 3/2 { fis,8 g b } \tuplet 3/2 { d8 fis a }
  fis2. a8 fis~
  fis4 a8 fis~ fis4 g8 e~
  e4 fis8 d~ d4 e8 b~
  \break

  %% m157
  \timestop "2:47 ?"
  b4 d8 b c4 r
  r2 r4 dis8 \xNote g
  b8 a g ees d des c b
  a8 aes g e fis ees d c
  \bar "||"
  \break

  %% m161
  \markManualBox "5"
  \timestop "2:50 ?"
  b4( d-.) g-. g~
  g4->~ g g g->~
  g4 g4~ g4->~ g4
  r1
  \break

  %% m165
  \timestop "2:50 ?"
  \repeat unfold 4 r1
  \break

}

scaleDegrees = \lyrics {
  %% m1
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

  %% m5
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

  %% m9
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

  %% m13
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

  %m17
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
  \markup \scaleDegree { 3 }4
  ""2

  %% m21
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
    \new ChordNames {
      \repeat unfold 5 { \eternal_triangle_chord_names }
      \chordmode {
        g2 e:7
        a2:min d:7
        b2:min e:7
        a2:min d:7
      }
    }
    \new Staff {
      \global
      \eternal_triangle
    }
    \scaleDegrees
  >>
}