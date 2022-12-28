\version "2.24.0"

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
      \if \should-print-page-number
      \fromproperty #'page:page-number-string
    }
  evenHeaderMarkup = \markup
    \fill-line {
      \if \should-print-page-number
      \fromproperty #'page:page-number-string " "
      \fromproperty #'header:title
    }
}

global = {
  \numericTimeSignature
  \time 4/4

  % make only the first clef visible
  \override Score.Clef.break-visibility = #'#(#f #f #f)

  % make only the first time signature visible
  % \override Score.KeySignature.break-visibility = #'#(#f #f #f)

  % allow single-staff system bars
  \override Score.SystemStartBar.collapse-height = #1

  \set Score.rehearsalMarkFormatter = #format-mark-box-alphabet
}

\header {
  title = "Scale Warmup Pattern 1"
}

diatonicScale = \relative { c' d e f g a b }
motifUp = \relative { c'8 d e f g f e c }
motifDown = \relative { c'8 d e f e d c a }

pat_i_up = {
  \key c \major

  \motifUp
  \modalTranspose c d \diatonicScale \motifUp
  \modalTranspose c e \diatonicScale \motifUp
  \modalTranspose c f \diatonicScale \motifUp
  \modalTranspose c g \diatonicScale \motifUp
  \modalTranspose c a \diatonicScale \motifUp
  \modalTranspose c b \diatonicScale \motifUp
}
pat_i_down = {
  \key c \major

  \modalTranspose c c' \diatonicScale \motifDown
  \modalTranspose c b \diatonicScale \motifDown
  \modalTranspose c a \diatonicScale \motifDown
  \modalTranspose c g \diatonicScale \motifDown
  \modalTranspose c f \diatonicScale \motifDown
  \modalTranspose c e \diatonicScale \motifDown
  \modalTranspose c d \diatonicScale \motifDown
}

\new Staff \relative c' {
  \global
  \mark "C"
  \pat_i_up {c'2 r2} \break
  \pat_i_down {c,2 r2}  \bar "||" \break

  \mark "F"
  \transpose c f { \pat_i_up {c''2 r2} } \break
  \transpose c f { \pat_i_down {c'2 r2} } \bar "||" \break

  \mark "B flat"
  \transpose c bes { \pat_i_up {c''2 r2} } \break
  \transpose c bes { \pat_i_down {c'2 r2} } \bar "||" \break

  \pageBreak

  \mark "E flat"
  \transpose c ees { \pat_i_up {c''2 r2} } \break
  \transpose c ees { \pat_i_down {c'2 r2} } \bar "||" \break

  \mark "A flat"
  \transpose c aes { \pat_i_up {c''2 r2} } \break
  \transpose c aes { \pat_i_down {c'2 r2} } \bar "||" \break

  \mark "D flat"
  \transpose c des { \pat_i_up {c''2 r2} } \break
  \transpose c des { \pat_i_down {c'2 r2} } \bar "||" \break

  \pageBreak

  \mark "F sharp"
  \transpose c fis { \pat_i_up {c''2 r2} } \break
  \transpose c fis { \pat_i_down {c'2 r2} } \bar "||" \break

  \mark "B"
  \transpose c b { \pat_i_up {c''2 r2} } \break
  \transpose c b { \pat_i_down {c'2 r2} } \bar "||" \break

  \mark "E"
  \transpose c e { \pat_i_up {c''2 r2} } \break
  \transpose c e { \pat_i_down {c'2 r2} } \bar "||" \break

  \pageBreak

  \mark "A"
  \transpose c a { \pat_i_up {c''2 r2} } \break
  \transpose c a { \pat_i_down {c'2 r2} } \bar "||" \break

  \mark "D"
  \transpose c d { \pat_i_up {c''2 r2} } \break
  \transpose c d { \pat_i_down {c'2 r2} } \bar "||" \break

  \mark "G"
  \transpose c g { \pat_i_up {c''2 r2} } \break
  \transpose c g { \pat_i_down {c'2 r2} } \bar "||" \break

}