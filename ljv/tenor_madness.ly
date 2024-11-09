\version "2.24.0"

%% Checked tenor madness against youtube video here
%% https://www.youtube.com/watch?v=MnZnZdENBGE

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
title = #"Tenor Madness"
composer = #"Sonny Rollins"
arranger = #"E\flat"
tagline = "Sonny Rollins transcription 2024-10"
meter = "180"
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
chordsMajorBluesBasic = \chordmode {
  %% Basic 12 bar minor blues
  g1:7 c1:7 g1:7 g1:7
  c1:7 c1:7 g1:7 g1:7
  a1:m7 d1:7 g1:7 d1:7
}

solo = \relative c'' {
  \bar ".|-|"
  \markManualBox "Solo"

  %% m4
  \timestop "2:12"

  %% m1
  r2 b4 g4
  b4 g4~ g2
  b8 g8~ g4 b8 g8~ g4
  r2 r8 d g bes~
  \break

  %% m5
  \timestop "2:17"
  bes8 bes g4 r2
  d'2 c16 bes a g~ g4
  b4 g4 r2
  r4 r8 fis8 g b d e
  \break

  %% m9
  \timestop "2:22"
  fis8 g e c b a d b
  c8 g e c bes'4 fis8 d
  a'8 fis d b e4 r4
  r4 r8 d \xNote b d g b
  \break \bar "||"
% \repeat unfold 3 { s1 } \break

  %% \repeat unfold 2 { s1*4 \break } \bar "||"
  %% m13
  \markManualBox "Chorus 2"
  \timestop "2:28"
  d8 d r b g4 r8 e'
  c4. a8 fis d r4
  r2 r8 f aes c
  e8 b d dis b aes g f
  \break

  %% m17
  \timestop "2:33"
  e4 g8 bes d bes c4
  bes8 g d4 d4 e8 cis
  d4 b r2
  r8 e16 f r8 g'8 r f r g
  \break

  \timestop "2:39"
  e4 d4 e2
  r8 d,16 ees r8 f' r ees! r f
  d4 c d2
  r2 r4 r8 a
  \break

  %% m25
  \markManualBox "Chorus 3"
  \timestop "2:44"
  d8 g a g e d a4
  r4 r8 \ottava -1 g e4. d8
  a4 r r r8 f
  e'8 d a c b bes' aes ees
  \break

  \timestop "2:50"
  g8 e \ottava 0 r4 r2
  r2 r4 r8 g'8
  r8 g r g g g r g
  fis a fis e r e d4
  \break

  \timestop "2:56"
  g2. g4
  fis4 fis c e
  d2 r4 r8 b
  d8 b c d b g e d
  \break

  \markManualBox "Chorus 4"
  \timestop "3:01"
  a'8 f r4 r8 des e16 g b d
  c8 g \xNote e g cis d e cis
  d8 b c c b4 r
  r2 r4 r8 e
  \break

  \timestop "3:07"
  r8 g r e a4 g
  ees4 b'8 a g ees? d c
  b8 e g e a g r d
  cis4 r8 g' a g r cis,?
  \break

  \timestop "3:12"
  c2 r
  b'8 a g16 a g e fis8 e d c
  b8 a g d fis g r4
  r2 r8 g \tuplet 6/2 { bes8 b c cis d dis }
  \break

  \markManualBox "Chorus 5"
  \timestop "3:18"
  e8 f~ f4 s2


  s1*3 \break
  \repeat unfold 2 { s1*4 \break } \bar "||"
  \repeat unfold 3 { s1*4 \break } \bar "||"

}

myScore = \score {
  <<
    %% \new Lyrics \harmonicAnalysis  % add the harmonic harmonicAnalysis above the chord names
    %% \new ChordNames { \repeat unfold 1 \chordNamesHead }  % add the Chord Names above the staff
    %% \pageBreak
    \new ChordNames \with {
      \consists Percent_repeat_engraver
      \override PercentRepeat.Y-offset = 1
    }
    {
      %% \set chordChanges = ##f
      %% \intro_chords
      \repeat unfold 5 {\chordsMajorBluesBasic }
      %% \chordsMinorBluesBasic
      %% \chordsMinorBluesTritoneSub
      %% \chordsMinorBluesSecondaryDom
    }
    \new Staff {
      \global
      %% \intro_notes
      %% \markManualBox "Basic minor blues"
      \solo

      %% \markManualBox "Minor blues, tritone sub"
      %% \solo
      %%
      %% \markManualBox "Minor Blues Secondary Dominant"
      %% \solo
    }
  >>
  \layout {
    indent = 0
  }
}

\myScore
