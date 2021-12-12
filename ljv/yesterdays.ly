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
title = #"Yesterdays"
composer = #""
meter = ""
copyright = #"Bartev 2021-03"
tagline = "Solo ideas by Bartev"

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
  \key c \major
	%% \tempo 4=224  % this would be over the clef on the first line

	\override Glissando.style = #'zigzag
	\override Score.Clef #'break-visibility = #'#(#f #f #f) % make only the first clef visible
	\override Score.KeySignature #'break-visibility = #'#(#f #f #f) % make only the first time signature visible
	\override Score.MultiMeasureRest.expand-limit = 1
	\override Score.RehearsalMark.self-alignment-X = #LEFT  % left justify rehearsal marks (centered by default)
	\override Score.SystemStartBar #'collapse-height = #1 % allow single-staff system bars

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
						 #{ <>\mark \markup \override #'(font-name . "lilyjazz-chord") \fontsize #-6 \with-color #blue #string #})

%%%%%%%%%%%%%%%%%%%% Begin music

%% Define line breaks globally
%% OPTIONAL, but can set all lines to be 4 bars wide
scoreBreaks = {
  \repeat unfold 4 { s1*4 \break }
}

%% Define the chords here. The same chords will be used for chord names and notes
chordNamesHead = \chordmode {
	d1:m7
	e2:m7.5- a2:7.9-
	d1:m7
	e2:m7.5- a2:7.9-

	d2:m7 d2:m
	d1:m7
	b1:m7.5-
	e1:7

	a1:7.5+
	d1:7
	g1:7
	c1:7

	f1:7
	bes1:maj7
	e1:m7.5-
	a1:7.9-
}

leadMusic= \relative c'' {
																% \bar ".|"
																% \mark \default
																% c4 d
																% \mark \default
																% e f
																% \mark "A"
																% c4 d
																% \markManualBox "A"
																% e f
																% \mark \default
																% c4 d e f
																% \markManualBox "A"
																% c4 d e f
																% \bar "|."
																% \inlineMMR R1*4
}
arpeg = \relative c' {
	\bar ".|"
	d8 f a c r2
	e,8 g bes d  a cis e g
	d,8 f a c r2
	e,8 g bes d  a cis e g

	d,8 f a c d, f a cis
	d,8 f a c r2
	b8 d f a r2
	e,8 g bes e r2

	a,8 cis eis g r2
	d,8 fis a c r2
	g8 b d f r2
	c,8 e gis bes r2
	
	f8 a c ees r2
	bes8 d f a r2
	e,8 g bes d r2
	a8 cis e g r2
	\bar "|."
}

leading = \relative c''' {
	\bar ".|"
	g8 e  f r r4 a8 fis
	g8 r8 b gis a r8 r4
	c8 a f d c e g c
	b g fis e f g a bes
	\break
	
	c4 a8 f cis4 a8 f
	d8 e f a~ a4 c4
	r2 r8 a b d
	e4 r4 g8 e d b
	\break
	\bar "|."
	
	a4 s2.
	f8 s s2.
	b8 s s2.
	e8 s s2. 
	\break

	ees8 s s2.
	a8 s s2.
	bes8 a g e s2
	cis8 s s2.
	\bar "|."

	s1*4 \break
	s1*2
	b8 c d e f g e ees
	d8 c b a gis f e d
	\break
	
	s1*4 \break \bar "|."

	s1*2
	a'8 bes d f a g f d
	e8 d \tuplet 3/2 {cis8 e g} bes a g e
	\break
	f8 a, b e cis d \tuplet 3/2 {f8 a cis}
	e8 d r4 r2
	s1*2 \break \bar "|."

}

%% Add scale tones over each note
scaleDegrees = \lyrics {
	\markup \rN {1}4 \markup \rN {2}4 \markup \rN {3}4 \markup \rN {4}4
}

%% Add harmonic analysis
harmonicAnalysis = \lyricmode {
																% \override LyricText #'font-name = #"serif"
																% \set stanza = \markup \with-color #red  \fontsize #6 \keyIndication { VI }
																% \markup \rN { V 7 / I }1
																% \markup \rN { V 7 / ii }1
																% \set stanza = \markup \with-color #darkgreen \fontsize #5 \keyIndication { II }
																% \markup \rN { V 7 }1
																% \markup \rN { V 7 }1
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
		\new ChordNames { \repeat unfold 3 \chordNamesHead }  % add the Chord Names above the staff
		\new Staff {
			\global
			%% the head 
			%% <<
			%%	\repeat unfold 2 \scoreBreaks				
			%%	\leadMusic
			%% >>
			%% Start the solo on a new page 
			%% \pageBreak
			<<
				\repeat unfold 2 \scoreBreaks
				{
					\arpeg
					\leading

				}
			>>
		}
																% \new Lyrics { \scaleDegrees }  % add the scaleDegrees below the staff
	>>
	\layout {
		indent = 0
	}
}

																% \chordsAnalysisArpeg
																% \pageBreak

\templateScore