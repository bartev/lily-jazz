\version "2.18.2"
#(set-global-staff-size 16)
\include "lilyjazz.ily"

\paper {
  #(set-paper-size "letter")
  left-margin = 1\in
  right-margin = 0.75\in
  top-margin = 0.75\in
  bottom-margin = 0.5\in
  markup-system-spacing = #'((padding . 10))
  last-bottom-spacing = #'((padding . 5))
  ragged-bottom = ##f
  ragged-last = ##f
  ragged-last-bottom = ##f
  ragged-right = ##f
  system-separator-markup = \markup { \halign #2 \scale #'(2 . 2) \slashSeparator }
}

\header {
  title = "Jazz Combo, 3 Horns Template"
  copyright = "Copyright ©"
  tagline = ##f
}

scoreBreaks = {
  \repeat unfold 2 { s1*9 \break } \bar "|."
}

hornIMusic = {
  \clef treble
  R1*18
}

hornIIMusic = {
  \clef treble
  R1*18
}

hornIIIMusic = {
  \clef bass
  R1*18
}

guitarMusic = {
  \clef treble
  R1*18
}

pianoRHMusic = {
  \clef treble
  R1*18
}

pianoDynamics = {

}

pianoLHMusic = {
  \clef bass
  R1*18
}

electricBassMusic = {
  \clef bass
  R1*18
}

drumSetMusic = {
  \clef percussion
  R1*18
}

\score {
  <<
    \new Staff \with {
      instrumentName = \markup \right-column { "I" "(Trumpet)" }
      shortInstrumentName = "I"
    } <<
      \scoreBreaks
      \hornIMusic
    >>
    \new Staff \with {
      instrumentName = \markup \right-column { "II" "(Alto Saxophone)" }
      shortInstrumentName = "II"
    } \hornIIMusic
    \new Staff \with {
      instrumentName = \markup \right-column { "III" "(Trombone)" }
      shortInstrumentName = "III"
    } \hornIIMusic
    \new Staff \with {
      instrumentName = "Guitar"
      shortInstrumentName = "Gtr."
    } \guitarMusic
    \new PianoStaff \with {
      instrumentName = "Keyboard"
      shortInstrumentName = "Keys"
    }<<
      \new Staff = "rh" \pianoRHMusic
      \new Dynamics \pianoDynamics
      \new Staff = "lh" \pianoLHMusic
    >>
    \new Staff \with {
      instrumentName = "Electric Bass"
      shortInstrumentName = "Bass"
    } \electricBassMusic
    \new DrumStaff \with {
        instrumentName = "Drum Set"
        shortInstrumentName = "Dr."
    }\drumSetMusic
  >>
  \layout {
    \omit Staff.TimeSignature
    %\override Staff.InstrumentName.self-alignment-X = #RIGHT
  }
  %\midi {}  % uncomment for midi output
}