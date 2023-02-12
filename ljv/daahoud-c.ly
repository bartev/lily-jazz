\version "2.24.0"

%% See here for formatting text
%% https://lilypond.org/doc/v2.20/Documentation/notation/formatting-text

%% set to 18 to fit entire head and title on 1 page
#(set-global-staff-size 18)
\include "jazzchords.ily"
\include "lilyjazz.ily"
\include "jazzextras.ily"
\include "roman_numeral_analysis_tool.ily"
\include "bv_definitions.ily"

\include "daahoud.ly"


\header {
  title = \realBookTitle
  tagline = "Awesome transcription by Bartev (Concert Key)"
  copyright = \copyright
  %% The following fields are evenly spread on one line
  %% the field "instrument" also appears on following pages
  instrument = \markup \with-color #blue "Concert Key"
}

%% Concert key
\transposedScore
