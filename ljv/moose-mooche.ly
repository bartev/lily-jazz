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
title = #"Moose The Mooche"
composer = #"Charlie Parker"
meter = "224"
copyright = #"Bartev 2021-02-28"
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
  \key c \major
	%% \tempo 4=224  % this would be over the clef on the first line

	\override Score.Clef #'break-visibility = #'#(#f #f #f) % make only the first clef visible
	\override Score.KeySignature #'break-visibility = #'#(#f #f #f) % make only the first time signature visible
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
	\mark \default
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
	\mark \default
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

leadMusic= \relative c'' {
	\bar ".|"
  c4 d e f
	c4 d e f
	c4 d e f
	c4 d e f
	\bar "|."
	\inlineMMR R1*4
}

solo = \relative c'' {
	\bar ".|"

	\once \override Score.RehearsalMark.extra-offset = #' (0 . 1)
	\mark \markup \center-column {
		\box A
		{ \raise #4 \with-color #blue \small \center-column {"Begin" "solo"} }
	}	
	r8 e8 g c bes g e c
	\inlineMMR R1*3 
	\bar "|."
	\inlineMMR R1*4
	\inlineMMR R1*2

}

%% Add scale tones over each note
scaleDegrees = \lyrics {
	\markup \rN {1}4 \markup \rN {2}4 \markup \rN {3}4 \markup \rN {4}4
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

mooseScore = \score {
	<<
		\new Lyrics \harmonicAnalysis  % add the harmonic harmonicAnalysis above the chord names
		\new ChordNames { \repeat unfold 1 \chordNamesHead }  % add the Chord Names above the staff
		\new Staff {
			\global
			%% the head 
			<<
				\scoreBreaks				
				\leadMusic
			>>
			%% Start the solo on a new page 
																% \pageBreak
																% <<
																% 	\scoreBreaks
																% 	\solo
																% >>
		}
																% \new Lyrics { \scaleDegrees }  % add the scaleDegrees below the staff
	>>
	\layout {
		indent = 0
	}
}

\chordsAnalysisArpeg

\pageBreak

\mooseScore