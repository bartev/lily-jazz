\version "2.24.0"

%% See here for formatting text
%% https://lilypond.org/doc/v2.20/Documentation/notation/formatting-text

%% set to 18 to fit entire head and title on 1 page
#(set-global-staff-size 18)
\include "jazzchords.ily"
\include "lilyjazz.ily"
\include "jazzextras.ily"
\include "roman_numeral_analysis_tool.ily"

%% set up title, compser, meter, copyright
title = #"Green Dolphin St - write out C-8 bars"
composer = #"C - last 8 bars"
meter = "SET METER"
copyright = #"Bartev 2021-11 Green Dolphin St"
%% tagline = "Awesome transcription by Bartev"

%%%%%%%%%%%%%%%%%%%% Boilerplate - Setup Page, title, header, etc.

realBookTitle = \markup {
  \score {
    {
      \override TextScript.extra-offset = #'(0 . -4.5)
      s4
      s^\markup{
        \fill-line {
          \fontsize #1 \lower #1 \rotate #7 \concat { \note {4} #1 " = " #meter }
          \fontsize #7
          \override #'(offset . 7)
          \override #'(thickness . 6)
          \underline \larger #title
          \fontsize #1 \lower #1 \concat { #composer " " }
        }
      }
      s
    }
    \layout {
      \omit Staff.Clef
      \omit Staff.TimeSignature
      \omit Staff.KeySignature
    }
  }
}

\header {
  %% title = \realBookTitle
  copyright = \copyright
  %% tagline = ##f  % Remove default LilyPond tagline
	%% tagline = \tagline
}

\paper {
  #(set-paper-size "letter")
	top-margin = 0.5\in
  bottom-margin = 0.5\in
  left-margin = 0.5\in
  right-margin = 0.5\in
  indent = 0\mm

  between-system-space = 2.5\cm
  between-system-padding = #0

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

global = {
  \numericTimeSignature
  \time 4/4
  \key c \major
	%% \tempo 4=224  % this would be over the clef on the first line

	\override Score.Clef.break-visibility = #'#(#f #f #f) % make only the first clef visible
	\override Score.KeySignature.break-visibility = #'#(#f #f #f) % make only the first time signature visible
	\override Score.SystemStartBar.collapse-height = #1 % allow single-staff system bars
	\override Score.RehearsalMark.self-alignment-X = #LEFT  % left justify rehearsal marks (centered by default)
	\override Score.MultiMeasureRest.expand-limit = 1

	%% See here for using colors
	%% http://lilypond.org/doc/v2.19/Documentation/notation/inside-the-staff#coloring-objects
	%% \override Score.RehearsalMark.color = #(x11-color "SlateBlue2")  % example using x11 colors
	\override Score.RehearsalMark.color = #darkred
	%% http://lilypond.org/doc/v2.19/Documentation/internals/rehearsalmark
	\override Score.RehearsalMark.font-size = 6

	%% uncomment this to have multibar, jazz style repeats. BUT, bar lines won't show when using "s" to fill in blanks
	%% \compressEmptyMeasures
	
	\set Score.rehearsalMarkFormatter = #format-mark-box-alphabet
}

%%%%%%%%%%%%%%%%%%%% Functions

timestop = #(define-music-function
						 (parser location string)
						 (string?)
						 "colored markup (for timestamps)"
						 #{ <>^\markup \large \with-color #red #string #})

markManualBox = #(define-music-function
									(parser location string)
									(string?)
									"manually set a box mark that matches current color/size"
									#{ <>\mark \markup \box #string #})

markBlue = #(define-music-function
						 (parser location string)
						 (string?)
						 "blue markup string"
						 #{ <>\mark \markup \override #'(font-name . "lilyjazz-chord") \fontsize #-6 \with-color #blue #string #})

%%%%%%%%%%%%%%%%%%%% Begin music

%% Define line breaks globally
%% OPTIONAL, but can set all lines to be 4 bars wide
scoreBreaks = {
  \repeat unfold 2 { s1*4 \break }
}

%% Define the chords here. The same chords will be used for chord names and notes
chordNamesHead = \chordmode {
	d1:m7 b2:m7.5- e2:7.9- a1:m7 f2:m7.5- b2:7.9-
	e2:m7 a:7 d:m7 g:7 c1:6 d2:m7 g:7
}

scaleTones = \relative c' {
	d8 e f g a b c d
	b,16 \markBlue "Loc Nat 9" cis d e f g a b e,16 \markBlue "Mix -9 -13" f gis a b c d e
	a,8 b c d e fis g a
	fis,16 \markBlue "Loc Nat 9" gis a b c d e fis b,16 \markBlue "Mix -9 -13" c dis e fis g a b 
	\break
	e,,16 fis g a b cis d e a,16 b cis d e fis g a
	d,,16 e f g a b c d g,16 a b c d e f g
	c,,8 d e f g a b c
	d,16 e f g a b c d g,16 a b c d e f g 
}

justTheScales = \score {
	\header { piece = "Scales" subtitle = ##f }
	<<
		\new ChordNames { \repeat unfold 1 \chordNamesHead }  % add the Chord Names above the staff
		\new Staff { \global \scaleTones \bar "|."}
	>>
	\layout {
		indent = 0
	}
}

\justTheScales

firstSet = \relative c' { s1 \break s1 } 

firstSetScore = \score {
	\header { piece = "First Set" subtitle = ##f subsubtitle = ##f }
	<<
		%% \new ChordNames { \repeat unfold 1 \chordNamesHead }  % add the Chord Names above the staff
		\new Staff { \global \firstSet \bar "|."}
	>>
	\layout {
		indent = 0
	}
}

\firstSetScore

secondSet = \relative c' { s1 \break s1 }


secondSetScore = \score {
	\header { piece = "Second Set"  subtile = ##f }
	<<
		%% \new ChordNames { \repeat unfold 1 \chordNamesHead }  % add the Chord Names above the staff
		\new Staff { \global \secondSet \bar "|."}
	>>
	\layout {
		indent = 0
	}
}

\secondSetScore

thirdSet = \relative c' { s1 \break s1 }

thirdSetScore = \score {
	\header { piece = "Third Set" subtitle = ##f }
	<<
		%% \new ChordNames { \repeat unfold 1 \chordNamesHead }  % add the Chord Names above the staff
		\new Staff { \global \thirdSet \bar "|." }
	>>
	\layout {
		indent = 0
	}
}

\thirdSetScore


fourthSet = \relative c' { s1 \break s1 }

fourthSetScore = \score {
	\header { piece = "Fourth Set" subtitle = ##f }
	<<
		%% \new ChordNames { \repeat unfold 1 \chordNamesHead }  % add the Chord Names above the staff
		\new Staff { \global \fourthSet \bar "|." }
	>>
	\layout {
		indent = 0
	}
}

\fourthSetScore