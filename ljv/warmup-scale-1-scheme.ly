\version "2.20.0"

#(set-global-staff-size 24)
\include "jazzchords.ily"
\include "lilyjazz.ily"
\include "jazzextras.ily"


\paper {
  #(set-paper-size "letter")
  top-margin = 0.5\in
  bottom-margin = 0.5\in
  left-margin = 0.5\in
  right-margin = 0.5\in
  indent = 0\mm
  between-system-space = 2.\cm
  between-system-padding = #0
  %%set to ##t if your score is less than one page:
  ragged-last-bottom = ##t
  ragged-bottom = ##f
  markup-system-spacing = #'((basic-distance . 23)
                             (minimum-distance . 8)
                             (padding . 1))
  oddHeaderMarkup = \markup
    \fill-line {
      \fromproperty #'header:title " "
      \on-the-fly #print-page-number-check-first
      \fromproperty #'page:page-number-string
    }
  evenHeaderMarkup = \markup
    \fill-line {
      \on-the-fly #print-page-number-check-first
      \fromproperty #'page:page-number-string " "
      \fromproperty #'header:title
    }
}

global = {
  \numericTimeSignature
  \time 4/4

  % make only the first clef visible
  \override Score.Clef #'break-visibility = #'#(#f #f #f)

  % make only the first time signature visible
  % \override Score.KeySignature #'break-visibility = #'#(#f #f #f)

  % allow single-staff system bars
  \override Score.SystemStartBar #'collapse-height = #1

  \set Score.markFormatter = #format-mark-box-alphabet
}

\header {
  title = "Scale Warmup Pattern 1"
}

diatonicScale = \relative { c' d e f g a b }
motifUp = \relative c' { c8 d e f}
motifDown = \relative c' { c'8 d e f}


#(display-scheme-music motifUp)
#(display-scheme-music motifDown)


#(with-output-to-file "displ-buffer"
  (lambda () #(display-scheme-music motifUp)))

\motifDown
