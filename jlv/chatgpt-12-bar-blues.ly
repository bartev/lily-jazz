\version "2.24.2"
#(set-global-staff-size 16)

\include "lilyjazz.ily"
\include "jazzchords.ily"
\include "jazzextras.ily"

\header {
  title = "12-Bar Blues in B♭"
  composer = "Trad."
  arranger = "Bartev"
  instrument = "Lead Sheet"
  tagline = "2025"
  meter = "148"
}

\paper {
  #(set-paper-size "letter")
  top-margin = 12\mm
  bottom-margin = 10\mm
  left-margin = 14\mm
  right-margin = 14\mm
  indent = 0
  print-page-number = ##f
}

\layout {
  \context {
    \Score
    \override RehearsalMark.font-family = #'jazz
    \override RehearsalMark.font-size = #5
    markFormatter = #format-mark-box-alphabet
  }
  \context {
    \ChordNames
    \consists "Percent_repeat_engraver"
    chordChanges = ##t
  }
}

% Define the chord progression
bluesChords = \chordmode {
  \repeat volta 1 {
    \mark \default
    \mark \default
    \repeat percent 4 bes1:7 \break
    \repeat percent 2 ees1:7
    \repeat percent 2 bes1:7 \break
    f1:7 | ees1:7 | bes1:7 | f1:7 \break
  }
}

% Define slash notation (one slash per beat)
slashes = {
  \repeat volta 1 {
    \mark \default
    \repeat unfold 12 {
      \once \override NoteHead.style = #'slash
      \repeat unfold 4 { c'4 }
    }
  }
}

\score {
  <<
    \new ChordNames {
      \bluesChords
    }
    \new Staff {
      \clef treble
      \time 4/4
      \key bes \major
      \slashes
    }
  >>
}
