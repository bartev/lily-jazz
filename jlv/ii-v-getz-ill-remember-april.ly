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
title = #"ii-V from I'll Remember April"
composer = #"Stan Getz"
arranger = #""
transcribed = #"Bartev 2026-09"
meter = "220"
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
  %% \key g \major
}

% Define the chord progression

chordsIntro = \chordmode { s2 }
chordsA = \chordmode {
  a1:maj7 | a:6 | a:maj7 | a:6
}

chordsRhythmChanges = \chordmode {
  a1:maj7 | a:6 | a:maj7 | a:6
}

chordsIIV = \chordmode {
  a1:maj7 | a:6 | a:maj7 | a:6
}

introTenor = \relative c' {
  \partial 2
  r8 d g d'
}

melodyA = \relative c'' {
  \bar "||"
  cis'8 c cis e  b ais b d
  cis8 a e ees d e fis gis
  a8 b16 a gis8 fis e d b c
  cis8 c cis e b gis \tuplet 3/2 { a8 c e }

  %% \comp 16
}

degrees = \lyrics {
      \markup \scaleDegree { 3 }4.
      \markup \scaleDegree { 5 }8
      \markup \scaleDegree { 2 }4.
      \markup \scaleDegree { 4 }8

      \markup \scaleDegree { 3 }8
      \markup \scaleDegree { 1 }8
      \markup \scaleDegree { 5 }8
      \markup \scaleDegree { f5 }8
      \markup \scaleDegree { 4 }2

      \markup \scaleDegree { 1 }2
      \markup \scaleDegree { 5 }8
      \markup \scaleDegree { 4 }8
      \markup \scaleDegree { 2 }8
      \markup \scaleDegree { f3 }8
      \markup \scaleDegree { 3 }1
    }

\score {
  <<
    \new ChordNames { \chordsA }
    \chordsA
    \new Staff {
      \global
      \key a \major
      \melodyA
    }
    \degrees
  >>
}
