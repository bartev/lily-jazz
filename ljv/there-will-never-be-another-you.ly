\version "2.24.0"

%% Transcription help from 

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
title = #"There Will Never Be Another You"
composer = #"Kenny Garrett solo"
%% arranger = ##f
tagline = "Awesome transcription by Bartev (with checks from ...)"
meter = "200"
%% copyright = #tagline
copyright = "Bartev 2023"

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
  \context { \Lyrics \override LyricText.font-name = #"serif"
                     \override LyricText.font-size = -1}
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
  %% \override Score.Clef.break-visibility = #'#(#f #f #f)

  %% make only the first time signature visible
  %% \override Score.KeySignature.break-visibility = #'#(#f #f #f)

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


chordNames = {
  \chordmode {
    c1:maj7
    c:maj7
    b:m7.5-
    e:7.9-

    a:m7
    a:m7
    g:m7
    c:7

    f:maj7
    bes:7.11+
    c:maj7
    a:m7
    
    d:7.11+
    d:7.11+
    d:m7
    g:7.5+

    c:maj7
    c:maj7
    b:m7.5-
    e:7.9-

    a:m7
    a:m7
    g:m7
    c:7

    f:maj7
    bes:7.11+
    c:maj7
    bis2:m7 b:7

    c2:maj7  f:7
    e2:m7 a:7.5+
    d2:m7 g:7.5+
    c1:maj7
  }
}

