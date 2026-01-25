\version "2.24.2"

\include "jazzchords.ily"
\include "lilyjazz.ily"
\include "jazzextras.ily"
\include "roman_numeral_analysis_tool.ily"

%% bv_definitions is in plugins/bv-lilyjazz/stylesheets.
%% It contains some useful functions such as:
%% timestop
%%   markManualBox
%%   markBlue
%%   blueChord
%%   redChord
%%   greenChord
\include "bv_definitions.ily"

%% Set up title
title = #"Selected phrases from Lester Leaps In"
composer = #"Lester Young"
arranger = #""
meter =  ""
transcribed = #"Bartev 2026-01"
instrument = \instrumentTenor

tagline = \bvTaglineDateTime
copyright = #"Bartev 2025"

%% Paper & Layout settings are in `realbook_layout`
%% Import AFTER setting `title`
%% It defines the realbook title line based on definitions above
\include "realbook_layout.ily"

%% global = {
%%   \tempo 4=130
%% }


% Define the chord progression
chordsA = \chordmode {
  \repeat percent 2 g1:7 |
}

phraseA = \relative c'' {
  d8 e f g a f \tuplet 3/2 { g8 a g }
  e8 f4. r4 r
}

chordChanges = \chordmode {
  \chordsA
}
fourBars = { s1*4 \break }
sixteenBars = \repeat unfold 4 \fourBars

fourBarsC = \repeat unfold 16 { c4 }
sixteenBarsC = {
  \fourBarsC \break
  \fourBarsC \break
  \fourBarsC \break
  \fourBarsC \break
}
melody = \relative c'' {
  %% \global
  \time 4/4
  \key c \major
  \phraseA

  %% \comp 16 \break
  %% \mark "A" \sixteenBars
  %% \comp #8
}

scoreA = \score {
  <<
    \new ChordNames \chordChanges
    \new Voice = soloist \melody
  >>
}

\scoreA
\transpose g c { \scoreA  }
