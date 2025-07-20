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
title = #"The Song Is NOT You"
composer = #"Jerome Kern"
arranger = #"Alex Hahn solo"
transcribed = #"Bartev 2025-07"
meter = ""
instrument = \instrumentAlto

tagline = \bvTaglineDateTime
copyright = #"Bartev 2025"
copyright = \markup { #"C<^ D0 E>@" }
copyright = \markup {
  \override #'(font-name . "lilyjazz-chord") "C<^ D0 E>@"
}


%% Paper & Layout settings are in `realbook_layout`
%% Import AFTER setting `title`
%% It defines the realbook title line based on definitions above
\include "realbook_layout.ily"



global = {
  \tempo 4=130
}


% Define the chord progression
chordsAFirst = \chordmode {
  a1:maj7 | c:dim7 | b:m7          | e:7       |
  a1:maj7 | fis:7  | b:m7          | e:7       |
  cis1:m7 | fis:7  | b:m7          | e:7       |
  d1:m7   | g:7    | cis2:m7 fis:7 | b2:m7 e:7 | % different ending
}

chordsASecond = \chordmode {
  a1:maj7 | c:dim7 | b:m7 | e:7              |
  a1:maj7 | fis:7  | b:m7 | e:7              |
  cis1:m7 | fis:7  | b:m7 | e:7              |
  \repeat percent 3 a1:6  | dis2:m7.5- gis:7 | % turnaround ending
}

chordsB = \chordmode {
  \repeat percent 2 cis1:maj7 | ees:m7  | aes:7  |
  \repeat percent 2 cis1:maj7 | g:m7.5- | c:7.9- |
  \repeat percent 2 f1:m7     | \repeat percent 2 bes:7 |
  \repeat percent 2 ees1:7    | \repeat percent 2 aes:7 |
}

chordChanges = \chordmode {
  \chordsAFirst  % A1 (16 bars)
  \chordsASecond  % A2 (16 bars)
  \chordsB   % B  (16 bars)
  \chordsASecond  % A3 (16 bars) - same as A2
}

fourBars = { s1*4 \break }
sixteenBars = \repeat unfold 4 \fourBars

\score {
  <<
    \new ChordNames {
      \chordChanges
     }
    \new Staff {
      \global
      \time 4/4
      \key a \major
      \mark "A" \sixteenBars
      \mark "A" \sixteenBars
      \mark "B" \sixteenBars
      \mark "A" \sixteenBars
    }
  >>
}

\pageBreak

%% Chords only
\score {
  <<
    \new ChordNames \chordChanges
    \new Staff {
      <<
        \chordChanges
        {
          \mark "A1" s1*8 \break s1*8 \break
          \mark "A2" s1*8 \break s1*8 \break
          \mark "B"  s1*8 \break s1*8 \break
          \mark "A2" s1*8 \break s1*8 \break
        }
      >>
    }
  >>
}
