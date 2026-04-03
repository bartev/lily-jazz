\version "2.24.2"

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
title = #"Softly as a Morning Sunrise"
composer = #"Hamerstein-Romberg"
arranger = #"SET ARRANGER"
meter = "SET METER"
instrument = \instrumentAlto

transcribed = #"Bartev 2026-03"
tagline = "Awesome transcription by Bartev"
copyright = #"Bartev 2026"

%% Paper & Layout settings are in `realbook_layout`
%% Import AFTER setting `title`
%% It defines the realbook title line based on definitions above
\include "realbook_layout.ily"

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
  \key a \minor
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
chordNamesHead = \chordmode {
  a1:min | b2:m7.5- e2:7.9- | a1:min | b2:m7.5- e2:7.9-
  a1:min | b2:m7.5- e2:7.9- | a1:min | b2:m7.5- e2:7.9-

  a1:min | b2:m7.5- e2:7.9- | a1:min | b2:m7.5- e2:7.9-
  a1:min | b2:m7.5- e2:7.9- | a1:min | d2:m7    g:7

  \repeat percent 2 c1 | \repeat percent 2 a1:7.9-
  d1:min7 | dis1:dim7 | b1:dim7 e1:7.9-

  a1:min | b2:m7.5- e2:7.9- | a1:min | b2:m7.5- e2:7.9-
  a1:min | b2:m7.5- e2:7.9- | a1:min | b2:m7.5- e2:7.9-

}

melodyAlto = \relative c''' {
  %% m1
  \bar ".|-|"
  \markManualBox "A"
  a2 e4 r
  d8 e d e~ e4 d8 r
  a'2 c,4 r
  r8 b c b c4 b
  \break

  %% m5
  e2 a,4 r
  r8 e' f e c4 b
  a4 r r2
  r2 r4 r8 e'
  \break

  %% m9
  \markManualBox "A"
  a4 a e r
  r8 d e d e4 d
  a'2 c,4 r
  r8 b c b c4 b
  \break

  %% m13
  e2 a,4 r
  r8 e' f e c a b a~
  a4 r r2
  r2 f'4 f8 fis
  \break
  \bar "|."

  %% m17
  \markManualBox "B"
  g4 r r2
  r4 g-. a~ a8 g
  g8 r cis, cis~ cis4 r
  r2 e8 f g4
  \break

  %% m21%
  a4-^ r r8 g a b~
  b2. a8 b~
  b2 r
  r2 c4 b
  \break
  \bar "|."

  %% m25
  \markManualBox "A"
  a2 e4 r
  d8 e d e~ e4 d8 r
  a'2 c,4 r
  b8 c b c~ c4 b
  \break

  %% m29
  e2 a,4 r
  e'8 f e c~ c4 b8 \xNote a8
  r4 e'4-. gis8 e r4
  fis8 d b a gis b d f
  \break
  \bar "||"

}
solo = \relative c'' {
  e8 c r4 d b8 c
  r1
  r1
  \comp 4
  \break

  \comp 16 \break

  \comp 16 \break
  \comp 16 \break

  \comp 16 \break
  \comp 16 \break

  \comp 16 \break
  \comp 16 \break
}

%% %% Add scale tones over each note
%% scaleDegrees = \lyrics {
%% 	\markup \rN {1}4 \markup \rN {2}4 \markup \rN {3}4 \markup \rN {4}4
%% }

%% %% Add harmonic analysis
%% harmonicAnalysis = \lyricmode {
%% 	\override LyricText.font-name = #"serif"
%% 	\set stanza = \markup \with-color #red  \fontsize #6 \keyIndication { VI }
%% 	\markup \rN { V 7 / I }1
%% 	\markup \rN { V 7 / ii }1
%% 	\set stanza = \markup \with-color #darkgreen \fontsize #5 \keyIndication { II }
%% 	\markup \rN { V 7 }1
%% 	\markup \rN { V 7 }1
%% }


eflatScore = \score {
  <<
    \new ChordNames \with {
      \consists Percent_repeat_engraver
      }
    {
      \repeat unfold 2 \chordNamesHead
    }
    \new Voice = soloist {
      \global
      \melodyAlto
      \pageBreak
      \solo
    }
  >>
}

\eflatScore
