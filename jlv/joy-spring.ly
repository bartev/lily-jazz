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
meter = "146"
instrument = \instrumentTenor

transcribed = #"Bartev 2026-02"
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

%% Define the chord progression

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
  %% m1
  \markRedBox "A"
  \timestop "0:11"
  %% \bar "||"
  \bar "[|:"
  d2~ d8 b \tuplet 3/2 { a16 b a } g8
  a4. b8 r2
  r8 d, g e' d b \tuplet 3/2 { a16 b a } g8
  bes8 g16 ees c8 a'8~ a4 \tuplet 3/2 { g8 a g }
  \break

  %% m5
  \timestop "0:18"
  d'8 g,4. g4. g8~
  g8 e g c \tuplet 3/2 { b16 c b } g8 e d
  g8 d a' g r2
  r8 c bes aes g ees aes? ees'~
  \bar "||"
  \break

  %% m9
  \markRedBox "B"
  \timestop "0:23"
  ees2~ ees8 c \tuplet 3/2 { bes16 c bes } aes8
  bes4. c8 r2
  r8 ees, aes f' ees c \tuplet 3/2 { bes16 c bes } aes?8
  b?8 gis16 e cis8 ais'~ ais4 \tuplet 3/2 { gis?8 ais? gis }
  \break

  %% m13
  \timestop "0:29"
  ees'8 aes,4. aes4. aes8~
  aes8 f aes des c aes? f? ees
  aes8 ees bes' aes? r2
  r8 cis b fis a g gis16 b d fis
  \bar "||"
  \break

  %% m17
  \markRedBox "C"
  \timestop "0:34"
  e4. cis8 \tuplet 3/2 { b16 cis? b } a8 c4~
  c8 aes g f fis ees' \tuplet 3/2 { d16 ees d } c8
  d4. b8 \tuplet 3/2 { a16 b a } g8 bes4~
  bes8 f fis ees e des' \tuplet 3/2 { c16 des c } bes8
  \break

  %% m21
  \timestop "0:40"
  c4 \tuplet 3/2 { a8 g f } g4 a8 bes
  r8 c des ees c bes a bes
  ees4 \tuplet 3/2 { c8 bes aes } bes?8~ bes c r
  r8 b8 a g fis d g d'~
  \bar "||"
  \break

  %% m25
  \markRedBox "A'"
  \timestop "0:46"
  d2~ d8 b \tuplet 3/2 { a16 b a } g8
  a4. b8 r2
  r8 d, g e' d b \tuplet 3/2 { a16 b a } g8
  bes8 g16 ees c8 a'~ a4 \tuplet 3/2 { g8 a g }
  \break

  %% m29
  \timestop "0:52"
  d'8 g,4. g4. g8~
  g8 e g c \tuplet 3/2 { b16 c b } g8 e d
  g8 d a' g r8^ \markup \with-color "red" "Begin Solo"
  \timestop "0:56"
  bes \tuplet 3/2 { b8 d fis }
  a8 fis g a16 g e8 c a g
  \bar "||"
  \pageBreak

  \markRedBox "A"
  \timestop "0:58"
  b4. d4 b8 a g
  a8 b~ b4 r2
  r8 a16 g fis8 g b d e fis
  g8 ees bes aes a g' e f
  \break

  %% m37
  \timestop "1:03"
  fis8 d b fis f c' bes aes
  a4 a'8 g aes ees c f~
  f16 g f ees d8 c b d~ d4
  r2 r4 r8 c'
  \break

  \markRedBox "B"
  %% m41
  ees8 c bes aes~ aes16 bes aes g f8 ees
  f8 g~ g4 ees8 c bes aes
  bes4 r8 f8 fis aes bes b
  fis' f e dis cis b ais gis
  \break

  %% m45
  g8 ees~ ees4 f8 r r4
  r2 r4 ees'8 f
  aes4 aes8 aes g f ees c
  ais8 b d fis a gis \tuplet 3/2 { a8 gis fis }
  \break
  \bar "||"

  \markRedBox "C"
  %% m49
  e8 cis gis e b'4 r
  r8 a16 b c e g b c b a g fis e d c
  b16 c d e fis g a fis g d b g d'8 c16 a
  bes16 d g8 r16 g, a bes c d \tuplet 3/2 { e16 eis fis } g16 f e g
  \break

  %% m53
  bes16 des c bes a4 r4 r8 c8
  bes8 aes g f ees e16 ees c8 bes~
  bes16 c bes aes bes8 aes bes c~ c4
  r4 r8 a16 g fis8 ees' c cis
  \break
  \bar "||"

  %% m57
  \markRedBox "A"
  d4 g2 fis8 a
  r8 g fis16 g fis e d8 c a ais
  b8 r r4 r2
  r8 b \tuplet 3/2 { c8 ees g } bes8 d c bes
  \break

  %% m61
  a8 g fis16 g fis e f8 ees c bes
  a8 c e eis fis ees c cis
  d8 g~ g16 a g fis a8 g fis16 g fis e
  g8 e r a, bes d bes a
  \bar "||"
  g8 e r4 r2
  \break

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
