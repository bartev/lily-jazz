\version "2.24.2"

#(set-global-staff-size 16)


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
title = #"Three O'Clock in the Morning"
composer = #"Dexter Gordon"
arranger = #""
transcribed = #"Bartev 2025-08"
meter =  "146"
instrument = \instrumentTenor

tagline = \bvTaglineDateTime
copyright = #"Bartev 2025"


%% Paper & Layout settings are in `realbook_layout`
%% Import AFTER setting `title`
%% It defines the realbook title line based on definitions above
\include "realbook_layout.ily"

\paper {
  ragged-bottom = ##f
}

global = {
  \override Glissando.style = #'zigzag
}

%% For Eb instruments
theChordsD = \chordmode {
  \repeat percent 4 { d1:6 }
  d1:6         | fis2:m7 b:7 | e1:m7       | a1:7         |
  e1:m7        | a1:7        | e1:m7       | a1:7         |
  fis1:m7      | b1:7        | e1:m7       | a1:7         |

  \repeat percent 4 { d1:6 }                              |
  d1:6         | d1:7.5+     | \repeat percent 2 { g1:6 } |
  g2:maj7 g2:7 | gis1:dim    | d1:7        | fis2:m7 b:7  |
  e1:m7        | a1:7.9-     | \repeat percent 2 d1:6     |
}

%% For Bb instruments
theChordsG = \transpose bes ees \theChordsD

fourBars = { \comp 16 \break }
sixteenBars = \repeat unfold 4 \fourBars

