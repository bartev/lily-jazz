\version "2.20.0"

#(set-global-staff-size 20)
\include "jazzchords.ily"
\include "lilyjazz.ily"
\include "jazzextras.ily"
\include "roman_numeral_analysis_tool.ily"
\include "bv_definitions.ily"

title = "The Eternal Triangle"
composer = "E-flat transcription"
arranger = ""
tagline = ""
meter = "Fast"
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
  \markManualBox "1"
  \timestop "0:30"
  r1
  r4. d8 g b d4~
  d2 b8 d c g
  b8 g a bes fis ees d c
  \break

  \timestop "0:33"
  b8 d e f a4 fis8 d
  g8 f \tuplet 3/2 {e8 g b} d c g c
  b8 g d b \glissando fis'4. g8~
  g2. r4
  \bar "||"
  \break

  %% A
  \timestop "0:36"
  r4 g,8 d' g \xNote g d' g~
  g8 g cis,4~ cis2
  e8 cis d b g e c'4~
  c4 b8 g bes fis r4
  \break

  \timestop "0:36"
  r2 r8 e8 g16 a b c
  e4. b8 d b \tuplet 3/2 {c d c}
  a8 bes g ees d c b a'
  fis8 g b d fis e r4
  \bar "||"
  \break
  
  %% B
  \repeat unfold 4 { s1 } \break
  \repeat unfold 4 { s1 } \break
  %% A
  \repeat unfold 4 { s1 } \break
  \repeat unfold 4 { s1 } \break
}

\score {
  <<
    \new ChordNames { \repeat unfold 1 { \eternal_triangle_chord_names } }
    \new Staff {
      \global
      \eternal_triangle
    }
  >>
}
