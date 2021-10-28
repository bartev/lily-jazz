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
title = #"Rhythm Changes Solo"
composer = #"Bartev"
meter = "120"
copyright = #"Bartev 2021-09-09"
tagline = "Awsome solo by Bartev"

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
	\key g \major
	%% \tempo 4=224  % this would be over the clef on the first line

	\override Score.Clef #'break-visibility = #'#(#f #f #f) % make only the first clef visible
	%% \override Score.KeySignature #'break-visibility = #'#(#f #f #f) % make only the first time signature visible
	\override Score.SystemStartBar #'collapse-height = #1 % allow single-staff system bars
	\override Score.RehearsalMark.self-alignment-X = #LEFT  % left justify rehearsal marks (centered by default)
	\override Score.MultiMeasureRest.expand-limit = 1

	\override Score.RehearsalMark.color = #darkred
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

																% scd = #(define-music-function
																% 				(parser location string num)
																% 				(string? number?)
																% 				#{ \markup \scaleDegree{#1}#0 })

%%%%%%%%%%%%%%%%%%%% Begin music

%% Define line breaks globally
%% OPTIONAL, but can set all lines to be 4 bars wide
scoreBreaks = {
	%% each section is 8 bars
	%% there are 4 sections in the score (AABA)
	\repeat unfold 4 { s1*4 \break  s1*4 \break }
}

%% Define the chords here. The same chords will be used for chord names and notes
chordNamesHead = \chordmode {
	%% A
	%% \mark \markup \with-color #(x11-color 'NavyBlue) \fontsize #1 \box A
	\markManualBox "A"
	g2:maj7 e:7
	a2:m7 d:7
	b2:m7 e:7
	a2:m7 d:7

	d2:m7 g:7
	c2:7 f:7
	b2:m7 e:7
	a2:m7 d:7

	%% A
	\markManualBox "A"

	g2:maj7 e:7
	a2:m7 d:7
	b2:m7 e:7
	a2:m7 d:7

	d2:m7 g:7
	c2:7 f:7
	a2:m7 d:7  % last 2 bars are different 2nd time around
	g1:6

	%% B
	\markManualBox "B"
	b1:7 b1:7
	e1:7 e1:7

	a1:7 a1:7
	d1:7 d1:7

	%% A
	\markManualBox "A"
	g2:maj7 e:7
	a2:m7 d:7
	b2:m7 e:7
	a2:m7 d:7

	d2:m7 g:7
	c2:7 f:7
	a2:m7 d:7
	g1:6

}


