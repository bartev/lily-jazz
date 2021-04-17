\version "2.20.0"

%% See here for formatting text
%% https://lilypond.org/doc/v2.20/Documentation/notation/formatting-text

%% set to 18 to fit entire head and title on 1 page
#(set-global-staff-size 18)
\include "jazzchords.ily"
\include "lilyjazz.ily"
\include "jazzextras.ily"
\include "roman_numeral_analysis_tool.ily"

%% set up title, compser, meter, copyright
title = #"Cousin Mary"
composer = #"Coltrane"
meter = "SET METER"
copyright = #"Bartev 2021-04-17"
tagline = "Awsome transcription by Bartev"

%%%%%%%%%%%%%%%%%%%% Boilerplate - Setup Page, title, header, etc.

realBookTitle = \markup {
  \score {
    {
      \override TextScript.extra-offset = #'(0 . -4.5)
      s4
      s^\markup{
        \fill-line {
          \fontsize #1 \lower #1 \rotate #7 \concat { \note #"4" #1 " = " #meter }
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
		\on-the-fly #print-page-number-check-first
		\fromproperty #'page:page-number-string
	}
  evenHeaderMarkup = \markup
	\fill-line {
		\on-the-fly #print-page-number-check-first
		\fromproperty #'page:page-number-string " "
		\title
	}
}

global = {
  \numericTimeSignature
  \time 4/4
  \key f \major
	%% \tempo 4=224  % this would be over the clef on the first line

	\override Score.Clef #'break-visibility = #'#(#f #f #f) % make only the first clef visible
	\override Score.KeySignature #'break-visibility = #'#(#f #f #f) % make only the first time signature visible
	\override Score.SystemStartBar #'collapse-height = #1 % allow single-staff system bars
	\override Score.RehearsalMark.self-alignment-X = #LEFT  % left justify rehearsal marks (centered by default)
	\override Score.MultiMeasureRest.expand-limit = 1

	%% See here for using colors
	%% http://lilypond.org/doc/v2.19/Documentation/notation/inside-the-staff#coloring-objects
	%% \override Score.RehearsalMark.color = #(x11-color "SlateBlue2")  % example using x11 colors
	\override Score.RehearsalMark.color = #darkred
	%% http://lilypond.org/doc/v2.19/Documentation/internals/rehearsalmark
	\override Score.RehearsalMark.font-size = 6

	%% uncomment this to have multibar, jazz style repeats. BUT, bar lines won't show when using "s" to fill in blanks
	%% \compressFullBarRests
	
	\set Score.markFormatter = #format-mark-box-alphabet
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
						 #{ <>\mark \markup \fontsize #-6 \with-color #blue #string #})

%%%%%%%%%%%%%%%%%%%% Begin music

%% Define line breaks globally
%% OPTIONAL, but can set all lines to be 4 bars wide
scoreBreaks = {
  \repeat unfold 3 { s1*4 \break }
}

%% Define the chords here. The same chords will be used for chord names and notes
chordNamesHead = \chordmode {
	f1:7 f1:7 f1:7 f1:7
	bes:7 bes:7 f1:7 f1:7
	b:7 bes:7 f1:7 f1:7 
}

leadMusicC = \relative c'' {
	\bar ".|"
	%% \mark \default
	\markManualBox "Head"
  r4 ees ges4. ees8~
	ees1
	r4 ees ges4. ees8~
	ees1

	r4 ees ges4. aes8~
	aes1
	r4 ees ges4. ees8~
	ees1

	r8 aes ges aes~ aes4 ges8 aes~
	aes4. ges8 ees4 des
	r4 ees ges4. ees8~
	ees1
}
solo = \relative c''' {
	\bar ".|"

	%% do this to have multiple rehearsal marks in the same location
	%% https://lilypond.org/doc/v2.19/Documentation/snippets-big-page#editorial-annotations-how-to-print-two-rehearsal-marks-above-and-below-the-same-barline-_0028method-2_0029
	
	%% \once \override Score.RehearsalMark.extra-offset = #' (0 . 1)
	%% \once \override Score.RehearsalMark.baseline-skip = #9
																% \mark \markup \center-column {
																% 	\box A
																% 	%% { \raise #2 \with-color #red \fontsize #1 \center-column {"Begin" "solo"} }
																% 	{ \raise #2 \small \with-color #blue \center-column {"Begin" "solo"} }
																% }
	\markManualBox "1"
	\timestop "0:26"
	g1~
	g8 f g f~ f ees f ees~
	ees c ees c~ c4 r4
	r4 r8 g'8~ g2~

	\timestop "0:30"
	g8 f16 g \markBlue "Hang back" f8 ees d c bes a
	aes8 bes c ees g ees c bes
	\timestop "0:33"
	c b c d ees d ees f
	g bes g ees r8 ees c r
	
	\timestop "0:35"
	ees8 c g4 b2
	c8 bes aes g~ g2
	bes8 c~ c2 r4
	r4 r8 aes'8~ aes4. bes8

	\markManualBox "2"
	\timestop "0:39"
	a8 f r ees~ ees g~ g4~
	g4 f8 d bes r r4
	r4 r8 f'~ f4~ f8 e
	ees8 f g bes a g f e

	\timestop "0.44"
	ees8 c bes a aes bes c ees
	g8 bes a g r f d bes
	c bes c d ees f g f~
	f2 s2

	\timestop "0.48"
	s1*4

	\pageBreak
	
	\markManualBox "3"
	\timestop "0.53"
	s1*4
	\timestop "0.57"
	s1*4
	\timestop "1:01"
	s1*4

	\markManualBox "4"
	s1*4
	s1*4
	s1*4

	\markManualBox "5"
	s1*4
	s1*4
	s1*4

}

%% Add scale tones over each note
scaleDegrees = \lyrics {
	\markup \rN {1}4 \markup \rN {2}4 \markup \rN {3}4 \markup \rN {4}4
}

%% Add harmonic analysis
harmonicAnalysis = \lyricmode {
	\override LyricText #'font-name = #"serif"
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
		%% \new Lyrics \harmonicAnalysis  % add the harmonic harmonicAnalysis above the chord names
		\new ChordNames { \repeat unfold 2 \chordNamesHead}  % add the Chord Names above the staff
		\new Staff {
			\global
			%% the head 
			<<
				\scoreBreaks
				
				\transpose ees c \leadMusicC
			>>
			%% Start the solo on a new page 
			%% \pageBreak
			<<
				\repeat unfold 4 \scoreBreaks
				%%				\new ChordNames { \repeat unfold 2 \chordNamesHead }
				\solo
			>>
		}
		%% \new Lyrics { \scaleDegrees }	% add the scaleDegrees below the staff
	>>
	\layout {
		indent = 0
	}
}

																% \chordsAnalysisArpeg
																% \pageBreak

\templateScore