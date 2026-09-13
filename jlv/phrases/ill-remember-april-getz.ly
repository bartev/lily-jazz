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
title = #"Phrase from \"I'll Remember April\""
composer = #"Stan Getz"
arranger = #""
transcribed = #"Bartev 2026-09"
meter = "220"
instrument = ""

tagline = \bvTaglineDateTime
copyright = #"Bartev 2026"

%% Paper & Layout settings are in `realbook_layout`
%% Import AFTER setting `title`
%% It defines the realbook title line based on definitions above
\include "realbook_layout.ily"

%% override
\paper {
  markup-system-spacing = #'((basic-distance . 3)
                             (minimum-distance . 8)
                             (padding . 1))
}

global = {
  %% \tempo 4=146
  \time 4/4
  %% \key g \major
}

% Define the chord progression

chordsIntro = \chordmode { s2 }
chordsA = \chordmode {
  a1:maj7 | a:6 | a:maj7 | a:6
}

chordsRhythmChangesD = \chordmode {
  d2:maj7 b:7 | e2:m7 a:7 | fis2:m7 b:m7 | e2:m7 a:7
}

chordsRhythmChangesA = \chordmode {
  a2:maj7 fis:7 | b2:m7 e:7 | cis2:m7 fis:m7 | b2:m7 e:7
}

chordsRhythmChangesG = \chordmode {
  g2:maj7 e:7 | a2:m7 d:7 | b2:m7 e:m7 | a2:m7 d:7
}

chordsIIvA = \chordmode {
  b1:m7 | e:7 | a:maj7 | a:maj7
}

introTenor = \relative c' {
  \partial 2
  r8 d g d'
}

melodyA = \relative c'' {
  \bar "||"
  cis'8 c cis e  b ais b d
  cis8 a e ees d e fis gis
  a8 b16 a gis8 fis e d b c
  cis8 c cis e b gis \tuplet 3/2 { a8 c e }

  %% \comp 16
}

degrees = \lyrics {
      \markup \scaleDegree { 3 }4.
      \markup \scaleDegree { 5 }8
      \markup \scaleDegree { 2 }4.
      \markup \scaleDegree { 4 }8

      \markup \scaleDegree { 3 }8
      \markup \scaleDegree { 1 }8
      \markup \scaleDegree { 5 }8
      \markup \scaleDegree { f5 }8
      \markup \scaleDegree { 4 }2

      \markup \scaleDegree { 1 }2
      \markup \scaleDegree { 5 }8
      \markup \scaleDegree { 4 }8
      \markup \scaleDegree { 2 }8
      \markup \scaleDegree { f3 }8
      \markup \scaleDegree { 3 }1
    }

scoreA = <<
  \new Staff {
    \global
    \key a \major
    \melodyA
  }
  \degrees
  \new ChordNames { \chordsA }
  \new Staff {
    \global
    \key a \major
    \chordsA
  }
>>

scoreA = <<
  \new Staff {
    \global
    \key a \major
    \melodyA
  }
  \degrees
  \new ChordNames { \chordsA }
  \new Staff {
    \global
    \key a \major
    \chordsA
  }
>>

scoreMultipleChords = <<
  \new Staff {
    \global
    \key a \major
    \melodyA
  }
  \degrees

  \new ChordNames { \chordsA }
  \new Staff {
    \global
    \key a \major
    \chordsA
  }

  \new ChordNames { \chordsRhythmChangesA}
  \new Staff {
    \global
    \key a \major
    \chordsRhythmChangesA
  }

  \new ChordNames { \chordsIIvA}
  \new Staff {
    \global
    \key a \major
    \chordsIIvA
  }
>>

%% \markup {"1:42 into the tune, m81"}
%% \markup {" "}
%% \markup {"1.1) over A maj"}
%% \score { \scoreA }
%% \markup {"1.2) over E maj"}
%% \score { \transpose a e \scoreA }
%% \markup {"1.3) over D maj"}
%% \score { \transpose a d \scoreA }

\markup \vspace #1
\markup \sans "I'll Remember April - 1st 4 bars, major function"
\markup \sans "Rhythm Changes - 1st 4 bars"
\markup \sans "ii-V-I"
\markup \vspace #1

phraseLabel = #(define-markup-command (phrase-label layout props text)
   (markup?)
   (interpret-markup layout props
    #{ \markup \sans \fontsize #+2 \with-color #blue #text #}))

\markup \phrase-label "In A"
\score { \scoreMultipleChords  }

\markup \phrase-label "In G"
\score { \transpose a g \scoreMultipleChords  }
