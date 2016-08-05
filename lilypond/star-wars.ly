\version "2.19.31"

\include "bv-jazz-settings.ly"

\include "star-wars-notes.ly"

\header { 
  title = "Star Wars"
  subtitle = "(Subtitle)"
  composer = "composer"
  meter = "meter"
  tagline = "tagline"
  piece =  "piece" }
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


\score {
<<
  \numericTimeSignature
	\relative c
	{
  \melody
}
>>
}
\score {
 <<
   \chords { 
     \set minorChordModifier = \markup { "-" }
     \chordmusic 
   }
   \relative c \melody
   % \bassline
 >>
}


\markup { \sans "" }