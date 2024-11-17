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
title = #"Inner Urge - BV Solo"
composer = #""
arranger = #"E\flat"
tagline = "Bartev 2024-10"
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

%% Define the chords here. The same chords will be used for chord names and notes
chordNames = \chordmode {
  %% A
  dis1:m7.5- dis1:m7.5- dis1:m7.5- dis1:m7.5-
  d1:maj7.11+ d1:maj7.11+ d1:maj7.11+ d1:maj7.11+
  c1:maj7.11+ c1:maj7.11+ c1:maj7.11+ c1:maj7.11+
  bes1:maj7.11+ bes1:maj7.11+ bes1:maj7.11+ bes1:maj7.11+
  %% B
  cis1:maj7.11+ bes1:maj7.11+ b1:maj7.11+ aes1:maj7.11+
  a1:maj7 fis1:maj7 g1:maj7 e1:maj7
}

solo = \relative c' {
  \bar ".|-|"
  \markManualBox "Scales"
  dis8 e fis gis a b cis dis
  e dis cis b a gis fis e
  s1
  s1
  \break
  d8 e fis gis a b cis d
  e d cis b a gis fis e
  s1 s1
  \break
  c8 d e fis g a b c
  d c b a g fis e d
  s1
  s1
  \break
  bes8 c d e f g a bes
  c bes a g f e d c
  s1
  s1
  \break
  cis'8 dis eis fisis gis ais bis cis
  bes,8 c d e! f g a bes
  b,8 cis dis eis fis gis ais b
  aes,8 bes c d ees f g aes
  \break
  a,4 cis e fis
  fis,4 ais cis eis
  g,4 b d fis
  e,4 gis b dis
  \break
  \bar "||"
  \pageBreak
  \markManualBox "Solo"
  cis,8 dis e fis gis a b fis'
  dis4. b8 dis dis r4
  r2 r4 r8 dis
  fis8 e dis b a gis fis e
  \break
  d4~ d8 e fis a b d~
  d8 d8~ d4 r2
  r4 d8 d fis d~ d4
  b4 a8 gis a b fis4
  \break

  e4. fis8 g a b fis'
  r8 e4. r4 r
  e8 g fis d e b a b~
  b2 r
  \break
  \repeat unfold 3{ s1*4 \break } \bar "||"

  \pageBreak
  fis'8 dis e fis dis cis b cis
  dis2 r8 b cis dis
  e8 fis cis' b a4 b8 fis?~
  fis?2 r8 cis d? e
  \break
  fis2 r8 cis d e
  gis8 cis, d e a cis, d e
  cis'2 r8 b, cis d
  fis e b cis e d a b
  \break
  c?2 r8 fis e b
  c8 a b g e' c d b
  a8 fis g a b cis e4
  g8 d~ d4 fis8 c~ c4
  \break
  r8 b bes c a f g a
  bes4 c d e8 d~
  d4 f r2
  r1
  \break
  r1
  bes8 a e f a4 r
  r1
  r1
  \break
  \repeat unfold 1 { s1*4 \break } \bar "||"
  \pageBreak


  \repeat unfold 6 { s1*4 \break } \bar "||"
  %% \repeat unfold 6 { s1*4 \break } \bar "||"

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
      \repeat unfold 4 {\chordNames}
    }
    \new Staff {
      \global
      \solo
    }
  >>
  \layout { indent = 0 }
}

\myScore
