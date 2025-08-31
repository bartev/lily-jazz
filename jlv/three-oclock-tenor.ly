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

  \mark "A"
  %% m1
  \timestop "0:00"
  \bar ".|-|"
  \set Score.currentBarNumber = #1
  g4 r4 r4 fis8 g~
  g2 b4-. d-.
  a'2. aes8 g~
  g4 r4 r2
  \break

  %% m5
  fis8 g-- r4 r e8 d~
  d2 r4 f,8 fis~
  fis2 r
  r2 r4 d'8 a~
  \bar "||"
  \break

  %% m9
  a4 r r gis8 a~
  a4 r c-. e-.
  b'8 b4.~ b4 bes8 a~
  a4 r r2
  \break

  %% m13
  r4 r8 g fis4-. a-.
  g8 g4.~ g4 e8 d
  r8 d8~ d4 r d8 e
  g8 f4. d8 c4.
  \bar "||"
  \break

  %% m17
  g4 r r fis8 g~
  g4. r8 b4-. d-.
  a'2. aes8 g~
  g2 r
  \break

  %% m21
  r4 r8 g fis4-. g-.
  a4-. g-. dis4. e8~
  e4. b16 d c8 e,4.
  r1
  \bar "||"
  \break

  e'4. dis8 e4-. fis8 g~
  g2~ \tuplet 3/2 { g4 fis e }
  g8 g4.~ g4 d8 b~
  b4 r r8 c r d
  \break

  b'8 b4.~ b2  \glissando
  fis1
  b2 g
  a2 d
  \bar "|."
  \break
  \pageBreak

  \fourBars
  \fourBars
  \fourBars

  \comp 16 \break
  \comp 16 \break
  \comp 16 \break
  \comp 16 \break

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
      \repeat unfold 2 \theChordsG
    }

    \new Staff \with {
      instrumentName = "Tenor"
    } {
      \global
      \time 4/4
      \intro
      \head
      \pageBreak
      \sixteenBars
    }
  >>
}

\headAndSolo
