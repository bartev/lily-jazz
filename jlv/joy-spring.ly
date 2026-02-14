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
title = #"Joy Spring"
composer = #"Clifford Brown"
arranger = #"Harold Land solo"
transcribed = #"Bartev 2026-02"
meter = "146"
instrument = \instrumentTenor

tagline = \bvTaglineDateTime
copyright = #"Bartev 2026"

%% Paper & Layout settings are in `realbook_layout`
%% Import AFTER setting `title`
%% It defines the realbook title line based on definitions above
\include "realbook_layout.ily"

global = {
  %% \tempo 4=146
  \time 4/4
  \key g \major
}

% Define the chord progression
chordsA = \chordmode {
  g1:maj7| a2:m7 d:7| g1:maj7| c2:m7 f:7
  b2:m7 bes:7| a2:m7 d:7| g1:maj7| bes2:m7 ees:7
}

chordsB = \chordmode {
  aes1:maj7| bes2:m7 ees:7| aes1:maj7| cis2:m7 fis:7
  c2:m7 b:7| bes2:m7 ees:7| aes1:maj7| b2:m7 e:7
}

chordsC = \chordmode {
  a1:maj7| a2:m7 d:7| g1:maj7| g2:m7 c:7
  f1:maj7| bes2:m7 ees:7| aes1:maj7| a2:m7 d:7
}

chordsASec = \chordmode {
  g1:maj7| a2:m7 d:7| g1:maj7| c2:m7 f:7
  b2:m7 bes:7| a2:m7 d:7| g1:maj7| a2:m7 d:7
}

chordChanges = \chordmode {
  \blueChord { \chordsA}  % A (8 bars)
  \greenChord {\chordsB}  % B (8 bars)
  \redChord {\chordsC}  % C (8 bars)
  \blueChord {\chordsASec}  % A (diff last bar)
}

melodyTenor = \relative c'' {
  \global


  \markRedBox "A"
  \comp 16 \break
  \comp 16 \break

  \markRedBox "B"
  \comp 16 \break
  \comp 16 \break

  \markRedBox "C"
  \comp 16 \break
  \comp 16 \break

  \markRedBox "A'"
  \comp 16 \break
  \comp 16 \break
}

\score {
  <<
    \new ChordNames \chordChanges
    \new Voice = soloist \melodyTenor
  >>
}
