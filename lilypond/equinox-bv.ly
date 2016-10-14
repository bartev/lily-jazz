\version "2.19.31"

\include "bv-jazz-settings.ly"

\include "equinox-bv-notes.ly"
% \include "bv-bill-evans-header.ly"


%\new Staff {
  % \tpart
% }

\header { 
  title = "Equinox"
  subtitle = "(Subtitle)"
  composer = "'Trane"
  meter = ""
  tagline = "Coltrane's Sound"
  piece =  "" }
\layout { indent = 0 }
\midi { \tempo 4 = 80 }

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
    \chordmusic 
  }
  \melody
  \bassline
>>


\markup { \sans "" }