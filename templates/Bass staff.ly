\version "2.20.0"

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
  title = "Bass Staff Template"
  copyright = "Copyright ©"
  tagline = ##f
}

scoreBreaks = {
  \repeat unfold 9 { s1*10 \break }
}

bassMusic = {
  \clef bass
  s1*90 \bar "|."
}

\score {
  \new Staff <<
    \scoreBreaks
    \bassMusic
  >>
  \layout {
    indent = 0
    \omit Staff.TimeSignature
  }
  %\midi {}  % uncomment for midi output
}