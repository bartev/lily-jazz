\version "2.24.0"

% Voice leading exercise over Pfrancing (LB Blues)

% set to 18 to fit entire head and title on 1 page
#(set-global-staff-size 23)
\include "jazzchords.ily"
\include "lilyjazz.ily"
\include "jazzextras.ily"
\include "roman_numeral_analysis_tool.ily"

\include "voice-lead-lb-blues.ly"

\header {
  title = \realBookTitle
  % tagline = ##f
  tagline = "Voice Leading exercise Chords"
  copyright = \copyright
}

\score {
  <<
    \new ChordNames \repeat unfold 2 { \theChords }
    \new Staff {
    \repeat unfold 2 \theChords
    }
  >>
}