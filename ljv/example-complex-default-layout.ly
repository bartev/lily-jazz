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
title = #"SET MY TITLE"
composer = #"SET COMPOSER"
meter = "SET METER"

copyright = #"Bartev 2022 -- copyright goes at the bottom of the first page"
tagline = "tagline goes at the bottom of the last page"

\paper {
  ragged-bottom = ##t
}

%%%%%%%%%%%%%%%%%%%% Boilerplate - Setup Page, title, header, etc.

realBookTitle = \markup {
  \score {
    {
      \override TextScript.extra-offset = #'(0 . -4.5)
      s4
      s^\markup{
	\fill-line {
	  \fontsize #1 \lower #1 \rotate #7 \concat { \note #"8" #1 " = " #meter }
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

  %% See here for using colors
  %% http://lilypond.org/doc/v2.19/Documentation/notation/inside-the-staff#coloring-objects
  %% \override Score.RehearsalMark.color = #(x11-color "SlateBlue2")  % example using x11 colors
  \override Score.RehearsalMark.color = #darkred
  %% http://lilypond.org/doc/v2.19/Documentation/internals/rehearsalmark
  \override Score.RehearsalMark.font-size = 6

  %% uncomment this to have multibar, jazz style repeats. BUT, bar lines won't show when using "s" to fill in blanks
  \compressFullBarRests

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
	     #{ <>\mark \markup \override #'(font-name . "lilyjazz-chord") \with-color #blue #string #})

fall = \bendAfter #-4
scoop = \bendAfter #+4

%%%%%%%%%%%%%%%%%%%% Begin music

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

%% Define the chords here. The same chords will be used for chord names and notes
chordNamesHead = \chordmode {
  c1:m7 f:7 bes bes
}

%% The actual score
leadMusic = \relative c'' {
  \mark \default
  c4 ees g bes
  \once \override Score.RehearsalMark.font-size = 0
  \mark "BB-0"
  f, a
  \once \override Score.RehearsalMark.font-size = 4
  \mark \markup \with-color #(x11-color "LimeGreen") \box "YY-4"
  c ees
  \once \override Score.RehearsalMark.font-size = 8
  \mark \markup \with-color #(x11-color "LimeGreen") \box "XX-8"
  bes d
  \mark \markup \with-color #darkred \box "WW-no-size"
  f a
  \markManualBox "CC-mmb"
  g ees d bes
}

%% Add scale tones over each note
scaleDegrees = \lyrics {
  \markup \rN {1}4 \markup \rN {3}4 \markup \rN {5}4 \markup \rN {7}4
  \markup \rN {1}4 \markup \rN {3}4 \markup \rN {5}4 \markup \rN {7}4
  \markup \rN {1}4 \markup \rN {3}4 \markup \rN {5}4 \markup \rN {7}4
  \markup \rN {6}4 \markup \rN {5}4 \markup \rN {4}4 \markup \rN {1}4
}

templateScore = \score {
  <<
    \new Lyrics \harmonicAnalysis  % add the harmonic harmonicAnalysis above the chord names
    \new ChordNames \chordNamesHead  % add the Chord Names above the staff
    \new Staff {
      \global
      %% the head (play it twice)
      \repeat unfold 2 \leadMusic
    }
    \new Lyrics { \scaleDegrees }  % add the scaleDegrees below the staff
  >>
  \layout {
    indent = 0
  }
}


\book {
  \header {
    %% The following fields are centered
    dedication = "Dedication"
    title = \realBookTitle
    subtitle = "Subtitle"
    %% subsubtitle = "Subsubtitle"

    %% The following fields are evenly spread on one line
    %% the field "instrument" also appears on following pages
    instrument = \markup \with-color #green "Instrument"
    %% poet = "Poet"
    %% composer = \composer


    %% The following fields are placed at opposite ends of the same line
    %% meter = \meter
    %% arranger = "Arranger"
    %% The following fields are centered at the bottom
    copyright = \copyright
    %% tagline = ##f  % Remove default LilyPond tagline
    tagline = \tagline
  }


  \score {
    \new Staff {
      \global
      {
	<<
	  %% { \once \compressFullBarRests s1*8 \scoreBreaks	}
	  \relative c'' {
	    <>^\markup "Piano"
	    \once \compressFullBarRests \inlineMMR R1*8
	    \bar ".|"
	    { s1 s1 s1}
	    \bar "|."
	    {
	      b4
	      ^\markup { \raise #4 \with-color #blue \small {"(B" \flat "arpeg)"} }
	      c e g
	    }
	    %% \leadMusic
	  }
	>>
      }
    }

    \header {
      %% The following fields are placed at opposite ends of the same line
      piece = "Piece 1"
      opus = "Opus 1"
    }
  }


  \score {
    \new Staff {
      \global
      \relative c'' {
	r8 e8 g c bes g e c
	\override Glissando.style = #'zigzag
	\timestop "0:11"
	bes4 \glissando g' bes e
	\inlineMMR R1*2
	\bar ":|]"
	c,4 e g b \fall
      }
    }

    \header {
      %% The following fields are placed at opposite ends of the same line
      piece = "Piece 2 on the same page"
      opus = "Opus 2"
    }
  }

  \score {
    \header {
      piece = "Repeat bar lines"
    }
    \relative c {
      f'1 \bar ".|:"
      g1 \bar ":..:"
      a1 \bar ":|.|:"
      b1 \bar ":|.:"
      c1 \bar ":.|.:"
      d1 \bar "[|:"
      e1 \bar ":|][|:"
      f1 \bar ":|]"
      g1 \bar ":|."
      a1
    }
  }

  \score {
    \header { piece = "From Spontaneous combustion - partial and dynamics" }
    \relative c''' {
      \partial 1 r8 g-> r8 d fis-- g-. a4--
      %% do this to have multiple rehearsal marks in the same location
      %% https://lilypond.org/doc/v2.19/Documentation/snippets-big-page#editorial-annotations-how-to-print-two-rehearsal-marks-above-and-below-the-same-barline-_0028method-2_0029
      \once \override Score.RehearsalMark.extra-offset = #' (0 . 1)
      %% \once \override Score.RehearsalMark.baseline-skip = #9
      \mark \markup \center-column {
	\box 1
	%% { \raise #2 \with-color #red \fontsize #1 \center-column {"Begin" "solo"} }
	{ \raise #2 \small \with-color #blue \center-column {"Begin" "solo"} }
      }
      \bar ".|"
      \timestop "1:24"
      g4 r r g~\mf
      g4 r8 e\mp\< c d e4\mf
      \override Glissando.style = #'zigzag
      %% bes4 \glissando g'
      d2\mp r4 \glissando c'~\f
      c4 a-.\mf f8\mp\< g a4\!
      \break
    }
  }

  \score {
    \header { piece = "Parenthesis, xNote, grace notes, triplets" }
    \relative c'' {
      \tuplet 3/2 {r8 b a}  \tuplet 3/2 {gis8 b d} f8 e \xNote d \parenthesize \xNote b
      \parenthesize c4 \parenthesize d e \parenthesize f
      \grace {c16 ais } \tuplet 3/2 { b8 d f} d4 b a8 g |
      \grace { c16 ais } b1
      \grace { c16 ais } b1 
      gis4 r4 r4 r4
    }

  }

  \score {
    \header { piece = "Accidentals" }

    \relative c'' {
      \key bes \major
      bes8 c d c bes? c e g
      bes! g f e d c a bes
    }
  }

  \score {
    \header { piece = "Falls and doits" }
    \relative c''{
      c2\bendAfter #+4
      c2\bendAfter #-4
      c2\bendAfter #+6.5
      c2\bendAfter #-6.5
      c2\bendAfter #+8
      c2\bendAfter #-8

      \override Score.SpacingSpanner.shortest-duration-space = #4.0
      c2-\bendAfter #5
      c2-\bendAfter #-4.75
      c2-\bendAfter #8.5
      c2-\bendAfter #-6
    }
  }


  \pageBreak

  \score {
    \header { piece = "Contemporary glissando and scoop using hidden notes and cadenza" }
    \relative c'' {
      \time 3/4
      \override Glissando.style = #'zigzag
      c4 c
      \cadenzaOn
      c4\glissando
      \hideNotes
      c,,4
      \unHideNotes
      \cadenzaOff
      \bar "|"

      \cadenzaOn
      \hideNotes
      c'4 \scoop
      \unHideNotes
      \cadenzaOff
      c'
    }
  }

  \score {
    { s1 }
    \header {
      %% The following fields are placed at opposite ends of the same line
      piece = "Piece 3 on a new page"
      opus = "Opus 3"
    }
  }

  \relative c' { c4 d e f }

  \templateScore
}
