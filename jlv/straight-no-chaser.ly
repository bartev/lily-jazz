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

  \mark "Chorus 2"

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
      \repeat unfold 2 \theChordsC
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
