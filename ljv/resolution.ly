\version "2.24.0"

%% Checked against Bobby Stern Jazz transcription
%% https://bobbysternjazz.com/uploads/3/4/4/5/34450459/night___day_-_joe_henderson_transcription__bb__bsj.pdf

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
title = #"Resolution - A Love Supreme Part II"
composer = #"John Coltrane"
arranger = #"E\flat"
tagline = "John Coltrane transcription 2024-04"
meter = "120"
copyright = #"Bartev 2024"

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
  \key c \minor
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
  \repeat unfold 3 {
    \repeat percent 2 { c1:min7 }
    c2:min7 aes:sus7
    aes1:sus7

    \repeat percent 2 { d1:7.5+ }
    d1:sus9-
    c2:min7 g:7.5+
  }

  %% B
  \repeat percent 4 { c1:min7 }
  \repeat percent 4 { c1:min7 }
  \repeat percent 4 { c1:min7 }
  \repeat percent 4 { c1:min7 }

}

%% intro_partial_chords = \chordmode { s2 }
%% intro_partial= \relative c'' {
%%   \partial 2
%%   r4 g8 c8~
%% }

leadMusic = \relative c''' {
  \bar ".|-|"
  \markManualBox "A"
  \timestop "0:22"
  \appoggiatura { g8 } c1~
  %% g8 c~ c4~ c2~
  c2 g8 c bes aes
  g4. fis8~ fis2~
  fis2 r4 r8 f16 fis
  \break

  \timestop "0:27"
  f1~
  f8 ees d ees d c b g
  ees'8 \parenthesize c ees ees c4 bes8 c~
  c2 r2
  \bar "|."
  \break

  \timestop "0:33"
  \appoggiatura { g'8 } c1~
  c2 g8 c bes aes
  g4 bes8 fis~ fis2~
  fis2 r4 r8 fis8
    \break

  \timestop "0:38"
  f16 fis f8~ f4~ f2~
  f8 ees d ees d c b bes
  b2 aes8 ees f4~
  f2 r2
  \bar "|."
  \break

  \timestop "0:44"
  \appoggiatura { g'8 } c1~
  c2 g8 c bes aes
  g4 g8 fis~ fis2~
  fis2 r4 r8 f16 fis
  \break

  \timestop "0:49"
  f2~ f8 ees d ees
  d4~ d8 c b aes bes4~
  bes4 g8 bes fis4 bes,8 c8~
  c2 r4 g''8 bes
  \break

  \markManualBox "Bridge"
  \timestop "0:55"
  bes8 g c r f,4 r

  \repeat unfold 3 { s1 } \break
  \repeat unfold 4 { s1 } \break \bar "|."
  \repeat unfold 4 { s1 } \break
  \repeat unfold 4 { s1 } \break\bar "|."
  \repeat unfold 4 { s1 } \break
  \repeat unfold 4 { s1 } \break \bar "|."
  \repeat unfold 4 { s1 } \break
  \repeat unfold 4 { s1 } \break \bar "|."
  \repeat unfold 4 { s1 } \break
  \repeat unfold 4 { s1 } \break \bar "|."
  \repeat unfold 4 { s1 } \break
  \repeat unfold 4 { s1 } \break \bar "|."
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
      %% \intro_partial_chords
      \repeat unfold 1 { \chordNamesHead }

    }
    \new Staff {
      \global
      %% \intro_partial
      \leadMusic

    }
  >>
  \layout {
    indent = 0
  }
}

\myScore
