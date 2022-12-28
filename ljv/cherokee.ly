\version "2.24.0"

#(set-global-staff-size 20)
\include "jazzchords.ily"
\include "lilyjazz.ily"
\include "jazzextras.ily"
\include "roman_numeral_analysis_tool.ily"
\include "bv_definitions.ily"

title = "Cherokee"
composer = "Ray Noble"
arranger = ""
tagline = ""
meter = "Fast"
copyright = ""

realBookTitle = \markup {
  \score {
    {
      \override TextScript.extra-offset = #'(0 . -4.5)
      s4
      s^\markup{
        \fill-line {
          \fontsize #1 \lower #2 \rotate #7 \concat {\note {4} #1 " = " #meter }
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
    \if \should-print-page-number
    \fromproperty #'page:page-number-string
  }
  evenHeaderMarkup = \markup
  \fill-line {
    \if \should-print-page-number
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
  \key bes \major
  %% %% beam across 4 eighth notes
  %% \time #'(4) 2/4

  %% make only the first clef visible
  \override Score.Clef.break-visibility = #'#(#f #f #f)

  %% make only the first time signature visible
  \override Score.KeySignature.break-visibility = #'#(#f #f #f)

  %% allow single-staff system bars
  \override Score.SystemStartBar.collapse-height = #1

  \set Score.rehearsalMarkFormatter = #format-mark-box-alphabet

  \override Score.RehearsalMark.self-alignment-X = #LEFT
}

cherokee_chord_names = \chordmode {
  bes1:maj7
  bes2:maj7 f2:aug7
  f1:m7
  bes1:7

  ees1:maj7
  ees1:maj7
  aes1:7
  aes1:7

  bes1
  bes2 d2:m7
  c1:7
  c1:7

  c1:m7
  d2:m7.5 g:7
  c1:m7
  f1:aug7
}

cherokee = \relative c' {
  d1
  f2 g
  bes1
  g1
  \break
  
  f1
  d2 f
  d1
  c1
  \break
  
  bes1
  d2 f
  d'1
  bes1
  \break
  
  g1
  f2 d
  c1
  cis
  \break
}

\score {
  <<
    \new ChordNames { \repeat unfold 1 { \cherokee_chord_names } }
    \new Staff {
      \global
      \cherokee
      %% \pageBreak
    }
  >>
}

