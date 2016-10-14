\version "2.19.31"

\include "bv-jazz-settings.ly"

% \include "equinox-bv-notes.ly"
% \include "bv-bill-evans-header.ly"


%\new Staff {
  % \tpart
% }

\header { 
  title = "Blues Scale"
  % subtitle = "(Subtitle)"
  % composer = "'Trane"
  meter = ""
  % tagline = "Coltrane's Sound"
  piece =  "" }
\layout { indent = 0 }
\midi { \tempo 4 = 80 }

melody-c = \new Staff \relative c' {
  \clef treble
  \bar "||" 
  c8 es f ges g bes c4
  \bar "||"
}

chordmusic-c = \chordmode {
  c1:min7
}

% \score {
%   \new StaffGroup <<
%     \trumpet
%     \alto
%     \tclef
%     \bclef
%   >>
% }

\new StaffGroup 
<<
  \chords { 
    \set minorChordModifier = \markup { "-" }
	\break
  \chordmusic-c
  }
  \melody-c
  \chordmusic-c
>>


\markup { \sans "" }