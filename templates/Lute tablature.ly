\version "2.18.2"

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
  title = "Lute Tablature Template"
  copyright = "Copyright ©"
  tagline = ##f
}

scoreBreaks = {
  \repeat unfold 8 { s1*9 \break }
}

luteMusic = {
  R1*72 \bar "|."
}

\score {
  \new TabStaff <<
    \scoreBreaks
    \luteMusic
  >>
  \layout {
    indent = 0
    \omit TabStaff.Clef
    \omit TabStaff.TimeSignature
    \override Score.SystemStartBar.collapse-height = #6  % comment to add system start bar
  }
  %\midi {}  % uncomment for midi output
}