solo = \relative c'' {
	\bar ".|"

	\once \override Score.RehearsalMark.extra-offset = #' (0 . 1)

																% \mark \markup \center-column {
																%		\box A
																%		{ \raise #4 \with-color #blue \small \center-column {"Begin" "solo"} }
																% }
	\markManualBox "A"
	<>^\markup { \raise #4 \with-color #blue \small "Begin solo" }
	e8 d b'4~ b r
	c8 a g e fis g a g
	fis d~ d4. r8 r4
	e8 d e4 fis8 e fis4
	\break
	
	a8 f d a b g' f d
	e4 r r8 g8 e cis
	d8 fis b a gis4 r4
	c,8 e a g fis d~ d4
	\break
	
	\markManualBox "A"
	r2 r8 a'8 bes b
	c8 a g e fis a d, fis
	a,8 d~ d4 a8 g gis b
	d8 e~ e4 r2
	\break
	
	b8 d c b d4 r
	c8 e d c ees4 r
	r8 dis (d) d8 (c) c (b) d,8~
	d2 r2
	\break
	
	\markManualBox "B"
	r8 fis' a fis dis b fis r
	r8 dis' fis dis b fis dis r
	r8 b'8 d b gis d b' gis~
	gis4 r4 r2
	\break

	cis8 e g b a g~ g4
	a,8 cis e g fis e~ e4
	fis,8 a c e d c~ c4
	b8 a~ a fis~ fis4 r4
	\break
	
	\markManualBox "A"
	r4 r8 b'16 a \tuplet 3/2 {b4 gis e}
	e4. fis8~ fis4 r4
	r4 r8 b16 a \tuplet 3/2 {b4 gis e}
	e8 g a c d c a fis
	\break

	f8 e d f b a g b
	c8 bes a g f ees d ees
	e8 fis g a b a g fis
	e4. d8~ d2
	
	\bar "|."
	}


%% Add harmonic analysis (chords)
harmonicAnalysis = \lyricmode {
	\override LyricText #'font-name = #"serif"

	%% A
	\markup \rN { I }2 \markup \rN { VI7 }2
	\markup \rN { ii - 7 }2 \markup \rN { V 7 }2
	\markup \rN { iii - 7 }2 \markup \rN { VI 7 }2
	\markup \rN { ii - 7 }2 \markup \rN { V 7 }2

	\set stanza = \markup \with-color #red \fontsize #6 \keyIndication { IV }
	\markup \rN { ii-7 / IV }2 \markup \rN { V7 / IV }2
	\markup \rN { V7 /  fVII }2  \markup \rN { V7 /  fiii }2
	\set stanza = \markup \with-color #red \fontsize #6 \keyIndication { I }
	\markup \rN { iii - 7 }2 \markup \rN { VI 7 }2
	\markup \rN { ii - 7 }2 \markup \rN { V 7 }2

	%% A (modified)
	\markup \rN { I }2 \markup \rN { VI7 }2
	\markup \rN { ii - 7 }2 \markup \rN { V 7 }2
	\markup \rN { iii - 7 }2 \markup \rN { VI 7 }2
	\markup \rN { ii - 7 }2 \markup \rN { V 7 }2

	\set stanza = \markup \with-color #red \fontsize #6 \keyIndication { IV }
	\markup \rN { ii-7 / IV }2 \markup \rN { V7 / IV }2
	\markup \rN { V7 /  fVII }2  \markup \rN { V7 /  fiii }2
	\set stanza = \markup \with-color #red \fontsize #6 \keyIndication { I }
	\markup \rN { ii - 7 }2 \markup \rN { V 7 }2
	\markup \rN { I6 }1

	%% B
	\set stanza = \markup \with-color #red \fontsize #6 \keyIndication { VI }
	\markup \rN { V7 / VI }1
	\markup \rN { V7 / VI }1
	\set stanza = \markup \with-color #red \fontsize #6 \keyIndication { ii }
	\markup \rN { V7 / ii }1
	\markup \rN { V7 / ii }1
	\set stanza = \markup \with-color #red \fontsize #6 \keyIndication { V }
	\markup \rN { V7 / V }1
	\markup \rN { V7 / V }1
	\set stanza = \markup \with-color #red \fontsize #6 \keyIndication { I }
	\markup \rN { V7 / I }1
	\markup \rN { V7 / I }1

	%% A (modified)
	\markup \rN { I }2 \markup \rN { VI7 }2
	\markup \rN { ii - 7 }2 \markup \rN { V 7 }2
	\markup \rN { iii - 7 }2 \markup \rN { VI 7 }2
	\markup \rN { ii - 7 }2 \markup \rN { V 7 }2

	\set stanza = \markup \with-color #red \fontsize #6 \keyIndication { IV }
	\markup \rN { ii-7 / IV }2 \markup \rN { V7 / IV }2
	\markup \rN { V7 /  fVII }2  \markup \rN { V7 /  fiii }2
	\set stanza = \markup \with-color #red \fontsize #6 \keyIndication { I }
	\markup \rN { ii - 7 }2 \markup \rN { V 7 }2
	\markup \rN { I6 }1

}


%% Chord names, chord tones, and harmonic analysis only
chordsAnalysisArpeg= {
	<<
		%% \new Lyrics \harmonicAnalysis
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

bvSoloScore = \score {
	<<
		%% \new Lyrics { \harmonicAnalysis }  % add the harmonic harmonicAnalysis above the chord names
		\new ChordNames { \chordNamesHead }  % add the Chord Names above the staff
		\new Staff {
			\global
			\solo
		}

	>>
	\layout {
		indent = 0
	}
}

%% \chordsAnalysisArpeg
%% \pageBreak

\bvSoloScore