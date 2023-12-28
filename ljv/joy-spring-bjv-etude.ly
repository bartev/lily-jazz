\version "2.24.0"

%% See here for formatting text
%% https://lilypond.org/doc/v2.20/Documentation/notation/formatting-text

%% set to 18 to fit entire head and title on 1 page
#(set-global-staff-size 18)
\include "jazzchords.ily"
\include "lilyjazz.ily"
\include "jazzextras.ily"
\include "roman_numeral_analysis_tool.ily"
\include "bv_definitions.ily"

%% bv_definitions is in plugins/bv-lilyjazz/stylesheets.
%% It contains some useful functions such as:
%%   timestop
%%   markManualBox
%%   markBlue
%%   blueChord
%%   redChord
%%   greenChord

%% set up title, compser, meter, copyright
title = #"Joy Spring BJV Etude"
composer = #"Clifford Brown"
arranger = #"Bartev"
tagline = "Solo etude - lesson 2023-11"
meter = "160"
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
chordNamesHead = \chordmode {
  %% A
  g1:maj7
  a2:m7 d:7
  g1:maj7
  c2:m7 f:7

  b2:m7 bes:7
  a2:m7 d:7
  g1:maj7
  bes2:m7 ees:7

  %% B
  aes1:maj7
  bes2:m7 ees:7
  aes1:maj7
  cis2:m7 fis:7

  c2:m7 b:7
  bes2:m7 ees:7
  aes1:maj7
  b2:m7 e:7

  %% C
  a1:maj7
  a2:m7 d:7
  g1:maj7
  g2:m7 c:7

  f1:maj7
  bes2:m7 ees:7
  aes1:maj7
  a2:m7 d:7

  %% A
  g1:maj7
  a2:m7 d:7
  g1:maj7
  c2:m7 f:7

  b2:m7 bes:7
  a2:m7 d:7
  g1:maj7
  a2:m7 d:7
}

leadMusic = \relative c'' {
  \bar ".|-|"
  \markManualBox "A"
  r8 d c bes b c d fis
  g8 e~ e4 r2
  r8 g fis e d c b a
  bes8 ees, r ees4. d8 ees
  \break

  d8 e fis d f g aes f
  a8 b c a c d e fis
  g4 g b8 a g fis
  f8 ees f aes~ aes f ees c
  \break

  \markManualBox "B"
  des8 ees r4 r2
  r8 f ees des c bes aes g
  aes8 ees ees4~ ees r4
  r8 b'' a gis fis e dis cis
  \break

  bes'8 ees,~ ees4 fis a
  aes8 des,~ des4 ees g
  aes4 r ees2
  d,8 e fis e fis gis a b
  \break

  \markManualBox "C"
  cis8 a r8 e'4. r4
  r4 \tuplet 3/2 {g8 fis e} \tuplet 3/2 {fis e d} \tuplet 3/2 {e d c}
  b4 d,8 fis~ fis4 r4
  r8 g e f g a bes c
  \break

  d4 f8 a~ a4 r
  r8 bes aes g f ees d c
  ees4 g8 c,~ c4 r
  bes8 bes a a g g d e
  \break


  \markManualBox "A"
  fis8 fis r8 b~ b a gis fis
  g8 g r a~ a g fis e
  fis fis r d r2
  g8 g f ees~ ees f g a
  \break

  b8 d~ d4 r2
  c8 e~ e4 d8 fis~ fis4
  b4 a8 g fis d b g
  e'8 c a fis g4 r
  \bar "|."
}

etudeScore = \score {
  <<
    %% \new Lyrics \harmonicAnalysis  % add the harmonic harmonicAnalysis above the chord names
    %% \new ChordNames { \repeat unfold 1 \chordNamesHead }  % add the Chord Names above the staff
    \new ChordNames \chordNamesHead
    \new Staff {
      \global
      \leadMusic
    }
  >>
  \layout {
    indent = 0
  }
}

\etudeScore