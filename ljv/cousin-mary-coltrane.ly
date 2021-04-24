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

leadMusicLeadInC = \relative c'' {
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
	ees2~ ees8 ges aes bes~
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
	dis8 c g4 b2
	c8 bes aes g~ g2
	bes8 c~ c2 r4
	r4 r8 a'8~ a4. bes8

	\markManualBox "2"
	\timestop "0:39"
	a8 f r ees~ ees g~ g4~
	g4 f8 d bes r r4
	r4 r8 f'~ f4~ f8 e!
	ees8 f g bes a g f e

	\timestop "0.44"
	ees8 c bes a aes bes c ees
	g8 bes a g r f c bes
	c b c d ees f g f~
	f4.ees8 c c g r

	\timestop "0.48"
	f'2~ f8 ees f f~
	f4 ees8 f ees4 c8 ees
	c8 bes aes g r2
	r2 a4 \tuplet 3/2 {c8 ees f}
	
	\pageBreak
	
	\markManualBox "3"
	\timestop "0.52"
	g1~
	g4 f8 g f ees f g
	r8 g~ g2 f8 g
	f8 ees c bes \markBlue "G?" d8 bes g ees
	
	\timestop "0.57"
	\tuplet 3/2 {a8 bes c} \tuplet 3/2 {cis8 d ees} f16 g a bes a8 g~
	g4. ees8 c4 aes8 g~
	g2 a8 c r4
	r2 r8 ees d des
	
	\timestop "1:02"
	c aes \markBlue "A?" f ees \markBlue "D?" g4. f8
	\markBlue "not sure of this" g8 a bes c r d f g~
	g4. f8 a8 c~ c4~
	c2 r2
	
	\markManualBox "4"
	\timestop "1:06"
	r4 c8 aes~ aes2~
	aes8 g aes g~ g8 f g f~
	f8 ees f ees~ ees8 c ees d~
	d4. c8 f cis a f

	\timestop "1:10"
	d'4. c8 ees c e c
	f8 d bes \markBlue "G? F?" g \markBlue "A? Ab?" a c~ c4~
	c4 g8 ees f g~ g4~
	g4 r r2
	
	\timestop "1:14"
	\tuplet 3/2 {c,8 ees f} \tuplet 3/2 {g a c} \tuplet 3/2 {ees f g} a4
	\tuplet 3/2 {c,,8 ees f} \tuplet 3/2 {g a c} \tuplet 3/2 {ees f g~} g8 r8
	r8 ees,8 \tuplet 3/2 {f8 g a} c16 ees f g a4~
	a4. bes8 a f r4
	
	\markManualBox "5"
	\timestop "1:19"
	r8 bes a g f e ees a
	d,8 c \markBlue "Hard to hear" r4 f8 d c a
	d4. ees8 d des c bes
	g8 ees d c f4 r4
	
	\timestop "1:23"
	r8 f8 g bes c d ees f
	g bes aes f~ f c aes4
	s1*2
	
	\timestop "1:27"
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
		\new ChordNames { \repeat unfold 5 \chordNamesHead}  % add the Chord Names above the staff
		\new Staff {
			\global
			%% the head 
			<<
				\scoreBreaks
				
				\transpose ees c \leadMusicLeadInC
			>>
			%% Start the solo on a new page 
			%% \pageBreak
			<<
				\repeat unfold 5 \scoreBreaks
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