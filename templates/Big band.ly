\version "2.18.2"
#(set-global-staff-size 16)

\paper {
  #(set-paper-size "letter")
  left-margin = 1\in
  right-margin = 1\in
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
  title = "Big Band Template"
  copyright = "Copyright ©"
  tagline = ##f
}

scoreBreaks = {
  \repeat unfold 2 { s1*8 \break } \bar "|."
}

altoIMusic = {
  \clef treble
  R1*16
}

altoIIMusic = {
  \clef treble
  R1*16
}

tenorIMusic = {
  \clef treble
  R1*16
}

tenorIIMusic = {
  \clef treble
  R1*16
}

bariSaxMusic = {
  \clef treble
  R1*16
}

trumpetIMusic = {
  \clef treble
  R1*16
}

trumpetIIMusic = {
  \clef treble
  R1*16
}

trumpetIIIMusic = {
  \clef treble
  R1*16
}

trumpetIVMusic = {
  \clef treble
  R1*16
}

tromboneIMusic = {
  \clef bass
  R1*16
}

tromboneIIMusic = {
  \clef bass
  R1*16
}

tromboneIIIMusic = {
  \clef bass
  R1*16
}

bassTromboneMusic = {
  \clef bass
  R1*16
}

guitarMusic = {
  \clef treble
  R1*16
}

pianoRHMusic = {
  \clef treble
  R1*16
}

pianoDynamics = {

}

pianoLHMusic = {
  \clef bass
  R1*16
}

bassGuitarMusic = {
  \clef bass
  R1*16
}

drumSetMusic = {
  \clef percussion
  R1*16
}

\score {
  <<
    \new StaffGroup = "saxophones" <<
      \new Staff \with {
        instrumentName = "Alto 1"
        shortInstrumentName = "Alto 1"
      }<<
        \scoreBreaks
        \altoIMusic
      >>
      \new Staff \with {
        instrumentName = "Alto 2"
        shortInstrumentName = "Alto 2"
      } \altoIIMusic
      \new Staff \with {
        instrumentName = "Tenor 1"
        shortInstrumentName = "Tenor 1"
      } \tenorIMusic
      \new Staff \with {
        instrumentName = "Tenor 2"
        shortInstrumentName = "Tenor 2"
      } \tenorIIMusic
      \new Staff \with {
        instrumentName = "Bari. Sax."
        shortInstrumentName = "Bari. Sax."
      } \bariSaxMusic
    >>
    \new StaffGroup = "horns" <<
      \new Staff \with {
        instrumentName = "Trumpet 1"
        shortInstrumentName = "Tpt. 1"
      } \trumpetIMusic
      \new Staff \with {
        instrumentName = "Trumpet 2"
        shortInstrumentName = "Tpt. 2"
      } \trumpetIIMusic
      \new Staff \with {
        instrumentName = "Trumpet 3"
        shortInstrumentName = "Tpt. 3"
      } \trumpetIIIMusic
      \new Staff \with {
        instrumentName = "Trumpet 4"
        shortInstrumentName = "Tpt. 4"
      } \trumpetIVMusic
      \new Staff \with {
        instrumentName = "Trombone 1"
        shortInstrumentName = "Tbn. 1"
      } \tromboneIMusic
      \new Staff \with {
        instrumentName = "Trombone 2"
        shortInstrumentName = "Tbn. 2"
      } \tromboneIIMusic
      \new Staff \with {
        instrumentName = "Trombone 3"
        shortInstrumentName = "Tbn. 3"
      } \tromboneIIIMusic
      \new Staff \with {
        instrumentName = "BassTrombone"
        shortInstrumentName = "B. Tbn."
      } \bassTromboneMusic
    >>
    \new Staff \with {
      instrumentName = "Guitar"
      shortInstrumentName = "J. Gtr."
    } \guitarMusic
    \new PianoStaff \with {
      instrumentName = "Piano"
      shortInstrumentName = "Pno."
    }<<
      \new Staff = "rh" \pianoRHMusic
      \new Dynamics \pianoDynamics
      \new Staff = "lh" \pianoLHMusic
    >>
    \new Staff \with {
      instrumentName = "Bass Guitar"
      shortInstrumentName = "Bass"
    } \bassGuitarMusic
    \new DrumStaff \with {
        instrumentName = "Drum Set"
        shortInstrumentName = "Dr."
    }\drumSetMusic
  >>
  \layout {
    \omit Staff.TimeSignature
  }
  %\midi {}  % uncomment for midi output
}