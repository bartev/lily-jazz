\version "2.24.0"

%% See here for formatting text
%% https://lilypond.org/doc/v2.20/Documentation/notation/formatting-text

%% set to 18 to fit entire head and title on 1 page
#(set-global-staff-size 18)
\include "jazzchords.ily"
\include "lilyjazz.ily"
\include "jazzextras.ily"
\include "roman_numeral_analysis_tool.ily"

%% set up title, compser, meter, copyright
title = #"Spontaneous Combustion"
composer = #"Cannonball Adderly"
meter = "180"
copyright = #"Bartev 2021-06"
tagline = "Awesome transcription by Bartev - Blues for Alice iRealPro"

%%%%%%%%%%%%%%%%%%%% Boilerplate - Setup Page, title, header, etc.

realBookTitle = \markup {
  \score {
    {
      \override TextScript.extra-offset = #'(0 . -4.5)
      s4
      s^\markup{
        \fill-line {
          \fontsize #1 \lower #1 \rotate #7 \concat { \note {4} #1 " = " #meter }
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

global = {
  \numericTimeSignature
  \time 4/4
  \key c \major
  %% \tempo 4=224 % this would be over the clef on the first line

  \override Score.Clef.break-visibility = #'#(#f #f #f) % make only the first clef visible
  \override Score.KeySignature.break-visibility = #'#(#f #f #f) % make only the first time signature visible
  \override Score.SystemStartBar.collapse-height = #1 % allow single-staff system bars
  \override Score.RehearsalMark.self-alignment-X = #LEFT  % left justify rehearsal marks (centered by default)
  \override Score.MultiMeasureRest.expand-limit = 1

  %% See here for using colors
  %% http://lilypond.org/doc/v2.19/Documentation/notation/inside-the-staff#coloring-objects
  %% \override Score.RehearsalMark.color = #(x11-color "SlateBlue2")  % example using x11 colors
  \override Score.RehearsalMark.color = #darkred
  %% http://lilypond.org/doc/v2.19/Documentation/internals/rehearsalmark
  \override Score.RehearsalMark.font-size = 6

  %% uncomment this to have multibar, jazz style repeats. BUT, bar lines won't show when using "s" to fill in blanks
  %% \compressEmptyMeasures
  
  \set Score.rehearsalMarkFormatter = #format-mark-box-alphabet
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
  \repeat unfold 3 { s1*4 \break }
}

%% Define the chords here. The same chords will be used for chord names and notes
%% These are the chords for C-instruments
chordNamesHead = \chordmode {
  bes1:7
  ees:7
  bes:7
  f2:m7 bes:7

  ees1:7
  e:dim
  bes:7
  d2:m7 g:7

  c1:m7
  f:7.9-
  d2:m7 g:7
  c2:7 f:7
  
}

leadMusic= \relative c'' {
  \bar ".|-|"
  \mark \default
  c4 d
  \mark \default
  e f
  \mark "A"
  c4 d
  \markManualBox "A"
  e f
  \mark \default
  c4 d e f
  \markManualBox "A"
  c4 d e f
  \bar "|."
  \inlineMMR R1*4
}

intro_partial = \relative c''' {
  \timestop "1:24"
  \partial 1 r8 g-> r8 d fis-- g-. a4--
}

solo = \relative c''' {
  \bar ".|-|"

  %% do this to have multiple rehearsal marks in the same location
  %% https://lilypond.org/doc/v2.19/Documentation/snippets-big-page#editorial-annotations-how-to-print-two-rehearsal-marks-above-and-below-the-same-barline-_0028method-2_0029
  
  \once \override Score.RehearsalMark.extra-offset = #' (0 . 1)
  %% \once \override Score.RehearsalMark.baseline-skip = #9
  \mark \markup \center-column {
    \box 1
    %% { \raise #2 \with-color #red \fontsize #1 \center-column {"Begin" "solo"} }
    { \raise #2 \small \with-color #blue \center-column {"Begin" "solo"} }
  }

  
  \bar ".|-|"
  \timestop "1:26"
  g4 r r g~\mf
  g4 r8 e\mp\< c d e4\mf
  \override Glissando.style = #'zigzag
  %% bes4 \glissando g'
  d2\mp r4 \glissando c'~\f
  c4 a-.\mf f8\mp\< g a4
  \break
  
  \timestop "1:31"
  g2\mf r4 r8 cis8~\f
  cis4 \tuplet 3/2 {c8( cis c)} bes8\> g f16 d c g
  b4.\mp f8~ f2\p\<
  \tuplet 3/2 {r8\mp( bes a)} aes8 cis, d\p\< f e d\!
  \break
  
  \timestop "1:37"
				% \mark \markup { \raise #2 \small \with-color #blue "Whole-half dim" }
  \markBlue "Whole-half dim (Co7?)"
  es8\< r \tuplet 3/2 {d'8 ( c ) f (} \tuplet 3/2 {es8 ) aes ( fis)} \tuplet 3/2 { b8 (a) d~}
  d4\f \markBlue "phryg dom" \tuplet 3/2 {c8( d c)} bes8 g es16\>( d c g)
  b8\< d e d~ d2\mf
  r4 g,\mf b8-- c-. r8 d8
  \bar "|."
  \break

  \markManualBox "2"
  \timestop "1:42"
  r1
  d2~ d8 g, c g
  bes4-- c-. r2
  r4 g4-> bes8-- c-. r des
  \break

  \timestop "1:48"
  r4 r8 g,-. bes-. c-. d-. e-.
  f8-. fis-. a( aes16 g) fis?8 d ais8( g)
  d'8-- d-. r4 r2
  r8 fis,( a16 c a bes b2)
  \break

  \timestop "1:53"
  r8 e,8~ e16 g b e g,8 a16 b \glissando g8( \markBlue "Encl-3-1" f
  fis8 d') r4 e8 g b a
  g8 e c( \markBlue "Encl" a) b-- b-. r4
  r4 r8 d( e) g e4

  \pageBreak
  
  \markManualBox "3"
  \timestop "1:58"
  %% \override Glissando.style = #'zigzag
  %% bes4 \glissando g'
  bes4-> a g r4
  r8 d' r dis e g e d
  bes4->( a) g-- f--
  r8 g' r gis a c d ees~
  \break

  \timestop "2:04"
  ees8 c4-- a4-- g8 ees16( f ees d)
  c8 a g f e c' a a(
  bes4 a g) d
  \tuplet 3/2 {r8 b' a} \tuplet 3/2 {gis8 b d} f8 e d \parenthesize \xNote b

  \timestop "2:09"
  c8 e,~ e16 g b d b8 c e g
  b4 c8 b16 bes a8 g \tuplet 3/2 {fis8 e fis!~}
  fis4 r r8 fis16 g a8 aes
  g8 fis e ees d des c b

  \markManualBox "4"
  \timestop "2:13"
  a8 g fis g a fis g a
  b8 d r8 a r4 r8 a8
  fis8 g a fis g a b d
  ees8 f16 ees b8 aes( g) ges( f) des
  \break

  e8 c' a bes d f a c~
  c4 r r2
  r8 b16 c d8 g,16 a b8 fis16 g a g fis e
  d4 fis16 d bes fis   bes fis des' c   b g e d

  c4 b'8. gis16 a16 b c d e c a e
  g16 f fis d'~ d4 b'4. a8
  \tuplet 3/2 {fis8 g a} \tuplet 3/2 {fis8 g a} d,8 d r4
  r8 g r8 g fis g a4-.

  \markManualBox "5"
  g4-. r8 g, b d r8 c
  s1
  s1
  s1
  \break

  s1 * 4
  \break
  s1 * 4
  
  
}

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

spontCombustScore = \score {
  <<
    %% \new Lyrics \harmonicAnalysis  % add the harmonic harmonicAnalysis above the chord names
    \new ChordNames \transpose bes g { s1 \repeat unfold 4 \chordNamesHead }  % add the Chord Names above the staff
    
    \new Staff {
      
      \global
      %% the head 
      \intro_partial
      <<
	\repeat unfold 4 \scoreBreaks
	\solo
      >>
    }
    %% \new Lyrics { \scaleDegrees }  % add the scaleDegrees below the staff
  >>
  \layout {
    indent = 0
  }
}

\spontCombustScore