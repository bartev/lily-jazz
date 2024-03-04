\version "2.24.0"

%% See here for formatting text
%% https://lilypond.org/doc/v2.20/Documentation/notation/formatting-text

%% set to 18 to fit entire head and title on 1 page
#(set-global-staff-size 16)
\include "jazzchords.ily"
\include "lilyjazz.ily"
\include "jazzextras.ily"
\include "roman_numeral_analysis_tool.ily"
\include "bv_definitions.ily"

%% bv_definitions is in plugins/bv-lilyjazz/stylesheets.
%% It contains some useful functions such as:
%% timestop
%%   markManualBox
%%   markBlue
%%   blueChord
%%   redChord
%%   greenChord

%% set up title, compser, meter, copyright
title = #"Night and Day"
composer = #"Cole Porter"
arranger = #"For soprano"
tagline = "Joe Hendeson transcription 2023-11"
meter = "120"
copyright = #"Bartev 2023"

%%%%%%%%%%%%%%%%%%%% Boilerplate - Setup Page, title, header, etc.

realBookTitle = \markup {
  \score {
    {
      \override TextScript.extra-offset = #'(0 . -4.5)
      s4
      s^\markup
      \fill-line {
        %% meter
        \fontsize #2 \lower #2 \rotate #7 \concat { \note { 4 } #1  " = " #meter }
        %% title
        \fontsize #5
        \override #'(offset . 7) \override #'(thickness . 6)
        \underline \larger #title
        %% composer
        \fontsize #2 \lower #1 \concat { #composer " " }
      }
      s
    }
    \layout {
      \omit Staff.Clef
      \omit Staff.TimeSignature
      \omit Staff.KeySignature
      ragged-right = ##f
      ragged-bottom = ##f
      ragged-last-bottom = ##t
    }
  }
}

\header {
  title = \realBookTitle
  tagline = \tagline
  copyright = \copyright
  %% The following fields are evenly spread on one line
  %% the field "instrument" also appears on following pages
  %% instrument = \markup \with-color #blue "Alto Sax"
}

\paper {
  #(set-paper-size "letter")
  #(define fonts
    (set-global-fonts
     #:music "lilyjazz"
     #:brace "lilyjazz"
     #:roman "lilyjazz-text"
     #:sans "lilyjazz-chord"
     #:factor (/ staff-height pt 18)
   ))

  top-margin = 0.5\in
  bottom-margin = 0.5\in
  left-margin = 0.5\in
  right-margin = 0.5\in
  indent = 0\mm

  %% between-system-space = 2.\cm
  %% between-system-padding = #0

  %%set to ##t if your score is less than one page:
  ragged-last-bottom = ##t
  ragged-bottom = ##f
  ragged-right = ##f

  markup-system-spacing = #'((basic-distance . 23)
                             (minimum-distance . 8)
                             (padding . 1))

  oddHeaderMarkup = \markup
  \fill-line {
    %% If not using the realBookTitle, can use
    %% \fromproperty #'header:title " "
    \title
    \if \should-print-page-number
    \fromproperty #'page:page-number-string
  }
  evenHeaderMarkup = \markup
  \fill-line {
    \if \should-print-page-number
    \fromproperty #'page:page-number-string " "
    \title
  }
}


