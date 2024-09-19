\version "2.24.0"

%% Checked against Bob Hartig transcription
%% https://stormhorn.com/2011/10/12/one-for-daddy-o-a-cannonball-adderley-solo-transcription/
%% I don't agree with all of his notes.

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
title = #"One for Daddy-O"
composer = #"Cannonball Adderly"
arranger = #"E\flat"
tagline = "Cannonball transcription 2024-09"
meter = "142"
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
  \key g \minor
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
  %% A, A

  %% \repeat unfold 2 {
  %%   %% m1-4 m13-16
  %%   g1:min6
  %%   c1:7
  %%   g1:min6
  %%   g2:min6 g:7.9+
  %%
  %%   %% m5-8 m17-20
  %%   c1:7
  %%   c1:7
  %%   g1min7
  %%   f2:min7 bes
  %%
  %%   %% m9-12 m21-24
  %%   ees2 d4:7 ees
  %%   ees8 d4.:7 ees4 d:7
  %%   g2:min7 e:7
  %%   a2:min7 d:7
  %% }
  %%
  %% %% Solo 1st chorus
  %% g1:min7
  %% a2:min7.5- d:7.9-
  %% g1:min7
  %% aes2:min7 g:7.9+.13-
  %%
  %% c1:min7
  %% c1:min7
  %% g1:min7
  %% f2:7 bes:7
  %%
  %% ees1:6
  %% d1:7.9-
  %% g1:m7
  %% a2:m7.5- d:7.9-
  %%
  %% %% Solo 2nd chorus
  %% g1:m7
  %% g1:m7
  %% g1:m7
  %% g1:7.9+.13-
  %%
  %% c1:m7
  %% c2:m7 d:7.9-
  %% g1:m7
  %% f2:m7 bes:7.9-
  %%
  %% ees1:7
  %% a2:m7 d:7.9-
  %% g1:m7
  %% a2:m7.5- d:7

  %% %% Solo 3rd chorus
  %% g1:m6
  %% g1:m6
  %% g1:m6
  %% g1:7.9+.13-
  %%
  %% c1:m7
  %% c1:m7
  %% g1:m7
  %% f2:m7 bes:7
  %%
  %% ees1:6
  %% a2:m7.5- d:7.9-
  %% g1:m6
  %% a2:m7.5- d:7
}

chordsMinorBluesBasic = \chordmode {
  %% Basic 12 bar minor blues
  g1:m7
  g1:m7
  g1:m7
  g1:m7

  c1:m7
  c1:m7
  g1:m7
  g1:m7

  a1:m7.5-
  d1:7.9- % V7alt?
  g1:m7
  a2:m7.5- d2:7.9-
}

chordsMinorBluesTritoneSub = \chordmode {
  %% Basic 12 bar minor blues
  g1:m7
  g1:m7
  g1:m7
  g1:m7

  c1:m7
  c1:m7
  g1:m7
  g1:m7

  ees1:m7
  d1:7.9- % V7alt?
  g1:m7
  ees2:m7 d2:7.9-
}

chordsMinorBluesSecondaryDom = \chordmode {
  %% Basic 12 bar minor blues
  g1:m7
  g1:m7
  g1:m7
  d2:m7.5- g:7.9-

  c1:m7
  c1:m7
  g1:m7
  g1:m7

  a1:m7
  d1:7.9- % V7alt?
  g1:m7
  a2:m7 d2:7.9-
}


%% intro_partial_chords = \chordmode { s2 }
%% intro_partial= \relative c'' {
%%   \partial 2
%%   r4 g8 c8~
%% }

intro_chords = \chordmode { s1 s1 }
intro_notes = \relative c''' {
  %% m1 (2 measures before chorus)
  \timestop "0:41"
  r8 bes16 g  c( d) d d  c( d) d d  c( d) d d
  c16( d) d d  c( d) d d  ees d \tuplet 5/2 { c16 bes a aes g } fis8 \tuplet 5/2 { f16 e ees d c }
}

solo = \relative c'' {
  \bar ".|-|"
  %% \markManualBox "Solo"

  %% m4
  \timestop "0:46"
  bes2 r8 bes' g16 d bes g \break
  ees'4. d16 c bes g ees d bes'4
  \appoggiatura { gis8 } a4 \appoggiatura { fis8 } g16 ees d c bes4 r4
  r4   r8 g''16 g    aes g f ees  d c bes aes
  \break

  %% m7
  \timestop "0:55"
  fis8 g aes16 ees d c f8 ees~ ees4
  r4 \tuplet 3/2 { d'16 ees d } c16 g bes16 g ees c~ c8 d16 a'
  r8. g16 a f d c bes8 \tuplet 5/2 { d16 e f g a } fis16 g bes d
  fis8 a16 fis g16 d bes g f'16 d ees f fis16 aes bes des
  \break

  %% m11
  \timestop "1:04"
  bes16 b c b32 bes a16 aes g ges f g aes? g f16 ees bes g
  e'8 s8 s2.
  \repeat unfold 2 { s1 } \break \bar "|."
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
      \intro_chords
      \repeat unfold 1 {\chordsMinorBluesBasic }
      %% \chordsMinorBluesBasic
      %% \chordsMinorBluesTritoneSub
      %% \chordsMinorBluesSecondaryDom
    }
    \new Staff {
      \global
      \intro_notes
      \markManualBox "Basic minor blues"
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
