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
title = #"I've Got You Under My Skin"
composer = #"Cole Porder"
arranger = #"SET ARRANGER"
tagline = "Awesome transcription by Bartev"
meter = "120"
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

%% Define line breaks globally
%% OPTIONAL, but can set all lines to be 4 bars wide
scoreBreaks = {
  \repeat unfold 2 { s1*4 \break }
}

%% Define the chords here. The same chords will be used for chord names and notes
chordNamesD =  \chordmode {
  %% A
  d1:m7 g:7 c:maj7 a:7
  d:m7 g:7 c:maj7 a:7

  d:m7 g:7 c:maj7 a:7
  d:m7 g:7 c:maj7 a:7
  %% B
  d:m7 g:7 c:maj7 a:7
  d:m7.5- g:7.9- c:maj7 c:maj7

  b:m7 e:7 a:maj7 a:maj7
  d:m7 g:7 c:maj7 c:maj7
  %% C
  d:m7 g:7sus c:maj7 a:7.9-
  d:m7 g:7sus c:maj7 e:7.9-
  %% D
  a:m7 d2:m7 g2:7 c1:maj7 a1:m7
  d:m7 g:7 c:maj7 g2:m7 c2:7

  f1:maj7 bes:7 c:maj7 e2:m7.5- a2:7
  d1:m7 g:7 c:maj7 c:maj7
}

chordNamesA = \transpose d a {\chordNamesD}

leadMusic= \relative c'' {
  \partial 4
  \timestop "0:00"
  d4
	\bar ".|-|"
  \mark \markup \center-column {
		\box A
		%% { \raise #2 \with-color #red \fontsize #1 \center-column {"Begin" "solo"} }
		{ \raise #2 \small \with-color #blue \center-column {"Begin head"} }
	}
  %% m1
  e4 r8 e8~ e2~
  e2 d4 c4
  b4 r8 b8~ b2
  r2 r8 c8 d4
  \break

  %% m5
  \timestop "0:04"
  e4 e e e
  e2 d4 c4
  b4( bes) b b~
  b2 r4 r8 b
  \break

  %% m9
  \timestop "0:08"
  c4 c c c~
  \tuplet 3/2 { c4~ c b } \tuplet 3/2 { a4 g fis  }
  \tuplet 3/2 { a2 g4 } e2
  r2 r4 fis4
  \break

  %% m13
  \timestop "0:12"
  g8 g g2.
  r2 fis4 e
  d8 d~ d4~ d2
  r2 r4 d'
  \break
  \bar "||"
  
  \markManualBox "B"
  %% m17
  \timestop "0:15"
  e e e2~
  e4 d c b4
  b2. g8 e
  r2 r8 b' c4
  \break

  \timestop "0:19"
  ees4 ees ees ees~
  ees4 d c b8 bes
  b!2 r2
  r2 r4 b4
  \break

  \timestop "0:23"
  cis4 cis cis cis
  b a g8 gis r4
  s1
  s1
  \break
  
  \repeat unfold 2 { s1*4 \break }
  \repeat unfold 2 { s1*4 \break }
  
  \timestop "0:11"
  \repeat unfold 2 { s1*4 \break }
  \repeat unfold 2 { s1*4 \break }
  \markManualBox "C"
  \timestop "0:11"
  \repeat unfold 2 { s1*4 \break }
  \repeat unfold 2 { s1*4 \break }
  \markManualBox "D"
  \timestop "0:11"
  \repeat unfold 2 { s1*4 \break }
  \repeat unfold 2 { s1*4 \break }
    \bar "|."
}

%% solo = \relative c'' {
%% 	\bar ".|-|"
%% 
%% 	%% do this to have multiple rehearsal marks in the same location
%% 	%% https://lilypond.org/doc/v2.19/Documentation/snippets-big-page#editorial-annotations-how-to-print-two-rehearsal-marks-above-and-below-the-same-barline-_0028method-2_0029
%% 	
%% 	\once \override Score.RehearsalMark.extra-offset = #' (0 . 1)
%% 
%% }

%% solo = \relative c'' {
%% 	\bar ".|-|"
%%   %% \markManualBox "Begin solo (A)"
%%   \mark \markup \center-column {
%% 		\box A
%% 		%% { \raise #2 \with-color #red \fontsize #1 \center-column {"Begin" "solo"} }
%% 		{ \raise #2 \small \with-color #blue \center-column {"Begin solo"} }
%% 	}	
%% 
%%   \timestop "0:11"
%%   \repeat unfold 2 { s1*4 \break }
%%   \repeat unfold 2 { s1*4 \break }
%%   \markManualBox "B"
%%   \timestop "0:11"
%%   \repeat unfold 2 { s1*4 \break }
%%   \repeat unfold 2 { s1*4 \break }
%%   \markManualBox "C"
%%   \timestop "0:11"
%%   \repeat unfold 2 { s1*4 \break }
%%   \repeat unfold 2 { s1*4 \break }
%%   \markManualBox "D"
%%   \timestop "0:11"
%%   \repeat unfold 2 { s1*4 \break }
%%   \repeat unfold 2 { s1*4 \break }
%%   \bar "|."
%% }

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


templateScore = \score {
	<<
		%% \new Lyrics \harmonicAnalysis  % add the harmonic harmonicAnalysis above the chord names
		\new ChordNames { \partial 4 s4
                      \repeat unfold 2 \chordNamesA }  % add the Chord Names above the staff
		\new Staff {
			\global
			%% the head 
			<<
				%% \repeat unfold 2 \scoreBreaks				
				\leadMusic
			>>
			%% Start the solo on a new page 
			%% \pageBreak
			%% <<
			%% 	%% \scoreBreaks
			%% 	\solo
			%% >>
		}
    %%	\new Lyrics { \scaleDegrees }  % add the scaleDegrees below the staff
	>>
	\layout {
		indent = 0
	}
}

%% \chordsAnalysisArpeg
%% \pageBreak

\templateScore

