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
title = #"SET MY TITLE"
composer = #"SET COMPOSER"
meter = "SET METER"
copyright = #"Bartev 2021-02"
tagline = "Awsome transcription by Bartev"

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
  title = \realBookTitle
  copyright = \copyright
  %% tagline = ##f  % Remove default LilyPond tagline
	tagline = \tagline
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
	\override Score.RehearsalMark.font-size = 8

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
						 #{ <>\mark \markup \override #'(font-name . "lilyjazz-chord") \with-color #blue #string #})

%%%%%%%%%%%%%%%%%%%% Begin music

%% Define line breaks globally
%% OPTIONAL, but can set all lines to be 4 bars wide
scoreBreaks = {
  \repeat unfold 2 { s1*4 \break }
}

%% Define the chords here. The same chords will be used for chord names and notes
chordNamesHead = \chordmode {
  c1:m7 f:7 bes bes
}

leadMusic= \relative c'' {
	\bar ".|-|"
	\mark \default
  c4 d e f
	\once \override Score.RehearsalMark.font-size = 0 
	\mark "A"
	c4 d
	\markmanualbox "A"
	e f
	\once \override Score.RehearsalMark.font-size = 4
	\mark \markup \with-color #(x11-color "LimeGreen") \box C
	%% \mark \markup \with-color #(x11-color "LimeGreen") \fontsize #3 \box C 
	c4 d e f
	\once \override Score.RehearsalMark.font-size = 8
	\mark \markup \with-color #(x11-color "LimeGreen") \box D 
	c4 d e f
	\bar "|."
	
	\mark \markup \with-color #darkred \box A
  c4 d e f
	\once \override Score.RehearsalMark.font-size = #0 
	\mark \markup \fontsize #3 \box B
	c4 d e f
	\once \override Score.RehearsalMark.font-size = #4
	\mark \markup \with-color #(x11-color "LimeGreen") \box C 
	c4 d e f
	\once \override Score.RehearsalMark.font-size = #8
	\mark \markup \with-color #(x11-color "LimeGreen") \box D 
	c4 d e f
	\bar "|."

	\override Score.RehearsalMark.font-size = 4
	\mark \markup \with-color #darkred \box A
  c4 d e f
	\once \override Score.RehearsalMark.font-size = #0 
	\mark \markup \fontsize #3 \box B
	c4 d e f
	\once \override Score.RehearsalMark.font-size = #4
	\mark \markup \with-color #(x11-color "LimeGreen") \box C 
	c4 d e f
	\once \override Score.RehearsalMark.font-size = #8
	\mark \markup \with-color #(x11-color "LimeGreen") \box D 
	c4 d e f
	\bar "|."

	\override Score.RehearsalMark.font-size = 8
	\mark \markup \with-color #darkred \box A
  c4 d e f
	\once \override Score.RehearsalMark.font-size = #0 
	\mark \markup \fontsize #3 \box B
	c4 d e f
	\once \override Score.RehearsalMark.font-size = #4
	\mark \markup \with-color #(x11-color "LimeGreen") \box C 
	c4 d e f
	\once \override Score.RehearsalMark.font-size = #8
	\mark \markup \with-color #(x11-color "LimeGreen") \box D 
	c4 d e f
	\bar "|."

	\inlineMMR R1*4
}
solo = \relative c'' {
	\bar ".|-|"

	%% do this to have multiple rehearsal marks in the same location
	%% https://lilypond.org/doc/v2.19/Documentation/snippets-big-page#editorial-annotations-how-to-print-two-rehearsal-marks-above-and-below-the-same-barline-_0028method-2_0029
	
	\once \override Score.RehearsalMark.extra-offset = #' (0 . 1)
	%% \once \override Score.RehearsalMark.baseline-skip = #9
	\mark \markup \center-column {
		\box A
		%% { \raise #2 \with-color #red \fontsize #1 \center-column {"Begin" "solo"} }
		{ \raise #2 \small \with-color #blue \center-column {"Begin" "solo"} }
	}	
	r8 e8 g c bes g e c
	\override Glissando.style = #'zigzag
	\timestop "0:11"
	bes4 \glissando g' bes e 
	\inlineMMR R1*2 
	\bar "|."
	\timestop "0.08"
	%% \mark \markup{\small \with-color #red "0:08"}
	\inlineMMR R1*4
	\inlineMMR R1*2

}

%% Add scale tones over each note
scaleDegrees = \lyrics {
	\markup \rN {1}4 \markup \rN {2}4 \markup \rN {3}4 \markup \rN {4}4
}

%% Add harmonic analysis
harmonicAnalysis = \lyricmode {
	\override LyricText.font-name = #"serif"
	\set stanza = \markup \with-color #red  \fontsize #6 \keyIndication { VI }
	\markup \rN { V 7 / I }1
	\markup \rN { V 7 / ii }1
	\set stanza = \markup \with-color #darkgreen \fontsize #5 \keyIndication { II }
	\markup \rN { V 7 }1
	\markup \rN { V 7 }1
}


%% Chord names, chord tones, and harmonic analysis only 
chordsAnalysisArpeg= {
	<<
		\new Lyrics \harmonicAnalysis
		\new ChordNames { \chordNamesHead }
		\new Staff {
			\global
			<<
				\scoreBreaks
				\chordNamesHead
			>>
		}
	>>
}

templateScore = \score {
	<<
		\new Lyrics \harmonicAnalysis  % add the harmonic harmonicAnalysis above the chord names
		\new ChordNames { \repeat unfold 2 \chordNamesHead }  % add the Chord Names above the staff
		\new Staff {
			\global
			%% the head 
			<<
				\repeat unfold 2 \scoreBreaks				
				\leadMusic
			>>
			%% Start the solo on a new page 
			\pageBreak
			<<
				\scoreBreaks
				\solo
			>>
		}
		\new Lyrics { \scaleDegrees }  % add the scaleDegrees below the staff
	>>
	\layout {
		indent = 0
	}
}

\chordsAnalysisArpeg

\pageBreak

\templateScore