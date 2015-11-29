\version "2.18.2"
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
}

\header {
  title = "Jazz Quartet Template"
  copyright = "Copyright ©"
  tagline = ##f
}

scoreBreaks = {
  s1*9 \break
  s1*9 \bar "|."
}

altoSaxMusic = {
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

bassMusic = {
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
      instrumentName = "Alto Sax."
      shortInstrumentName = "A. Sax."
    } <<
      \scoreBreaks
      \altoSaxMusic
    >>
    \new PianoStaff \with {
      instrumentName = "Piano"
      shortInstrumentName = "Pno."
    }<<
      \new Staff = "rh" \pianoRHMusic
      \new Dynamics \pianoDynamics
      \new Staff = "lh" \pianoLHMusic
    >>
    \new Staff \with {
      instrumentName = "Bass"
      shortInstrumentName = "Bass"
    } \bassMusic
    \new DrumStaff \with {
        instrumentName = "Drum Set"
        shortInstrumentName = "Dr."
    } \drumSetMusic
  >>
  \layout {
    indent = 0.25\in
    \omit Staff.TimeSignature
    %\override Staff.InstrumentName.self-alignment-X = #RIGHT
  }
  %\midi {}  % uncomment for midi output
}