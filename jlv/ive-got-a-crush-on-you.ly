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
title = #"I've Got a Crush on You"
composer = #"George Gershwin"
arranger = #"?"
transcribed = #"Bartev 2026-02"
meter = "80?"
instrument = \instrumentTenor

tagline = \bvTaglineDateTime
copyright = #"Bartev 2026"

%% Paper & Layout settings are in `realbook_layout`
%% Import AFTER setting `title`
%% It defines the realbook title line based on definitions above
\include "realbook_layout.ily"

%% Overide chord repeater%
\layout {
  \context {
    \ChordNames
    chordChanges = ##f %% Show all chords, even if no change
  }
}

global = {
  %% \tempo 4=146
  \time 4/4
  \key f \major
}

% Define the chord progression

chordsIntro = \chordmode { s2 }
chordsA = \chordmode {
  f2 aes:dim7 | g2:m7 c:7 | f2 aes:dim7 | g2:m7 c:7
  a2:m7 d:m7 | g1:7 | g1:7 | g2:m7 c:7
}

chordsB = \chordmode {
  f2 aes:dim7 | g2:m7 c:7 | f2 aes:dim7 | g2:m7 bes4:m ees:7
  a2:m7 d:m7 | g1:7 | f2 d:m7 | g2:7 c:7
  f1:6 | g2:m7 c:7
}


chordChanges = \chordmode {
  \blueChord { \chordsA}  % A (8 bars)
  \redChord {\chordsB}  % B (10 bars)
  }

introTenor = \relative c' {
  \partial 2
  r8 d g d'
}
melodyTenor = \relative c'' {
  \global

  \markRedBox "A"
  e4 g8 e~ e2
  r4 d8 f a2
  e8 e g g e e4.
  r4 d8 f a2
  \break

  c4 a8 g~ g f a4
  e8 d4. r8 g a g
  e8 d4. r8 g8 a g
  a8 g4.~ g2
  \bar "||"
  \break

  \markRedBox "B"
  c4. a8 g f4 a8
  e2 r
  a,4 c d f
  a4. gis8 a c, d f
  \break
  \comp 16 \break
  \comp 8 \break
  \bar "|."

  \mark \markup "Begin Solo"
  %% \markRedBox "A"
  \comp 16 \break
  \comp 16 \break
  \bar "||"

  \markRedBox "B"
  \comp 16 \break
  \comp 16 \break
  \comp 8 \break
  \bar "|."

}

\score {
  <<
    \new ChordNames {
      \chordsIntro
      \repeat unfold 2 \chordChanges
    }
    \new Voice = soloist {
      \introTenor
      \melodyTenor
    }
  >>
}
