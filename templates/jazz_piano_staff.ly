\version "2.24.0"
#(set-global-staff-size 25)
\include "lilyjazz.ily"

\paper {
  #(set-paper-size "letter")
  left-margin = 1\in
  right-margin = 0.75\in
  top-margin = 0.75\in
  bottom-margin = 0.5\in
  % markup-system-spacing = #'((padding . 10))
  markup-system-spacing = #'((basic-distance . 23)
                             (minimum-distance . 8)
                             (padding . 1))  
  last-bottom-spacing = #'((padding . 5))
  ragged-bottom = ##f
  ragged-last = ##f
  %%set to ##t if your score is less than one page:
  ragged-last-bottom = ##t
  ragged-right = ##f
}


\header {
  title = "Jazz Piano Staff"
  copyright = "Copyright ©"
  % tagline = ##f
  tagline = "template by Bartev"
}

global = {
  \numericTimeSignature
  \time 4/4
  \tempo 4=120
  \key g \major
}
scoreBreaks = {
  \repeat unfold 4 { s1*4 \break } \bar "|."
}

pianoRHMusic = {
  \clef treble
  \global
  s1*16
}

pianoDynamics = {
}

pianoLHMusic = {
  \clef bass
  \global
  s1*16
}


\score {
  <<
    \new PianoStaff \with {
      instrumentName = "Keyboard"
      shortInstrumentName = "Keys"
    }<<
      \new Staff = "rh" <<
      \scoreBreaks 
      \pianoRHMusic 
      >>
      \new Dynamics \pianoDynamics
      \new Staff = "lh" \pianoLHMusic
    >>
  >>
  \layout {
    \omit Staff.TimeSignature
    %\override Staff.InstrumentName.self-alignment-X = #RIGHT
  }
}