\layout {
  %% This affects horizontal brackets that I'm using to highlight phrases.
  \context { \Lyrics \override LyricText.font-name = #"serif" }
  \context {
    \Voice
    \consists "Horizontal_bracket_engraver"
    \override HorizontalBracket.direction = #UP
    \override HorizontalBracket.thickness = 3.0
    \override HorizontalBracket.color = #red
  }
  \numericTimeSignature
}

global = {
  \numericTimeSignature
  \time 4/4
  \key c \major
  %% \tempo 4=224  % this would be over the clef on the first line

  %% make only the first clef visible
  \override Score.Clef.break-visibility = #'#(#f #f #f)

  %% make only the first time signature visible
  \override Score.KeySignature.break-visibility = #'#(#f #f #f)

  %% allow single-staff system bars
  \override Score.SystemStartBar.collapse-height = #1

  \set Score.rehearsalMarkFormatter = #format-mark-box-alphabet

  %% left justify rehearsal marks (centered by default)
  \override Score.RehearsalMark.self-alignment-X = #LEFT

  \override Score.MultiMeasureRest.expand-limit = 1

  %% See here for using colors
  %% http://lilypond.org/doc/v2.19/Documentation/notation/inside-the-staff#coloring-objects
  %% \override Score.RehearsalMark.color = #(x11-color "SlateBlue2")  % example using x11 colors
  \override Score.RehearsalMark.color = #darkred
  %% http://lilypond.org/doc/v2.19/Documentation/internals/rehearsalmark
  \override Score.RehearsalMark.font-size = 6

  %% uncomment this to have multibar, jazz style repeats. BUT, bar lines won't show when using "s" to fill in blanks
  %% \compressFullBarRests

  \set Score.rehearsalMarkFormatter = #format-mark-box-alphabet
}

%%%%%%%%%%%%%%%%%%%% Begin music

%% General structure:
%%
%% chordNames = \chordmode ...
%% notesMelody = ...
%% scaleDegrees = \lyrics ...
%%
%% Put it all together
%%
%% \score {
%%   <<
%%     \new ChordNames \chordNames
%%     \new Staff {
%%       \global
%%       \notesMelody
%%     }
%%     \scaleDegrees
%%   >>
%% }

%% Define line breaks globally
%% OPTIONAL, but can set all lines to be 4 bars wide
scoreBreaks = {
  \repeat unfold 2 { s1*4 \break }
}

%% Define the chords here. The same chords will be used for chord names and notes

%% 48 measures (3 x 16)
chordNamesHead = \chordmode {
  %% A
  c1:maj7 b:7 \repeat percent 2 {e:maj7}
  c1:maj7 b:7 \repeat percent 2 {e:maj7}
  ais:m7.5- a:m7 gis:m7 g:dim7
  fis:m7 b:7 \repeat percent 2 {e:maj7}

  %% A (2nd volta)
  c1:maj7 b:7 \repeat percent 2 {e:maj7}
  c1:maj7 b:7 \repeat percent 2 {e:maj7}
  ais:m7.5- a:m7 gis:m7 g:dim7
  fis:m7 b:7 e:maj7 d:7

  %% B
  g1:maj7 g:maj7 \repeat percent 2 {e:maj7}
  g1:maj7 g:maj7 \repeat percent 2 {e:maj7}
  ais:m7.5- a:m7 gis:m7 g:dim7
  fis:m7 b:7 \repeat percent 2 {e:6}
}

intro_partial_chords = \chordmode { s2 }
intro_partial= \relative c'' {
  \partial 2
  b4 b8 b~
}

leadMusic = \relative c'' {
  \bar ".|-|"
  \markManualBox "A"
  \timestop "0:16"
  b2 r2
  r2 \tuplet 3/2 {a4 gis fis}
  gis2 r2
  r2 b4 b8 gis
  \break

  \timestop "0:21"
  b4. b8 b4. r8
  r4 r4 \appoggiatura { g16 gis } \tuplet 3/2 { a4 gis! fis! }
  gis2 r
  r2 r4 r8 gis8
  \bar "|."
  \break

  \timestop "0:25"
  gis4 r4 r4 r8 gis8
  g?4 r r2
  r4 r8 fis8 \tuplet 3/2 { fis2 fis4 }
  \tuplet 3/2 { fis4 f e } \tuplet 3/2 { dis2 cis4 }
  \break

  \timestop "0:29"
  cis4 c8 b~ b2~
  b2 b'4 a8 gis
  b4 a8 gis b4 a8 b~
  b2 b4 b8 b~
  \bar "|."
  \break

  \markManualBox "A"
  \timestop "0:34"
  b2 r
  r2 \appoggiatura { g16 gis } \tuplet 3/2 {a4 gis! fis}
  gis2 r
  r4 r8 b8~ b4 b8 b~
  \break

  \timestop "0:38"
  b4. b8 b4. b8
  %% b4 a \tuplet 3/2 { a4 gis g }
  \tuplet 3/2 { c4 cis b } \tuplet 3/2 { a4 gis g }
  g4 gis gis2~
  gis2 r4 gis8 gis
  \bar "|."
  \break

  \timestop "0:42"
  gis4 r r r8 gis!8
  g!2~ g8 r8 r4
  r4 r8 fis8 fis4. fis8
  \tuplet 3/2 { fis4 f e }  dis4 cis
  \break

  \timestop "0:47"
  cis4 c8 b~ b2~
  b2 b'4 b8 b~
  b1
  b2 b4 b
  \bar "|."
  \break

  \markManualBox "B"
  \timestop "0:51"
  d1~
  d2 \appoggiatura g,8 \tuplet 3/2 { b4 a g }
  b4 b8 b~ b2~
  b2 b4. b8
  \break

  \timestop "0:55"
  d8 e4 d8 e4 d8 e~
  e8 d4 b8~ \tuplet 3/2 { b4 a g }
  b4 b8 b~ b2~
  b2 gis4. gis8
  \bar "|."
  \break

  \timestop "0:59"
  gis4 gis gis gis
  g?2~ g8 g4 g8
  fis4 fis fis fis
  fis8 f e dis'~ dis d cis4
  \break

  \timestop "1:03"
  b4 b8 b~ b2~
  b2 <<
    { e4 e8 e8~ e1 }
    { b'4 b8 b8~ b1 }
  >>
  r2 \tuplet 3/2 { b8 a gis } g4
  \bar "|."
  \break

  \bar ".|-|"
  \markManualBox "A"
  \timestop "1:08"

  b4. b8~ b2
  r1
  r4 b8 a b4 gis8 fis
  gis4 a8 gis a4 fis8 e
  \break

  \timestop "1:12"
  f?4 g8 fis g4 e8 dis
  e4 e8 d? dis4 dis8 d
  dis4 dis8 d cis4 dis8 d
  cis4 cis8 c b4 gis(
  \break \bar "|."

  \timestop "1:16"
  cis4) r8 c \tuplet 3/2 { cis8 e fis } \tuplet 3/2 { gis8 fis e }
  c?4 r r8 b16 c e4
  r4 b gis8 b r4
  r4 r8 b8 aes b des e~
  \break

  \timestop "1:21"
  e2 r2
  e8 fis gis e cis dis e4
  r1
  r1
  \break\bar "|."

  \markManualBox "A"
  \timestop "1:25"
  r4 r8 b8 e g c b~
  b4 \appoggiatura {bes16 aes} a4 \appoggiatura {gis16 e} gis!8 e dis b
  cis dis e r e cis' gis b
  f8 e g fis gis s4.

  \break

  \timestop "1:29"
  \repeat unfold 4 { s1 } \break \bar "|."
  \timestop "1:34"
  \repeat unfold 4 { s1 } \break
  \timestop "1:38"
  \repeat unfold 4 { s1 } \break\bar "|."

  \markManualBox "B"
  \timestop "1:42"
  \repeat unfold 4 { s1 } \break
  \timestop "1:47"
  \repeat unfold 4 { s1 } \break \bar "|."
  \timestop "1:52"
  \repeat unfold 4 { s1 } \break
  \timestop "1:56"
  \repeat unfold 4 { s1 } \break\bar "|."
}

myScore = \score {
  <<
    %% \new Lyrics \harmonicAnalysis  % add the harmonic harmonicAnalysis above the chord names
    %% \new ChordNames { \repeat unfold 1 \chordNamesHead }  % add the Chord Names above the staff
    \new ChordNames \with {
      \consists Percent_repeat_engraver
      \override PercentRepeat.Y-offset = 1
    }
    {
      %% \set chordChanges = ##f
      \intro_partial_chords
      \repeat unfold 2 { \chordNamesHead }

    }
    \new Staff {
      \global
      \intro_partial
      \leadMusic

    }
  >>
  \layout {
    indent = 0
  }
}

\myScore
