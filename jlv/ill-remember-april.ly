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
composer = #"SET COMPOSER"
arranger = #"SET ARRANGER"
meter = "SET METER"
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
}

leadMusic= \relative c'' {
	\bar ".|-|"
	\markManualBox "A"
	\comp 16
	\comp 16
	\comp 16
	\comp 16

	\comp 16
	\comp 16
	\comp 16
	\comp 16
	\bar "|."
}

solo = \relative c'' {
	\bar ".|"
	\once \override Score.RehearsalMark.extra-offset = #' (0 . 1)
	%% \once \override Score.RehearsalMark.baseline-skip = #9
	\mark \markup \center-column {
		\box A
		{ \raise #2 \small \with-color #blue \center-column {"Begin" "solo"} }
	}	
	\comp 16
	\comp 16
	\comp 16
	\comp 16

	\comp 16
	\comp 16
	\comp 16
	\comp 16
}

%% Add scale tones over each note
scaleDegrees = \lyrics {
	\markup \rN {1}4 \markup \rN {2}4 \markup \rN {3}4 \markup \rN {4}4
}

templateScore = \score {
	<<
		\new ChordNames { \repeat unfold 1 \chordNamesHead }  % add the Chord Names above the staff
		\new Staff {
			\global
			%% the head 
			<<
				\repeat unfold 4 \scoreBreaks
				\leadMusic
			>>
			%% Start the solo on a new page 
			\pageBreak
			<<
				\repeat unfold 4 \scoreBreaks
				\solo
			>>
		}
		\new Lyrics { \scaleDegrees }  % add the scaleDegrees below the staff
	>>
	\layout {
		indent = 0
	}
}

\templateScore