ebSolo = \relative c'''{
  %% 1st chorus
  \markManualBox "1st Chorus"
  \bar ".|"
  \timestop "1:53"
  \section
  r1
  r4 r8 aes g f e d
  e4 e2.
  r4 r8 f e d c a
  \break

  d4 d2~ d8 c
  d4 g8 e r d c b
  cis2 d4. bes8~
  bes4. a8 g4 c8 bes
  \break
  
  a8 c e g~ g g f4
  r2 ees8 c aes fis
  g4. f8 e d' r4
  c4 r4 r2
  \break

  b'2 gis4 e8 b
  r8 b4 gis8 b e gis a
  gis4. fis8 g fis f gis
  g8 ees b gis g fis f gis
  \bar "||"
  \break

  \section
  \timestop "2:10"
  g8 a b4 c8 d e f
  g8 a b c d4 c8 gis
  r8 gis r4 r2
  r2 e'4 b8 d~
  \break
  
  d2. c8 d~
  d2. c8 d~
  d2. c8 ees,
  r2 r8 d'8 c e
  \break
  
  r1
  ees4 r4 r2
  d4 r4 r2
  b4 r4 r4 r8 a8
  \break

  g4 c8 b c4 g8 fis
  g4 e8 c r2
  r4 d8 e f g gis fis
  g8 f e d c d e f
  \bar "||"
  \break

  \markManualBox "2nd Chorus"
  \timestop "2:29"
  \section
  aes8 des ees des aes4 f8 ees
  des4 ees8 f r ees des4
  \grace e8 f4 d8 b r2
  r2 e8 d c4
  \break

  b4 gis8 a r b c d
  ees8 e f ees e d c b
  bes4 r8 g a fis g a
  bes8 c cis b c4 r8 c
  \break

  a8 c e g r g f d
  ees4. c16 gis g4. f8
  e8 d' r4 r2
  r1
  \break

  r8 b' bes cis c4 gis8 ees
  d8 b' bes2~ bes8 gis
  g8 fis f a g e r fis
  ees8 b gis fis g4 r8 f
  \break

  e4 g8 f fis4 a8 fis
  g4 d'8 b c4 e8 c
  d4 r4 r2
  r2 r8 e4-. d8
  \break
  
  c8 a c4 r2
  r2 r8 d8 c bes
  r2 a'4 g-.
  a4. g8 c4 bes8 a
  \break

  r2 r4 g8 gis
  r2 r4 g8 e
  r2 r4 g8 b
  r2 r4 r8 a8
  \break

  g4-. c8 b c4-. g
  f4 g e f8 d~
  d e f g ees b gis fis
  g8 f' d ees e c a g
  \bar "||"
  d8 d~ d4 r2
}

scaleDegrees = \lyrics {
  %% m1
  ""1

  ""4.
  \markup \scaleDegree { f6 }8
  \markup \scaleDegree { 5 }
  \markup \scaleDegree { 4 }
  \markup \scaleDegree { 3 }
  \markup \scaleDegree { 2 }

  \markup \scaleDegree { 4 }1

  ""4.
  \markup \scaleDegree { f9 }8
  \markup \scaleDegree { 1 }
  \markup \scaleDegree { f7 }
  \markup \scaleDegree { f6 }
  \markup \scaleDegree { 4 }

  %% m5
  \markup \scaleDegree { 4 }2..
  \markup \scaleDegree { f3 }8

  \markup \scaleDegree { 4 }4
  \markup \scaleDegree { f7 }8
  \markup \scaleDegree { 5 }
  ""
  \markup \scaleDegree { 4 }
  \markup \scaleDegree { f3 }
  \markup \scaleDegree { 2 }

  \markup \scaleDegree { s4 }2
  \markup \scaleDegree { 5 }2

  \markup \scaleDegree { f7 }4.
  \markup \scaleDegree { 6 }8
  \markup \scaleDegree { 5 }4
  \markup \scaleDegree { 1 }8
  \markup \scaleDegree { f7 }

  %% m9
  \markup \scaleDegree { 3 }8
  \markup \scaleDegree { 5 }
  \markup \scaleDegree { 7 }
  \markup \scaleDegree { 9 }4.
  \markup \scaleDegree { 1 }4

  ""2
  \markup \scaleDegree { 4 }8
  \markup \scaleDegree { 2 }
  \markup \scaleDegree { f7 }
  \markup \scaleDegree { s5 }

  \markup \scaleDegree { 5 }4.
  \markup \scaleDegree { 4 }8
  \markup \scaleDegree { 3 }
  \markup \scaleDegree { 9 }
  ""4

  \markup \scaleDegree { f3 }4
  ""2.
  
  %% m13
  \markup \scaleDegree { 6 }2
  \markup \scaleDegree { s4 }4
  \markup \scaleDegree { 2 }8
  \markup \scaleDegree { 6 }

  ""8
  \markup \scaleDegree { 6 }4
  \markup \scaleDegree { s4 }8
  \markup \scaleDegree { 6 }
  \markup \scaleDegree { 2 }
  \markup \scaleDegree { s4 }
  \markup \scaleDegree { 5 }

  \markup \scaleDegree { s4 }4.
  \markup \scaleDegree { 3 }8
  ""2

  \markup \scaleDegree { 1 }8
  \markup \scaleDegree { f6 }
  \markup \scaleDegree { 3 }
  \markup \scaleDegree { s1 }
  ""2

  %% m17
  \markup \scaleDegree { 5 }8
  \markup \scaleDegree { 6 }
  \markup \scaleDegree { 7 }4
  \markup \scaleDegree { 1 }8
  \markup \scaleDegree { 2 }
  \markup \scaleDegree { 3 }
  \markup \scaleDegree { 4 }


  \markup \scaleDegree { 5 }8
  \markup \scaleDegree { 6 }
  \markup \scaleDegree { 7 }
  \markup \scaleDegree { 8 }
  \markup \scaleDegree { 9 }4
  \markup \scaleDegree { 1 }8
  \markup \scaleDegree { s5 }

  ""8
  \markup \scaleDegree { 6 }8
  ""2.

  ""2
  \markup \scaleDegree { 1 }4
  \markup \scaleDegree { 5 }8
  \markup \scaleDegree { f7 }

  %% m21
  \markup \scaleDegree { 4 }2.
  \markup \scaleDegree { f3 }8
  \markup \scaleDegree { 4 }

  ""1

  \markup \scaleDegree { 5 }2.
  \markup \scaleDegree { 4 }8
  \markup \scaleDegree { f6 }

  ""2
  ""8
  \markup \scaleDegree { 2 }8
  \markup \scaleDegree { 1 }
  \markup \scaleDegree { 3 }

  %% m25
  ""1
  
  
  
  
}

eFlatScore = \score {
  <<
    %% \new Lyrics \harmonicAnalysis  % add the harmonic harmonicAnalysis above the chord names

    % add the Chord Names above the staff
    \new ChordNames { \repeat unfold 2 \chordNames }
    \new Staff {
      \global
      \ebSolo
    }
    %% add the scaleDegrees below the staff
    \new Lyrics { \scaleDegrees }
  >>
  \layout { indent = 0 }
}

\eFlatScore