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

chordsIntro = \chordmode { s2 }
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

introTenor = \relative c' {
  \partial 2
  r8 d g d'~
}
melodyTenor = \relative c'' {
  \markRedBox "A"
  \bar "||"
  d2~ d8 b \tuplet 3/2 { a16 b a } g8
  a4. b8 r2
  r8 d, g e' d b \tuplet 3/2 { a16 b a } g8
  bes8 g16 ees c8 a'8~ a4 \tuplet 3/2 { g8 a g }
  \break

  d'8 g,4. g4. g8~
  g8 e g c \tuplet 3/2 { b16 c b } g8 e d
  g8 d a' g r2
  r8 c bes aes g ees aes? ees'~
  \bar "||"
  \break

  \markRedBox "B"
  ees2~ ees8 c \tuplet 3/2 { bes16 c bes } aes8
  bes4. c8 r2
  r8 ees, aes f' ees c \tuplet 3/2 { bes16 c bes } aes?8
  b?8 gis16 e cis8 ais'~ ais4 \tuplet 3/2 { gis?8 ais? gis }
  \break

  dis'8 gis,4. gis4. gis8~
  gis8 f aes des c aes? f ees
  aes8 ees bes' aes r2
  r8 cis b fis a g gis16 b d fis
  \bar "||"
  \break

  \markRedBox "C"
  e4. cis8 \tuplet 3/2 { b16 cis? b } a8 c4~
  c8 aes g f fis ees' \tuplet 3/2 { d16 ees d } c8
  d4. b8 \tuplet 3/2 { a16 b a } g8 bes4~
  bes8 f fis ees e des' \tuplet 3/2 { c16 des c } bes8
  \break

  c4 \tuplet 3/2 { a8 g f } g4 a8 bes
  r8 c des ees c bes a bes
  ees4 \tuplet 3/2 { c8 bes aes } bes?8~ bes c r
  r8 b8 ais g fis d g d'~
  \bar "||"
  \break

  \markRedBox "A'"
  d2~ d8 b \tuplet 3/2 { a16 b a } g8
  a4. b8 r2
  r8 d, g e' d b \tuplet 3/2 { a16 b a } g8
  bes8 g16 ees c8 a'~ a4 \tuplet 3/2 { g8 a g }
  \break

  d'8 g,4. g4. g8~
  g8 e g c \tuplet 3/2 { b16 c b } g8 e d
  g8 d a' g r2
  r1
  \bar "||"
  \pageBreak

  \mark \markup "Begin Solo"

  %% \markRedBox "A"
  \comp 16 \break
  \comp 16 \break
  \bar "||"

  \markRedBox "B"
  \comp 16 \break
  \comp 16 \break
  \bar "||"

  \markRedBox "C"
  \comp 16 \break
  \comp 16 \break
  \bar "||"

  \markRedBox "A"
  \comp 16 \break
  \comp 16 \break
  \bar "||"
}

\score {
  <<
    \new ChordNames {
      \chordsIntro
      \repeat unfold 2 \chordChanges
    }
    \new Voice = soloist {
      \global
      \introTenor
      \melodyTenor
    }
  >>
}
