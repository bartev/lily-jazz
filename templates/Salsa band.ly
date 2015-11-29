\version "2.18.2"
#(set-global-staff-size 18)

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
  title = "Salsa Band Template"
  copyright = "Copyright ©"
  tagline = ##f
}

scoreBreaks = {
  s1*8 \break
  s1*8 \bar "|."
}

filler = { R1*16 }

fluteSaxMusic = {
  \clef treble
  \filler
}

tenorSaxMusic = {
  \clef treble
  \filler
}

leadTrumpetMusic = {
  \clef treble
  \filler
}

trumpetMusic = {
  \clef treble
  \filler
}

tromboneMusic = {
  \clef bass
  \filler
}

bongosMusic = {
  \clef percussion
  \filler
}

congasMusic = {
  \clef percussion
  \filler
}

guiroMusic = {
  \clef percussion
  \filler
}

timbalesMusic = {
  \clef percussion
  \filler
}

bassGuitarMusic = {
  \clef bass
  \filler
}

leadVocalMusic = {
  \clef treble
  \filler
}

leadVocalLyrics = \lyricmode {

}

backingVocalsMusic = {
  \clef treble
  \filler
}

backingVocalsLyrics = \lyricmode {

}

pianoRHMusic = {
  \clef treble
  \filler
}

pianoDynamics = {

}

pianoLHMusic = {
  \clef bass
  \filler
}

\score {
  <<
    \new StaffGroup <<
      \new Staff \with {
        instrumentName = "Flute/Sax."
        shortInstrumentName = "Flt./Sax."
      } <<
        \scoreBreaks
        \fluteSaxMusic
      >>
      \new Staff \with {
        instrumentName = "Tenor Saxophone"
        shortInstrumentName = "Ten. Sax."
      } \tenorSaxMusic
    >>
    \new StaffGroup <<
      \new Staff \with {
        instrumentName = "Lead Trumpet"
        shortInstrumentName = "Ld. Tpt."
      } \leadTrumpetMusic
      \new Staff \with {
        instrumentName = "Trumpet"
        shortInstrumentName = "Tpt."
      } \trumpetMusic
      \new Staff \with {
        instrumentName = "Trombone"
        shortInstrumentName = "Tbn."
      } \tromboneMusic
    >>
    \new StaffGroup <<
      \new DrumStaff \with {
        instrumentName = "Bongos"
        shortInstrumentName = "Bongos"
        \override Stem.Y-extent = ##f
        \override StaffSymbol.line-count = #2
        \override StaffSymbol.staff-space = #2
        \override VerticalAxisGroup.minimum-Y-extent = #'(-3.0 . 4.0)
        drumStyleTable = #bongos-style
      } \bongosMusic
      \new DrumStaff \with {
        instrumentName = "Congas"
        shortInstrumentName = "Congas"
        \override Stem.Y-extent = ##f
        \override StaffSymbol.line-count = #2
        \override StaffSymbol.staff-space = #2
        \override VerticalAxisGroup.minimum-Y-extent = #'(-3.0 . 4.0)
        drumStyleTable = #congas-style
      } \congasMusic
      \new DrumStaff \with {
        instrumentName = "Guiro"
        shortInstrumentName = "Guiro"
        \override Stem.Y-extent = ##f
        \override StaffSymbol.line-count = #1
      } \guiroMusic
      \new DrumStaff \with {
        instrumentName = "Timbales"
        shortInstrumentName = "Timb."
        \override Stem.Y-extent = ##f
        \override StaffSymbol.line-count = #2
        \override StaffSymbol.staff-space = #2
        \override VerticalAxisGroup.minimum-Y-extent = #'(-3.0 . 4.0)
        drumStyleTable = #timbales-style
      } \timbalesMusic
    >>
    \new Staff \with {
      instrumentName = "Bass Guitar"
      shortInstrumentName = "Bass"
    } \bassGuitarMusic
    \new ChoirStaff <<
      \new Staff \with {
        instrumentName = "Lead Vocal"
        shortInstrumentName = "Ld. Vox."
      } \new Voice = "lead" \leadVocalMusic
      \new Lyrics \lyricsto "lead" \leadVocalLyrics
      \new Staff \with {
        instrumentName = "Backing Vocals"
        shortInstrumentName = "Bk. Vox."
      } \new Voice = "backing" \backingVocalsMusic
      \new Lyrics \lyricsto "backing" \backingVocalsLyrics
    >>
    \new PianoStaff \with {
      instrumentName = "Piano"
      shortInstrumentName = "Pno."
    } <<
      \new Staff = "up" \pianoRHMusic
      \new Dynamics \pianoDynamics
      \new Staff = "down" \pianoLHMusic
    >>
  >>
  \layout {
    indent = 0.75\in
    \omit Staff.TimeSignature
    %\override Staff.InstrumentName.self-alignment-X = #RIGHT
  }
  %\midi {}  % uncomment for midi output
}