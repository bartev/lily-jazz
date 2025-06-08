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
title = #"Nobody Else But Me"
composer = #"Jerome Kern"
%% arranger = ##f
tagline = "Awesome transcription by Bartev (B-flat - soprano)"
meter = "Medium Swing"
%% copyright = #tagline
copyright = "Bartev 2022"

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
      ragged-bottom = ##t
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

%% Changed
%% #:roman "lilyjazz-text"
\paper {
  #(set-paper-size "letter")
  %% use lilyjazz-chord instead of lilyjazz-text for roman font below
  %% so the keyIndication better differentiates I vs i.
  #(define fonts
    (set-global-fonts
     #:music "lilyjazz"
     #:brace "lilyjazz"
     #:roman "lilyjazz-chord" 
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
	\compressEmptyMeasures
	
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
  \repeat unfold 1 { s1*4 \break }
}

%% Define the chords here. The same chords will be used for chord names and notes
introChords = \chordmode { s1*8 }

chordNamesHead = \chordmode {
  %% A
  %% \markManualBox A
  d2:maj7 g:7
  fis2:m7 b:7
  e1:m7
  a1:7

  e2:m7 a:7
  ees2:m7 aes:7
  %% dis2:m7 gis:7
  cis1:maj7
  gis2:m7 cis:7

  %% B
  %% \markManualBox B
  fis1:maj7
  g1:dim7
  cis1:maj7
  f1:7

  b1:m7
  e1:7
  e1:m7
  a1:7

  %% A
  %% \markManualBox A
  d2:maj7 g:7
  fis2:m7 b:7
  e1:m7
  a1:7

  e2:m7 fis:7
  b2:m7 bes:7
  a1:m7
  d1:7

  %% C
  %% \markManualBox C
  g1:maj7
  g2:m7 c:7
  d2:maj7 b:7
  e2:7 ees:7

  d1:maj7
  ees1:dim7
  e1:m7
  f1:dim7

  e1:m7
  bes2:7 a:7
  d1:6
  d1:6
  
}

intro = { \compressMMRests R1*8 }
leadMusic= \relative c'' {
  
	\bar ".|-|"
  \markManualBox "A"
  \timestop "0:14"
  %% m1
  b8 a b4 r \tuplet 3/2 { r8 a b }
  d,4 d r2
  r4 b' b8 a b cis,
  r8 cis4.~ cis2
  \break

  %% m5
  \timestop "0:22"
  r8 b' b e, cis'4. r8
  r8 bes bes f c'4. aes8
  f1
  ees'8 fes \tuplet 3/2 { f8 ges f~ } f2
  \break
  \bar "|."
  
  %% m9
  \markManualBox "B"
  \timestop "0:29"
  r4 cis cis8 b cis dis,
  r8 dis r4 r2
  r2 cis'8 bis cis f,
  f4 r8 f8~ f2
  \break

  %% m13
  \timestop "0:36"
  r4 r8 \parenthesize fis cis'4 cis
  cis8 \parenthesize fis, e' cis~ cis2
  \tuplet 3/2 { r4 c b~ } b4. a8
  \tuplet 3/2 { b8 a b~ } b4~ b2
  \bar "|."
  \break
  
  \markManualBox "A"
  \timestop "0:43"
  b'4 r4 r8 a8 \grace eis8 fis4
  d4 d r2
  r2 b'8 a b cis,
  r8 cis r4 r2
  \break

  \timestop "0:50"
  r8 b8~ \tuplet 3/2 { b8 b g } cis2
  d4 d ees2
  r8 e4. e8 d e fis,~
  fis1
  \bar "|."
  \break
  
  \markManualBox "C"
  \timestop "0.57"
  r4 fis'4 e8 d a4
  \tuplet 3/2 { g8 a g~ } g2.
  fis8 r r d a' r r fis
  cis'2. r8 c8
  \break

  \timestop "1:03"
  b4 b2 r8 a8~
  \tuplet 3/2 { a8 b a } b2 a4~
  \tuplet 3/2 { a8 b a } b4~ b8 a4.~
  a8 b4.~ b2
  \break

  \timestop "1:10"
  r8 b4. r8 cis 4.
  d2 e4. d8~
  d2 a'8 g f d
  bes4 a8 g c bes? a g
  \break
  \bar "|."

  \markManualBox "A - 2nd chorus"
  \timestop "1:18"
  \grace eis8 fis4 r4 r2
  r2 \tuplet 3/2 { a8 d fis } g8 fis
  d8 b d4 r4 \tuplet 3/2 { r8 b bes }
  \tuplet 3/2 { a8 a' r } a2.
  \break

  \timestop "1:25"
  r1
  \markBlue "A♭7 scale"
  r8 f ees des c bes aes ges
  %% r8 eis dis cis bis ais gis fis
  eis8 eis~ eis2 r8 gis8~
  \tuplet 3/2 { gis8 cis dis } cis2.
  \break
  \bar "|."
  
  \markManualBox "B"
  \timestop "1:33"
    cis8 cis, cis4 cis r4
  r1
  r2 \tuplet 3/2 { r8 bis'4 } \tuplet 3/2 { cis4 dis8~ }
  \tuplet 3/2 { dis8 eis fis } eis? dis  \tuplet 3/2 { cis8 bis b } \tuplet 3/2 { cis?8 d e }
  \break

  \timestop "1:40"
  \tuplet 3/2 { fis8 r fis~ } fis4 fis8 e dis cis~
  \tuplet 3/2 { cis8 \grace dis16 e4~ } e2~ \tuplet 3/2 { e8 dis cis }
  d8 g,~ g2 r4
  \tuplet 3/2 { r4 f' e } \markBlue "E♭7? tritone sub?" ees16 bes g f ees4
  \break
  \bar "|."
  
  \markManualBox "A"
  \timestop "1:47"
  d4 \tuplet 3/2 { e8 fis a } \tuplet 3/2 { r8 cis d } cis8 c~
  c2 b8 c b4
  r8 bes4. bes8 c bes a
  r8 a4. r2
  \break

  \timestop "1:54"
  r1
  %% r4 eis'16 fis eis dis~ dis cis8 bis16 \tuplet 5/4 { ais16 gis g eis dis }
  r4 f'16 fis f ees~ ees cis!8 c16 \tuplet 5/4 { bes16 aes g f ees} % in B flat7
  e16 d' cis b    c e, gis b    \tuplet 3/2 { a16 b a } e16 f    r16 fis r8
  \markBlue "A♭7 tritone sub? (think A♭7 except for D♮)"
  %% \tuplet 3/2 { r8 bes' c } \tuplet 3/2 { bes8 aes fis } f16 ees d c bes fis f ees % in D7
  \tuplet 3/2 { r8 bes' c } \tuplet 3/2 { bes?8 aes ges } f16 ees d c bes \markBlue "skips A♭" ges f ees  % in A flat 7
  \break
  \bar "|."
  
  \markManualBox "C"
  \timestop "2:01"
  d8 fis' \xNote b,4 e8 d a4
  g8 a g4 r2
  r2 fis'8 fis, \tuplet 3/2 { b8 dis e }
  \tuplet 3/2 { d8 e d } cis8 c r bes a g
  \break
  
  \timestop "2:08"
  fis4 fis2~ \tuplet 3/2 { fis8 g a }
  b8 c b fis~ fis4 r
  r4 \tuplet 3/2 { r8 a aes } g8 aes? \tuplet 3/2 { c8 ees r }
  \tuplet 3/2 { r8 fis g } \tuplet 3/2 { f8 ees cis } \tuplet 3/2 { c8 bes a?~ } \tuplet 3/2 { a8 bes? c? }
  \break
  
  \timestop "2:15"
  \tuplet 3/2 { d8 ees4 } g,8 a b cis d fis,
  g8 a bes c r8 bes?8~ bes g
  \grace f8 fis4 b,4 d8 b~ b4
  r2 r4 \grace f'8 fis4
  \break
  \bar "|."
}

% intro = { \once \compressFullBarRests \inlineMMR R1*8 \bar ".|-|" }

solo = \relative c'' {
	\bar ".|-|"
  
  % \markManualBox A
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
	\mark \markup \left-column {
		\box B
		\small \with-color #blue "markBlue test"
	}
	
	\override Glissando.style = #'zigzag
	\timestop "0:11"
	bes4 \glissando g'
	\markBlue "My Blue Text"
	bes e
	c d e f
	\inlineMMR R1*2 
	\bar "|."
	\timestop "0.08"
	%% \mark \markup{\small \with-color #red "0:08"}
	
	\inlineMMR R1*2

}

%% Add scale tones over each note
scaleDegrees = \lyrics {
	\markup \rN {1}4 \markup \rN {2}4 \markup \rN {3}4 \markup \rN {4}4
}

%% Add harmonic analysis
harmonicAnalysis = \lyricmode {
	\override LyricText.font-name = #"serif"
  
  %% \override MarkupText.font-name = #"serif"
  %% A
	\set stanza = \markup \with-color #red  \fontsize #2 \keyIndication { I }
	\markup \rN { I }2 \markup \rN { IV 7}2
  \markup \rN { iii }2 \markup \rN { VI 7 }2
  \markup \rN { ii }1
  \markup \rN { V 7 }1

  \markup \rN { ii }2 \markup \rN { V 7 }2
  \set stanza = \markup \with-color #red  \fontsize #2 \keyIndication { VII }
  \markup \rN { ii }2 \markup \rN { V 7 }2
  \markup \rN { I M 7 }1
  \set stanza = \markup \with-color #red  \fontsize #2 \keyIndication { III }
  \markup \rN { ii }2 \markup \rN { V 7 }2

  %% B
	\markup \rN { I M 7 }1
  \set stanza = \markup \with-color #red  \fontsize #2 \keyIndication { ?? }
  \markup \rN { ?? o 7 }1

  \markup \rN { ?? M 7 }1
  \markup { \rN { ?? 7 } "tritone sub for B" }1
  \set stanza = \markup \with-color #red  \fontsize #2 \keyIndication { V }
  \markup \rN { ii }1
  \markup \rN { V 7 }1
  \set stanza = \markup \with-color #red  \fontsize #2 \keyIndication { I }
  \markup \rN { ii }1
  \markup \rN { V 7 }1

  %% A
	\markup \rN { I }2 \markup \rN { IV 7}2
  \markup \rN { iii }2 \markup \rN { VI 7 }2
  \markup \rN { ii }1
  \markup \rN { V 7 }1

  \set stanza = \markup \with-color #red  \fontsize #2 \keyIndication { vi }
  \markup \rN { iii / ii h 7 }2 \markup \rN { v7 }2
  \markup \rN { i - 7 }2 \markup { \rN { VII 7 } tritone sub }2
  \set stanza = \markup \with-color #red  \fontsize #2 \keyIndication { IV }
  \markup \rN { ii }1
  \markup \rN { V 7 }1

  %% C
  \markup \rN { I }1
  \set stanza = \markup \with-color #red  \fontsize #2 \keyIndication { F?? }
  \markup \rN { ii }2 \markup \rN { V 7 }2
  \set stanza = \markup \with-color #red  \fontsize #2 \keyIndication { I }
  \markup \rN { I }2 \markup \rN { VI 7 }2
  \markup \rN { II 7 }2 \markup \rN { fII 7 }2 

  \markup \rN { I }1
  \markup \rN { fii o 7 }1
  \markup \rN { ii }1
  \markup \rN { fiii o 7 }1 
  
  \markup \rN { ii }1
  \markup \rN { fVI 7 }2 \markup \rN { V 7 }2
  \markup \rN { I 6 }1 
  \markup \rN { I 6 }1 
}


%% Chord names, chord tones, and harmonic analysis only 
chordsAnalysisArpeg= {
	<<
		\new Lyrics \harmonicAnalysis
		\new ChordNames { \chordNamesHead }
		\new Staff {
			%% \global
      \key c \major
			<<
				\repeat unfold 9 \scoreBreaks
				\chordNamesHead
			>>
		}
	>>
}

transcribedScore = \score {
	<<
    %% Add the harmonic harmonicAnalysis above the chord names
		\new Lyrics {
      %% \introChords
      \harmonicAnalysis
    }
                  
    % Add the Chord Names above the staff
		\new ChordNames {
      %% \introChords
      \repeat unfold 2 \chordNamesHead
    }  
    %% Create a staff for the music
		\new Staff {
			\global
      %% \inlineMMR R1*8
      \leadMusic
		}
		%% \new Lyrics { \scaleDegrees }  % add the scaleDegrees below the staff
	>>
	\layout {
		indent = 0
	}
}


\transcribedScore
