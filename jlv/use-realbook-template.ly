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
title = #"The Song Is NOT You"
composer = #"Jerome Kern"
arranger = #"Alex Hahn solo"
transcribed = #"Bartev 2025-07"
meter = "(med swing)"
instrument = \instrumentAlto

tagline = \bvTaglineDateTime
copyright = #"Bartev 2025"

%% Paper & Layout settings are in `realbook_layout`
%% Import AFTER setting `title`
%% It defines the realbook title line based on definitions above
\include "realbook_layout.ily"



global = {
  \tempo 4=130
}


% Define the chord progression
chordsAFirst = \chordmode {
  c1 | a:m | d:m | g |
  c | a:m | d:m | g |
  e:m | a:m | d:m | g |
  c | f | c | g |  % different ending
}

chordsASecond = \chordmode {
  c1 | a:m | d:m | g |
  c | a:m | d:m | g |
  e:m | a:m | d:m | g |
  c | f | c2 g | c1 |  % turnaround ending
}

chordsB = \chordmode {
  e1 | e | a:m | a:m |
  d | d | g | g |
  e | e | a:m | a:m |
  d | d | g | g |
}

chordChanges = \chordmode {
  \chordsAFirst  % A1 (16 bars)
  \chordsASecond  % A2 (16 bars)
  %% \chordsB   % B  (16 bars)
  %% \chordsASecond  % A3 (16 bars) - same as A2
}

% Define slash notation (one slash per beat)
slashes = {
  \repeat volta 1 {
    \mark \default
    \repeat unfold 16 {
      \repeat unfold 4 {
        \once \override NoteHead.style = #'slash
        \repeat unfold 4 { c'4 }
      }
      \break
    }
  }
}

fourBars = { s1*4 \break }
sixteenBars = \repeat unfold 4 \fourBars

fourBarsC = \repeat unfold 16 { c4 }
sixteenBarsC = {
  \fourBarsC \break
  \fourBarsC \break
  \fourBarsC \break
  \fourBarsC \break
}


melody = \relative c'' {
  \global
  \time 4/4
  \key bes \major
  %% \slashes
  \mark "A"

  \improvisationOn
  \override Voice.Stem.stencil = ##f
  \sixteenBarsC
  \improvisationOff
  \revert Voice.Stem.stencil

  %% \mark "A" \sixteenBarsC %%
  \mark "B"
  \comp 16 \break
  \comp 16 \break
  \comp 16 \break
  \comp 16 \break
  \mark "A" \sixteenBars
  \comp #8
}

\score {
  <<
    \new ChordNames \chordChanges
    \new Voice = soloist \melody
  >>
}
