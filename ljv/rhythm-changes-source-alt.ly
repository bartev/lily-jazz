
\version "2.20.0"

% Rhythm changes

% set to 18 to fit entire head and title on 1 page
#(set-global-staff-size 18)
\include "jazzchords.ily"
\include "lilyjazz.ily"
\include "jazzextras.ily"
\include "roman_numeral_analysis_tool.ily"


global = {
  \time 4/4
  % \key c \major
  % \tempo 4=224

  % make only the first clef visible
  \override Score.Clef #'break-visibility = #'#(#f #f #f)

  % make only the first time signature visible
  % \override Score.KeySignature #'break-visibility = #'#(#f #f #f)

  % allow single-staff system bars
  \override Score.SystemStartBar #'collapse-height = #1

  \set Score.markFormatter = #format-mark-box-alphabet
  
}

% rhythmAnalysis = \lyricmode {
% \override LyricText #'font-name = #"serif"
% \markup \rN { I6 }2 \markup \rn { vi-7 }2
% \markup \rN { ii-7 }2 \markup \rn { V7 }2
% \markup \rN { iii-7 }2 \markup \rn { vi-7 }2
% \markup \rN { ii-7 }2 \markup \rn { V7 }2

% \markup \rN { I6 }1
% \markup \rN { IV7 }2 \markup \rn { IV7dim }2
% \markup \rN { I6 }2 \markup \rn { V7 }2
% \markup \rN { I6 }2 \markup \rn { V7 }2
% }

rhythmA = \chordmode {
    % \mark "A"
    bes2 g:7
    c:min7 f:7
    bes:min7  g:min7
    c:min7 f:7 
    \break
    
    bes1:7
    g1:7
    c2:min7 f:7
    bes1
    \break
}
rhythmB = \chordmode { 
    % \mark "B"
    d1:7 d1:7
    g1:min7 g1:min7
    \break

    c1:7 c1:7
    f1:7 f1:7
    \break
}

analysisA = \lyricmode {
  \override LyricText #'font-name = #"serif"
  \set stanza = \markup \keyIndication { I }
  \markup \rN { I }2 \markup \rN { VI 7 }2
  \markup \rN { ii - 7 }2 \markup \rN { V 7 }2
  \markup \rN { I }2 \markup \rN { VI 7 }2
  \markup \rN { ii - 7 }2 \markup \rN { V 7 }2


  \markup \rN { I 7 }1
  \markup \rN { IV 7 }1
  \markup \rN { ii - 7 }2 \markup \rN { V 7 }2
  \markup \rN { I }1
}

analysisB = \lyricmode {
  \override LyricText #'font-name = #"serif"
  \set stanza = \markup \keyIndication { VI }
  \markup \rN { V 7 }1
  \markup \rN { V 7 }1
  \set stanza = \markup \keyIndication { II }
  \markup \rN { V 7 }1
  \markup \rN { V 7 }1
  \set stanza = \markup \keyIndication { V }
  \markup \rN { V 7 }1
  \markup \rN { V 7 }1
  \set stanza = \markup \keyIndication { I }
  \markup \rN { V 7 }1
  \markup \rN { V 7 }1
}

chordsRhythm = {
\rhythmA
\rhythmA
\rhythmB
\rhythmA
}

analysis = {
\analysisA
\analysisA
\analysisB
\analysisA
}

chordsAnalysisArpeg = {
  <<
    \new Lyrics \analysis
    \new ChordNames {
      % \set chordChanges = ##t 
      \chordsRhythm
      }
    \new Staff {
      \global
      \bar ".|"
      \numericTimeSignature
      \chordsRhythm
    }
  >>
}

% \score {
%         \transpose bes g \chordsAnalysisArpeg
% }
