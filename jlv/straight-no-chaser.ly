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
title = #"Straight No Chaser"
composer = #"Thenonious Monk"
arranger = #""
transcribed = #"Bartev 2026-01"
meter =  "med blues"
instrument = \instrumentTenor

tagline = \bvTaglineDateTime
copyright = #"Bartev 2026"


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

%% For C instruments%}
theChordsBb = \chordmode {
  bes1:7        ees:7         \repeat percent 2 { bes:7 }
  \repeat percent 2 { ees:7 } \repeat percent 2 { bes:7 }
  \repeat percent 2 { f:7 }   \repeat percent 2 { bes:7 }
}

%% theChordsBb = \chordmode {
%%   bes1:7      | ees:7         | \repeat percent 2 { bes:7 } |
%%   \repeat percent 2 { ees:7 } | \repeat percent 2 { bes:7 } |
%%   \repeat percent 2 { f:7 }   | \repeat percent 2 { bes:7 } |
%% }


%% For Eb instruments
theChordsG = \transpose ees c \theChordsBb


%% For Bb instruments
theChordsC = \transpose bes c \theChordsBb



fourBars = { \comp 16 \break }
twelveBars = \repeat unfold 3 \fourBars

intro = \relative c' { \partial 8 f8 | }

head = \relative c'' {
  \key bes \major
  %% \tempo 4=146

  \mark "Head (2nd x)"
  %% m1
  \bar ".|-|"
  \set Score.currentBarNumber = #1
  \timestop "0:30"
  bes8 c des d r f, bes c
  des8 d ees des r4 r8 f,
  bes8 c des d r f, bes c
  des8 d r f, bes c des4
  \break

  %% m5
  \timestop "0:35"
  r8 f, bes c des d ees des
  r1
  r8 f, bes c des d r8 f,
  bes8 c des d r f, bes c
  \break

  %% m9
  \timestop "0:41"
  des8 d ees f, fis g gis a~
  a8 bes b c cis d ees f,
  bes c des d r2
  r1
  \bar "||"
  \break


  %% \comp 16 \break
  %% \comp 16 \break
  %% \comp 16 \break
  %% \comp 16 \break
}

%% Tenor solo, C7 (not concert key)
soloC = \relative c'' {
  \mark "Solo"
  \timestop "0:46"
  r8 g c c   r g' g c,
  r8 g' r c, e4 f
  r2 c8 d dis e
  f8 g dis e c g a4
  \break

  \timestop "0:51"
  a8 c d ees~ ees4 r
  r4 a,8 c d ees r4
  r2 r4 c8 d
  ees8 e f fis g e r4
  \break

  \timestop "0:56"
  r4 r8 g, a g bes g
  b8 g c g cis e r4
  r8 g, c d dis e f fis
  g8 e c a d8 g,4.
  \break

  \mark "Chorus 3"

  \timestop "1:02"
  r4 r8 g c g' r c,
  f4. c8 ees e r4
  r2 e8 f fis g~
  g2 \tuplet 3/2 { f8 ees c } a8 g
  \break

  \timestop "1:07"
  a4. c8 f c g' ees
  r2 r8 f \tuplet 3/2 { g8 c g }
  e8 f r4 f16 fis f c bes8 a
  c8 g a bes~ bes b~ b4
  \break

  \timestop "1:12"
  c4 cis8 g' r4 r8 fis
  f8 g, c e d dis e f
  r2 fis8 g \tuplet 3/2 { f8 e d }
  c8 g bes g c g c e
  \break

  \mark "Chorus 2"

  \timestop "1:18"

  %% \comp 4
  %% \comp 16 \break

  \comp 16 \break
  \comp 16 \break
}


%% intro = {
%%   \override Score.MultiMeasureRest.expand-limit = 1
%%   \compressEmptyMeasures
%%   \inlineMMR R1 * 4
%% }

headAndSoloBb = \score {
  <<
    \new ChordNames {
      \new ChordNames { s8 } % intro
      \repeat unfold 1 \theChordsBb
    }

    \new Staff \with {
      instrumentName = "C"
    } {
      \global
      \time 4/4
      \intro
      \head
    }
  >>
}

headAndSoloC = \score {
  <<
    \new ChordNames {
      \new ChordNames { s8 } % intro
      \repeat unfold 4 \theChordsC
    }

    \new Staff \with {
      instrumentName = "Tenor"
    } {
      \global
      \time 4/4
      \transpose bes c' \intro
      \transpose bes c' \head
      \soloC
    }
    >>
}

headAndSoloG = \score {
  <<
    \new ChordNames {
      \new ChordNames { s8 } % intro
      \repeat unfold 1 \theChordsG
    }

    \new Staff \with {
      instrumentName = "Alto"
    } {
      \global
      \time 4/4
      \transpose ees c \intro
      \transpose ees c \head
    }
    >>
}


\headAndSoloC
\pageBreak
\headAndSoloBb
\pageBreak
\headAndSoloG
