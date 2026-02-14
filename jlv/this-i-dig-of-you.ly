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
title = #"This I Dig of You"
composer = #"Hank Mobley"
arranger = #"Soloist"
transcribed = #"Bartev 2026-02"
meter = "160?"
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
  \key c \major
}

% Define the chord progression

chordsIntro = \chordmode { s4 }

chordsA = \chordmode {
  c1:maj7 | d1:m7 | e1:m7 | d1:m7 |
  ees1:maj7 | d1:m7 | e1:m7 | g2:m7 c:7 |
}

chordsB = \chordmode {
  f1:maj7 | fis2:m7 b:7 | e1:m7 | a1:7 |
  ees1:m7 | aes:7 d:m7 | g:7
}

chordsC = \chordmode {
  f1:maj7 | fis2:m7 b:7 | e1:m7 | a1:7 |
  d1:m7 | g:7 | c:maj7 | c:maj7
}

chordChanges = \chordmode {
  \blueChord { \chordsA}  % A (8 bars)
  \greenChord {\chordsB}  % B (8 bars)
  \blueChord { \chordsA}  % A (8 bars)
  \redChord {\chordsC}  % C (8 bars)

}

introTenor = \relative c'' {
  \partial 4
  r8 g
  \bar ".|"
}
melodyTenor = \relative c'' {
  \markRedBox "A"
  e2. r8 g
  f2. r8 a
  g2. r8 b
  a2. f8. a16
  \break

  g2. e8. g16
  f2. d8. f16
  e2. c8 bes~
  bes2. c8 a'~
  \break

  \markRedBox "B"
  a2. gis8 a
  b2 a2
  g2 r8 e g a~
  a2. r4
  \break

  r8 bes, r f' r ees r aes
  f4. ees8 f ees r4
  r8 a, r e' r d r g
  e4 r r r8 g,8
  \break
  \bar "||"

  \markRedBox "A"
  e'2. r8 g
  f2. r8 a
  g2. r8 b
  a2. f8. a16
  \break

  g2. e8. g16
  f2. d8. f16
  e2. c8 bes~
  bes2. c8 a'~
  \break

  \markRedBox "C"
  a2. gis8 a
  b2 a
  g2 r8 e g a~
  a2. r8 \ottava #1 e'~
  \break

  e8 c4 a8 c a c e
  f8 e4. c8 a b c
  \ottava #0
  r1
  r1
  \bar "|."
  \pageBreak


  \mark \markup "Begin Solo"
  %% \markRedBox "A"
  \comp 16 \break
  \comp 16 \break

  \markRedBox "B"
  \comp 16 \break
  \comp 16 \break
  \bar "||"

  \markRedBox "A"
  \comp 16 \break
  \comp 16 \break

  \markRedBox "C"
  \comp 16 \break
  \comp 16 \break
  \bar "|."
  \pageBreak


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
