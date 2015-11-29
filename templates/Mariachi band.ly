\version "2.18.2"
#(set-global-staff-size 16)

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
  title = "Mariachi Band Template"
  copyright = "Copyright ©"
  tagline = ##f
}

scoreBreaks = {
  s1*8 \break
  s1*9 \bar "|."
}

trumpetIMusic = {
  \clef treble
  R1*17
}

trumpetIIMusic = {
  \clef treble
  R1*17
}

violinIMusic = {
  \clef treble
  R1*17
}

violinIIMusic = {
  \clef treble
  R1*17
}

vihuelaMusic = {
  \clef treble
  R1*17
}

acousticGuitarMusic = {
  \clef treble
  R1*17
}

guitarronMusic = {
  \clef treble
  R1*17
}

\score {
  <<
    \new StaffGroup <<
      \new Staff \with {
        instrumentName = "Trumpet 1"
        shortInstrumentName = "Tpt. 1"
      } <<
        \scoreBreaks
        \trumpetIMusic
      >>
      \new Staff \with {
        instrumentName = "Trumpet 2"
        shortInstrumentName = "Tpt. 2"
      } \trumpetIIMusic
    >>
    \new StaffGroup <<
      \new Staff \with {
        instrumentName = "Violin 1"
        shortInstrumentName = "Vln. 1"
      } \violinIMusic
      \new Staff \with {
        instrumentName = "Violin 2"
        shortInstrumentName = "Vln. 2"
      } \violinIIMusic
    >>
    \new ChoirStaff <<
      \new Staff \with {
        instrumentName = "Vihuela"
        shortInstrumentName = "Vih."
      } \vihuelaMusic
      \new Staff \with {
        instrumentName = "Acoustic Guitar"
        shortInstrumentName = "Gtr."
      } \acousticGuitarMusic
      \new Staff \with {
        instrumentName = "Guitarrón"
        shortInstrumentName = "Guitn."
      } \guitarronMusic
    >>
  >>
  \layout {
    indent = 0.5\in
    \omit Staff.TimeSignature
    %\override Staff.InstrumentName.self-alignment-X = #RIGHT
  }
  %\midi {}  % uncomment for midi output
}