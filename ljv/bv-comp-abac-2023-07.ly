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
title = #"Bartev's comp - ABAC"
composer = #"Bartev"
arranger = #"Bartev"
tagline = "There Will Never Be Another You changes"
meter = "125"
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
      ragged-last-bottom = ##f
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
  \key d \major
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
chordNamesHead = \chordmode {
  %% A
  d1:maj7
  d1:maj7
  cis1:m7.5-
  fis1:7

  b1:m7
  b1:m7
  a1:m7
  d1:7

  %% B
  g1:maj7
  c1:7.11+
  d1:maj7
  b1:m7

  e1:7
  e1:7
  e1:m7
  a1:7

  %% A
  d1:maj7
  d1:maj7
  cis1:m7.5-
  fis1:7

  b1:m7
  b1:m7
  a1:m7
  d1:7

  %% C
  g1:maj7
  c1:7.11+
  d1:maj7
  gis2:m7.5- cis:7

  d1:maj7
  fis2:m7 b:7
  e2:m7 a:7
  d2:6 a:7

}

leadMusic= \relative c'' {
	\bar ".|-|"
	\markManualBox "A"
  fis4. e8~ e4 fis~
  fis8 e8~ e4 fis e
  e4. d8~ d4 e4~
  e8 d8~ d4 e d
  \break

  d4. b8~ b4 d~
  d8 b8~ b4 d b
  a4. g8~ g4 fis~
  fis8 d8~ d4 e fis
  \bar "|."
  \break
  
  \markManualBox "B"
  g8 b r4 r2
  r1
  r2 a8 g r4
  fis'4. d8~ d4 r4
  \break
  
  r1
  r1
  r4 r8 g,8 fis e fis g
  r8 a8~ a4~ a8 g4.
  \bar "|."
  \break
  
	\markManualBox "A"
	fis4. e8~ e4 fis~
  fis8 e8~ e4 fis a
  b4. g8~ g4 e~
  e8 d4. dis4 e
  \break
  
  fis4 r4 r4 fis8 e
  fis4 r r8 fis e d
  e8 r r4 \tuplet 3/2 { r4 d e }
  \tuplet 3/2 { fis4 d r } r4 r8 d
  \bar "|."
  \break
  
	\markManualBox "C"
  e8 fis b r r4 r4
  g8 bes~ bes4 r r8 a8
  g8 fis a r r2
  fis8 gis~ gis4 r2
  \break

  fis8 a cis e r2
  fis,8 a fis cis' r2
  g8 b g d' r2
  fis8 d cis a r2
	\bar "|."
  \break
}

bv-abac-comp = \score {
	<<
		%% \new Lyrics \harmonicAnalysis % add the harmonic harmonicAnalysis above the chord names
		\new ChordNames \chordNamesHead % add the Chord Names above the staff
		\new Staff {
			\global
			%% the head
      \leadMusic
    }
		%% \new Lyrics { \scaleDegrees }  % add the scaleDegrees below the staff
	>>
	\layout {
		indent = 0
	}
}

%% \chordsAnalysisArpeg
%% \pageBreak

\bv-abac-comp