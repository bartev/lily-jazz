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
title = #"Have Yourself a Merry Little Christmas"
composer = #"Hugh Martin"
arranger = #""
tagline = ""
meter = "80"
copyright = #""

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
      ragged-last-bottom = ##f
    }
  }
}

\header {
  title = \realBookTitle
  %% tagline = \tagline
  %% copyright = \copyright
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
  ragged-last-bottom = ##f
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
  \key f \major
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
  f1:9
  bes2:9 g:m
  f2 d:m
  bes2 c

  f2 d:m
  g2:m7 c:7
  a2:m7 d:m7
  g2:m7 c2:7sus4

  f2 d:m7
  g2:m c
  f2 d:m7
  bes2:9 c

  f2 d:m7
  g2:m a:7
  d2:m f
  g2:m c

  bes2:maj7 bes:m7+
  f1:9
  g2:m7 c:7sus4
  a1:m

  cis2:dim7 e:7
  a1:m
  g1:sus4
  c2 c:7

  f2:9 d:m7
  g2:m c:7
  f2 d:m
  g4:m bes c2:maj7

  f2 d:m
  g2:m7 c4 c:7
  d2:m7.9 f
  bes2 c:maj7

  g2:m7 c:7
  g2:m c
  bes2:9 c
  f1

  f1
  f1
}

leadMusic= \relative c' {
	\bar ".|-|"
	%% \mark \default
  f4 a c f
  c8 bes a g f4 g
  f4 a c f
  c4 r2.
  \break

  a4 c f a
  g8 f e d c4 bes
  a4 r2.
  r1
  \break

  f4 a c f
  c8 bes a g f4 g
  f4 a c f
  c4 r2.
  \break

  a4 c f a
  bes8 a g f e4 g
  a4 r2.
  r1
  \break

  a4 a a g8 f
  e8 f g4 r f8 e
  d8 e f4 r e
  e1
  \break

  f4 f f e8 d
  c8 d e2 c8 d
  e8 f g2 g,4
  c2 r
  \break

  f,4 a c f
  c8 bes a g f4 g
  f4 a c f
  c4 r2.
  \break

  c4 f a a
  bes8 a g f e4 g
  a8 r r2.
  r2 r4 a
  \break
  
  a4 bes, d f
  a8 g f e d4 e
  f2~f~
  f8 r r4 r2
  %% \break

  c'8 c c4 c8 c c4
  c8 f a,4 bes16 c8. ~c4
  \bar "|."
}

text = \lyricmode {
  Have your- self a mer- ry lit- tle Christ- mas Let your heart be light.

  From now on our trou- bles will be out of sight.
  
  Have your- self a mer- ry lit- tle Christ- mas; Make the yule- tide gay.

  From now on our troub- les will be miles a- way.

  Here we are as in old- en days, hap- py gol- den days of yore;

  Faith- ful friends who are dear to us gath- er near to us once more.

  Through the years we'll al- ways be to- geth- er.

  If the fates al- low.

  Hange a shin- ing star up- on the high- est bough.
  
  And have your- self a mer- ry lit- tle Christ- mas now.
}

myscore = \score {
  <<
    \context ChordNames { \chordNamesHead }
    \new Staff {
      \global
      \leadMusic
      \addlyrics \text
    }
  >>
  \layout { indent = 0 }
}

myscoreEb = \score {
  \transpose ees c {
  <<
    \context ChordNames { \chordNamesHead }
    \new Staff {
      \global
      \leadMusic
      \addlyrics \text
    }
  >>
  }
  \layout { indent = 0 }
}

myscoreBb = \score {
  \transpose bes c' {
  <<
    \context ChordNames { \chordNamesHead }
    \new Staff {
      \global
      \leadMusic
      \addlyrics \text
    }
  >>
  }
  \layout { indent = 0 }
}

\myscore
%% \myscoreEb
%% \myscoreBb

