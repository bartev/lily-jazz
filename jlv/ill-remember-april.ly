\version "2.24.0"

%% See here for formatting text
%% https://lilypond.org/doc/v2.20/Documentation/notation/formatting-text

%% set to 18 to fit entire head and title on 1 page
#(set-global-staff-size 18)
\include "jazzchords.ily"
\include "lilyjazz.ily"
\include "jazzextras.ily"
\include "roman_numeral_analysis_tool.ily"
%% bv_definitions is in plugins/bv-lilyjazz/stylesheets.
%% It contains some useful functions such as:
%% timestop
%%   markManualBox
%%   markBlue
%%   blueChord
%%   redChord
%%   greenChord
\include "bv_definitions.ily"

%% set up title, compser, meter, copyright
title = #"I'll Remember April"
composer = #"Stan Getz solo"
arranger = #"Stan Meets Chet (1958)"
meter = "220"
%% instrument = \instrumentAlto
instrument = \instrumentTenor

transcribed = #"Bartev 2026-04"
tagline = "Awesome transcription by Bartev"
copyright = #"Bartev 2026"

%% Paper & Layout settings are in `realbook_layout`
%% Import AFTER setting `title`
%% It defines the realbook title line based on definitions above
\include "realbook_layout.ily"

global = {
  \numericTimeSignature
  \time 4/4
  \key a \major
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
%% introTenor = \relative c' {
%%   \partial 2
%%   r8 d g d'~
%% }
%%
%% \score {
%%   <<
%%     \new ChordNames {
%%       \chordsIntro
%%       \repeat unfold 2 \chordChanges
%%     }
%%     \new Staff {
%%       \new Voice = "soloist" {
%%         %% Your music notation here
%%         \global
%%         \introTenor
%%         \melodyTenor
%%       }
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
	a1:maj7 a:6 a:maj7 a:6
	a1:m7 a1:m6 a1:m7 a1:m6
	b1:m7.5- e:7.9- cis:m7.5- fis:7.9-
	b1:m7 e:7 \repeat percent 2 {a:maj7}

	d1:m7 g:7 c:maj7 a:m7
	d1:m7 g:7 \repeat percent 2 {c:maj7}
	b1:m7 e:7 \repeat percent 2 {a:maj7}
	gis1:m7 cis:7 fis:maj7 b2:m7 e:7

	a1:maj7 a:6 a:maj7 a:6
	a1:m7 a1:m6 a1:m7 a1:m6
	b1:m7.5- e:7.9- cis:m7.5- fis:7.9-
	b1:m7 e:7 a:maj7 b2:m7 e:7
}

leadMusic= \relative c'' {
	\bar ".|-|"
	\markManualBox "A"
	\timestop "0:15"
	% m1
	r4 cis d e
	d4. cis8 b4 a
	b2. a4
	gis4 fis2.

	% m5
	\timestop "0:19"
	r4 b c d
	c4. b8 a4 g
	a8 b a2.~
	a2 r2

	% m9
	\timestop "0:24"
	r2 b
	b4 r r8 cis d r
	r2 e2
	e4. r8 fis4. e8

	% m13
	\timestop "0:28"
	cis8 cis d d e e d4
	b2 cis
	e,8 e r e fis fis r fis
	gis8 gis r fis~ fis4. fis8
	\bar "||"


	% m17
	\markManualBox "B"
	\timestop "0:32"
	\bar ".|"
	a1
	r2 \xNote a8 b c d
	e2. r8 d
	c4 b8 c~ c8 b bes a~

	% m21
	\timestop "0:36"
	a1
	r4 b8 g a b c d
	ees8 e ees e c g e ees
	e8 c'~ c2 r4

	% m25
	\timestop "0:40"
	r2 e2~
	e8 fis~ fis4 d4. e8
	cis4. cis8~ cis2
	r8 cis c cis e ees d e

	% m29
	\timestop "0:45"
	cis8 cis4. cis4 cis8 r
	cis8 r cis r16 cis e4 d
	cis2. r8 cis
	b8 cis b e r d cis4

	% m33
	\markManualBox "A"
	\timestop "0:50"
	\bar "|."
	e,4 cis' d e
	e,4 cis' d e
	a4 e d cis
	r4 e, cis' d

	%% m37
	\timestop "0:54"
	e4 e, b' c
	r4 e, b' c
	e4 e, b' c
	r4 e, a bes

	%% m41
	\timestop "0:58"
	b2 b
	b4 r b8 cis d dis
	e4. cis8 a4 gis
	g2 fis'4. e8

	%% m45
	\timestop "1:02"
	cis8 cis d4 e d
	r2 r4 e8 fis
	gis8 a fis d b e, fis a
	gis8 e' c c a e fis4
}

solo = \relative c'' {
	\bar ".|"
	\once \override Score.RehearsalMark.extra-offset = #' (0 . 1)
	%% \once \override Score.RehearsalMark.baseline-skip = #9
	\mark \markup \center-column {
		\box A
		{ \raise #2 \small \with-color #blue \center-column {"Begin" "solo"} }
	}
	%% m49
	\timestop "1:07"
	a2. r8 e
	g8 a16 g e8 g8~ g e g r
	a4. a8~ a2
	r2 r8 e fis e

	%% m53
	\timestop "1:11"
	a4 a a8 a~ a a~
	a4 r8 e g e g a
	b2 a8 b a g
	e8 e4. r2

	%% m57
	\timestop "1:16"
	a8 gis g fis f g a c
	b8 e, fis a gis b e fis
	\tuplet 3/2 { g8 aes g } fis8 f e cis r4
	ais2 fis'

	%% m61
	\timestop "1:20"
	r8 c cis e cis a fis e
	r2 cis'4. gis8
	b8 gis a r gis a cis fis
	f4 cis8 e~ e4 r

	%% m65
	\markManualBox "B"
	\timestop "1:24"
	\bar ".|"
	r4 \tuplet 3/2 { e8 f e } d8 c a f
	e8 ees d g f g a b
	c4 r8 g'~ g4. e8
	\tuplet 3/2 { d8 e d } c8 b~ b4 r

	%% m69
	\timestop "1:29"
	r8 a gis a a'4. g8
	f8 d a ais b g r d'~
	d4 c8 a c d4.
	r1

	%% m73
	\timestop "1:33"
	b4 cis d e8 f
	r4 cis'16 d cis b a8 gis g f
	e8 d c a cis e4.
	r2 r8 e8 ees d

	%% m77
	\timestop "1:38"
	cis8 cis4 cis8 cis4 c8 cis~
	cis2 f4. dis8
	c4 dis8 cis~ cis4 r
	r1

	%% m81
	\markManualBox "A"
	\bar ".|"
	\timestop "1:42"
	cis'8 c cis e  b ais b d
	cis8 a e ees c e fis gis
	a8 b16 a gis8 fis e d b c
	cis8 c cis e b gis \tuplet 3/2 { a8 c e }

	%% m85
	\timestop "1:47"
	g2~ g8 b, \tuplet 3/2 { c e g }
	b2 r
	r8 e, \tuplet 3/2 { f8 a d } c8 a gis b
	a8 e \tuplet 3/2 { g8 a g } fis8 g e g

	%% m89
	\timestop "1:51"
	f8 f4.~ f8 e \tuplet 3/2 { d8 c a }
	gis4. e'8~ e4 r
	a4 gis g8 f e d
	cis8 a b gis ais cis e fis

	%% m93
	\timestop "1:55"
	a8 a4. r2
	r8 e a \tuplet 3/2 { b16 a g} e8 g~ g e
	a2 r2
	r1
	}

%% Add scale tones over each note
scaleDegreesHead = \lyrics {
	\markup \scaleDegree { 3 }
	\markup \scaleDegree { 4 }
	\markup \scaleDegree { 5 }
	\markup \scaleDegree { 4 }
	\repeat unfold 3 { s1 }
	\repeat unfold 4 { s1 }
}

scaleDegreesSolo = \lyrics {
	%% m49
	\markup \scaleDegree { 1 }2.
	\markup \scaleDegree {  }8
	\markup \scaleDegree { 5 }8

	\markup \scaleDegree { f7 }4
	\markup \scaleDegree { 5 }8
	\markup \scaleDegree { f7 }4
	\markup \scaleDegree { 5 }8
	\markup \scaleDegree { f7 }4

	\markup \scaleDegree { 1 }1

	\markup \scaleDegree {  }2
	\markup \scaleDegree {  }8
	\markup \scaleDegree { 5 }8
	\markup \scaleDegree { 6 }
	\markup \scaleDegree { 5 }

	%% m53
	\markup \scaleDegree { 1 }1

	\markup \scaleDegree { 1 }4.
	\markup \scaleDegree { 5 }8
	\markup \scaleDegree { f7 }8
	\markup \scaleDegree { 5 }8
	\markup \scaleDegree { f7 }8
	\markup \scaleDegree { 1 }8

	\markup \scaleDegree { 2 }2
	\markup \scaleDegree { 1 }8
	\markup \scaleDegree { 2 }
	\markup \scaleDegree { 1 }
	\markup \scaleDegree { f7 }

	\markup \scaleDegree { 5 }8
	\markup \scaleDegree { 5 }4.
	\markup \scaleDegree {  }2


}


templateScore = \score {
	<<
		\new ChordNames { \repeat unfold 2 \chordNamesHead }  % add the Chord Names above the staff
		\new Staff {
			\global
			%% the head 
			<<
				\repeat unfold 6 \scoreBreaks
				\new Voice = "leadVoice" { \leadMusic }
				\new Lyrics \lyricsto "leadVoice" { \scaleDegreesHead }  % add the scaleDegrees below the staff
			>>
			%% Start the solo on a new page 
			%% \pageBreak
			<<
				\repeat unfold 6 \scoreBreaks
				\solo
				\new Lyrics { \scaleDegreesSolo }
			>>
		}

	>>
	\layout {
		indent = 0
	}
}

\templateScore