head = \relative c'' {
  \key g \major
  %% \tempo 4=146

  \mark "Head"
  %% m1
  \timestop "0:08"
  \bar ".|-|"
  \set Score.currentBarNumber = #1
  g4 r4 r4 fis8 g~
  g2 b4-. d-.
  a'2. aes8 g~
  g4 r4 r2
  \break

  %% m5
  \timestop "0:14"
  fis8 g-- r4 r e8 d~
  d2 r4 f,8 fis~
  fis2 r
  r2 r4 d'8 a~
  \bar "||"
  \break

  %% m9
  \timestop "0:21"
  a4 r r gis8 a~
  a4 r c-. e-.
  b'8 b4.~ b4 bes8 a~
  a4 r r2
  \break

  %% m13
  \timestop "0:28"
  r4 r8 g fis4-. a-.
  g8 g4.~ g4 e8 d
  r8 d8~ d4 r d8 e
  g8 f4. d8 c4.
  \bar "||"
  \break

  %% m17
  \timestop "0:35"
  g4 r r fis8 g~
  g4. r8 b4-. d-.
  a'2. aes8 g~
  g2 r
  \break

  %% m21
  \timestop "0:41"
  r4 r8 g fis4-. g-.
  a4-. g-. dis4. e8~
  e4. b16 d c8 e,4.
  r1
  \bar "||"
  \break

  %% m25
  \timestop "0:48"
  e'4. dis8 e4-. fis8 g~
  g2~ \tuplet 3/2 { g4 fis e }
  g8 g4.~ g4 d8 b~
  b4 r r8 c r d
  \break

  %% m29
  \timestop "0:55"
  b'8 b4.~ b2  \glissando
  fis1
  b2 g
  a2 d,
  \bar "|."
  \break
  \pageBreak

  \mark "Solo Chorus 1"
  %% m33
  \timestop "1:01"
  g8 g g g g g r4
  g4-. r8 g \tuplet 3/2 { fis4 e fis }
  g8 d4-. d8 d2
  r2 r4 r8 d8
  \break

  %% m37
  \timestop "1:08"
  g8 a b c d b c d16 c
  b8 g e cis c bes' a g
  \tuplet 3/2 { fis16 g fis } e8 d des c e, g b
  r8 a4. \tuplet 3/2 { r4 a b }
  \break

  %% m41
  \timestop "1:15"
  \tuplet 3/2 { c8 d b } \tuplet 3/2 { c8 a4 } a4 r
  r8 d r e fis g e fis
  d8 d r4 r4 a'8 b
  c8 e, g b a g fis e
  \break

  %% m45
  \timestop "1:22"
  \acciaccatura fis8 g4 e8 c b8 a4.
  \acciaccatura fis'8 g4 ees8 d c d ees g
  fis8 d e fis d b4.
  r4 g16 b \tuplet 3/2 { d16 g b } d8 b4.
  \bar "||"
  \break

  %% m49
  \timestop "1:28"
  fis4. e8 fis e r4
  a4. g8 fis g a b
  g8 d c bes b g' r4
  r2 r4 r8 e
  \break

  %% m53
  \timestop "1:34"
  g8 e a ais b g d c
  b8 g'4. f8 r d f
  e8 ees d des c aes g f
  e8 c'4. r4 r8 c
  \break

  %% m57
  \timestop "1:41"
  dis e f fis g e c a
  g'2 e8 cis bes g
  b8 d e fis a g \tuplet 3/2 { fis16 g fis } e8
  g4 e8 c fis4. d8
  \break

  %% m61
  \timestop "1:48"
  fis8 e fis e b a b4
  f'8 ees f ees bes aes bes4
  e4. d8 e d a a~
  a4 r r8 a4.~
  \bar "||"
  \break
  \pageBreak

  \mark "Solo Chorus 2"
  %% m65
  \timestop "1:55"
  a4. r8 a4. r8
  a4. r8 a4. r8
  a8 d e a e' d4 a8
  e4. r8 a4. g8
  \break

  %% m69
  \timestop "2:01"
  fis8 d e fis d b4.
  r4 \comp 3
  \comp 1 r8 fis''8 d d4.
  r2 d4. b8
  \break

  %% 73
  \timestop "2:08"
  a8 a4.~ a4 r
  r8 g a b d b a g
  fis8 g16 gis  a8 aes16 g  fis8 e d cis
  c8 d e fis b a r g~
  \break

  %% 77
  \timestop "2:15"
  g4 e8 g b g e4
  g4 e8 g ais b g a
  g8 f d c b g'4 r8
  r4 r8 g~ g4. d8
  \bar "||"
  \break

  %% 81
  \timestop "2:22"
  g8 a b4 e,4. d8
  e8 d4 e8 r4 r8 d
  g8 a b4 e,4. d8
  f4 d8 e d4 r8 d
  \break

  %% 85
  \timestop "2:28"
  g8 d ais' b g d c \xNote ais
  b8 g'4.~ g4 f8 a
  g8 e c a d c4.
  r4 r8 g'~ g4 e8 f

  %% 89
  \timestop "2:35"
  g8 g g g g4 e8 g
  bes8 g bes g~ g r b,8 c
  d8 d d d d4 e8 f~
  f4 d8 e r4 r8 d
  \break

  %% 93
  \timestop "2:42"
  g4. e8 g e r g~
  g4 e8 g \tuplet 3/2 { ais16 b ais } g8 d c
  b8 g'4. e4. r8
  r8 d'4. c8 g ais b
  \bar "||"
  \pageBreak

  \mark "Solo Chorus 3"
  %% 97
  \timestop "2:48"
  g4. b8 r4 r8 g
  des'8 c des c bes g bes c
  des8 c des c bes g f d
  cis8 g c g b4 g'8 g~
  \break

  %% 101
  \timestop "2:55"
  g4 e8 g a g e g
  r4 r8 dis8~ dis4 \glissando d'~
  d4. b8 d b4.
  r1
  \break

  %% 105
  \timestop "3:02"
  d,2 \glissando d'8 b4.
  r8 ees, r4 ees'8 c4 r8
  r8 e4. d8 e, g r
  c4 c8 b c b g d
  \break

  %% 109
  \timestop "3:09"
  c8 ais b g' r4 r8 bes~
  bes4 g8 a g f d c
  b8 g'4. f8 d r4
  r4 g~ g4. d8
  \bar "||"
  \break

  %% 113
  \timestop "3:15"
  g8 a b e d d, g c
  b8 d, e a g e c a
  b4 c cis8 d4.
  r4 r8 g8~ g2
  \break

  %% 117
  \timestop "3:22"
  g4 \tuplet 3/2 { bes16 a aes } g8~ g \tuplet 3/2 { bes16 a aes } g4
  \tuplet 3/2 { bes16 a aes } g8~ g4 \tuplet 3/2 { bes16 a aes } g8 bes4
  g8~ g4.~ g8 e f g
  \acciaccatura dis8 e8 c4. r4 r8 c'8
  \break

  %% 121
  \timestop "3:29"
  r8 c4. a8 g e d
  \tuplet 3/2 { cis8 c cis } \tuplet 3/2 { e8 dis e } \tuplet 3/2 { g8 fis g } bes8 g~
  g4 e8 g \acciaccatura ais8 b8 g d cis
  c8 g' r4 r bes4
  \break

  %% 125
  \timestop "3:35"
  g8 g r4 r d'
  g,8 g r4 r bes
  g4 bes g8 bes r g
  r8 f8 d c bes4 g8 a
  \bar "||"
  \break

  %% 129
  \timestop "3:42"
  g8 e4. \comp 2
  \comp 8
  \break
  \pageBreak

  %% \comp 16 \break
  %% \comp 16 \break
  %% \comp 16 \break
  %% \comp 16 \break


}


intro = {
  \override Score.MultiMeasureRest.expand-limit = 1
  \compressEmptyMeasures
  \inlineMMR R1 * 4
}

headAndSolo = \score {
  <<
    \new ChordNames {
      \new ChordNames { s1*4 } % intro
      \repeat unfold 4 \theChordsG
    }

    \new Staff \with {
      instrumentName = "Tenor"
    } {
      \global
      \time 4/4
      \intro
      \head

    }
  >>
}

\headAndSolo
