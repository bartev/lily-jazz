\version "2.18.2"

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
  title = \markup \sans "R & B Band Template"
  copyright = "Copyright ©"
  tagline = ##f
}

scoreBreaks = {
  \repeat unfold 2 { s1*8 \break }
}

voiceMusic = {
  \clef treble
  R1*16 \bar "|."
}

voiceLyrics = \lyricmode {

}

altoMusic = {
  \clef treble
  R1*16 \bar "|."
}

altoLyrics = \lyricmode {

}

tenorMusic = {
  \clef treble
  R1*16 \bar "|."
}

tenorLyrics = \lyricmode {

}

trumpetMusic = {
  \clef treble
  R1*16 \bar "|."
}

tromboneMusic = {
  \clef bass
  R1*16 \bar "|."
}

leadGuitarMusic = {
  \clef treble
  R1*16 \bar "|."
}

rhythmGuitarMusic = {
  \clef treble
  R1*16 \bar "|."
}

bassGuitarMusic = {
  \clef bass
  R1*16 \bar "|."
}

pianoRHMusic = {
  \clef treble
  R1*16 \bar "|."
}

pianoDynamics = {

}

pianoLHMusic = {
  \clef bass
  R1*16 \bar "|."
}

drumSetMusic = {
  \clef percussion
  R1*16 \bar "|."
}

\score {
  <<
    \new Staff \with {
      instrumentName = "Voice"
      shortInstrumentName = "Voice"
    }<<
      \scoreBreaks
      \new Voice = "voice" \voiceMusic
    >>
    \new Lyrics \lyricsto "voice" \voiceLyrics
    \new StaffGroup = "backupVoice" <<
      \new Staff \with {
        instrumentName = "Alto"
        shortInstrumentName = "Alto"
      }<<
        \new Voice = "alto" \altoMusic
      >>
      \new Lyrics \lyricsto "alto" \altoLyrics
      \new Staff \with {
        instrumentName = "Tenor"
        shortInstrumentName = "Tenor"
      }{
        \new Voice = "tenor" \tenorMusic
      }
      \new Lyrics \lyricsto "tenor" \tenorLyrics
    >>
    \new StaffGroup = "brass" <<
      \new Staff \with {
        instrumentName = \markup { \concat { "Trumpet in B" \raise #0.3 \tiny \flat }}
        shortInstrumentName = "Tpt."
      } \trumpetMusic
      \new Staff \with {
        instrumentName = "Trombone"
        shortInstrumentName = "Tbn."
      } \tromboneMusic
    >>
    \new ChoirStaff = "guitars" <<
      \new Staff \with {
        instrumentName = "Lead Guitar"
        shortInstrumentName = "Lead"
      } \leadGuitarMusic
      \new Staff \with {
        instrumentName = "Rhythm Guitar"
        shortInstrumentName = "Rhythm"
      } \rhythmGuitarMusic
      \new Staff \with {
        instrumentName = "Bass Guitar"
        shortInstrumentName = "Bass"
      } \bassGuitarMusic
    >>
    \new PianoStaff \with {
      instrumentName = "Piano"
      shortInstrumentName = "Pno."
    }<<
      \new Staff = "rh" \pianoRHMusic
      \new Dynamics \pianoDynamics
      \new Staff = "lh" \pianoLHMusic
    >>
    \new DrumStaff \with {
        instrumentName = "Drum Set"
        shortInstrumentName = "Dr."
    }\drumSetMusic
  >>
  \layout {
    \omit Staff.TimeSignature
    \override Staff.InstrumentName.font-family = #'sans
  }
  %\midi {}  % uncomment for midi output
}