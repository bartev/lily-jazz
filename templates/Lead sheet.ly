\version "2.18.2"
\include "lilyjazz.ily"

\paper {
  #(set-paper-size "letter")
  left-margin = 0.75\in
  right-margin = 0.75\in
  top-margin = 0.75\in
  bottom-margin = 0.5\in
  markup-system-spacing = #'((padding . 10))
  last-bottom-spacing = #'((padding . 5))
  ragged-bottom = ##f
  ragged-last = ##f
  ragged-last-bottom = ##f
  ragged-right = ##f
}

\header {
  title = "Lead Sheet Template"
  copyright = "Copyright ©"
  tagline = ##f
}

scoreBreaks = {
  \repeat unfold 8 { s1*4 \break }
}

leadMusic = {
  R1*32 \bar "|."
}

\score {
  \new Staff <<
    \scoreBreaks
    \leadMusic
  >>
  \layout {
    indent = 0
    \omit Staff.TimeSignature
    \override Score.SystemStartBar #'collapse-height = #1  % allow single-staff system bars
  }
  %\midi {}  % uncomment for midi output
}