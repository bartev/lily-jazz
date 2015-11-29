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
  title = "Piano Template"
  copyright = "Copyright ©"
  tagline = ##f
}

scoreBreaks = {
  \repeat unfold 6 { s1*10 \break }
}

pianoRHMusic = {
  \clef treble
  R1*60 \bar "|."
}

pianoDynamics = {
  s1*60
}

pianoLHMusic = {
  \clef bass
  R1*60 \bar "|."
}

\score {
  \new PianoStaff <<
    \new Staff = "rh" <<
      \scoreBreaks
      \pianoRHMusic
    >>
    \new Dynamics \pianoDynamics
    \new Staff = "lh" {
      \pianoLHMusic
    }
  >>
  \layout {
    indent = 0
  }
  %\midi {}  % uncomment for midi output
}