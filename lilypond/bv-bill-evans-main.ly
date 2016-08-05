\version "2.19.31"

\include "bv-jazz-settings.ly"

\include "bv-bill-evans-notes.ly"
\include "bv-bill-evans-header.ly"


%\new Staff {
  % \tpart
% }

\header { 
  title = "Title"
  subtitle = "(Subtitle)"
  composer = "The composer"
  meter = "Fast meter"
  tagline = "tagline"
  piece =  "A new Beginning of a Bill Evans Solo Transcription — “Time Remembered”" }
\layout { indent = 0 }
\midi { \tempo 4 = 140 }

% \score {
%   \new StaffGroup <<
%     \trumpet
%     \alto
%     \tclef
%     \bclef
%   >>
% }

\score {
  \relative c'' {
    \piano
  }
}

\score {
  <<
    \new StaffGroup = "horns" <<
      \new Staff \alto
      \new Staff \trumpet
      \new Staff \bari
    >>
  >>
}

\markup { \sans "(Example taken from Frank Sikora’s “Neue Jazz-Harmonielehre”, p. 264)" }