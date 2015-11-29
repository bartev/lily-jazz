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
  title = \markup \sans "Pop Group Template"
  copyright = "Copyright ©"
  tagline = ##f
}

scoreBreaks = {
  \repeat unfold 2 { s1*8 \break }
}

leadVocalsMusic = {
  \clef treble
  R1*16 \bar "|."
}

leadVocalsLyrics = \lyricmode {

}

backingVocalsMusic = {
  \clef treble
  R1*16 \bar "|."
}

backingVocalsLyrics = \lyricmode {

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

drumSetMusic = {
  \clef percussion
  R1*16 \bar "|."
}

\score {
  <<
    \new ChoirStaff = "vocals" <<
      \new Staff \with {
        instrumentName = "Lead Vocals"
        shortInstrumentName = "Ld. Vox."
      }<<
        \scoreBreaks
        \new Voice = "lead" \leadVocalsMusic
      >>
      \new Lyrics \lyricsto "lead" \leadVocalsLyrics
      \new Staff \with {
        instrumentName = "Backing Vocals"
        shortInstrumentName = "Bk. Vox."
      }{
        \new Voice = "backing" \backingVocalsMusic
      }
      \new Lyrics \lyricsto "backing" \backingVocalsLyrics
    >>
    \new ChoirStaff = "guitars" <<
      \new Staff \with {
        instrumentName = "Lead Guitar"
        shortInstrumentName = "Lead"
      }\leadGuitarMusic
      \new Staff \with {
        instrumentName = "Rhythm Guitar"
        shortInstrumentName = "Rhythm"
      }\rhythmGuitarMusic
      \new Staff \with {
        instrumentName = "Bass Guitar"
        shortInstrumentName = "Bass"
      }\bassGuitarMusic
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