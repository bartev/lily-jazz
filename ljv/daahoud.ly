\version "2.24.0"

%% Transcription help from https://www.youtube.com/watch?v=jVlnkapGspw
%% and https://theotherjocko.com/blogs/latest-news/posts/3741496/clifford-brown-daahoud-and-ears


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
title = #"Daahoud"
composer = #"Clifford Brown"
%% arranger = ##f
tagline = "Awesome transcription by Bartev (with checks from https://www.youtube.com/watch?v=jVlnkapGspw)"
meter = "155"
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
        \fontsize #2 \lower #2 \rotate #7 \concat { \note { 2 } #1  " = " #meter }
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

%% Define line breaks globally
%% OPTIONAL, but can set all lines to be 4 bars wide
scoreBreaks = {
  \repeat unfold 2 { s1*4 \break }
}

%% Define the chords here. The same chords will be used for chord names and notes

chordNamesAvolta = \chordmode {
  \repeat volta 2 {
    %% A
    c2:m7 f:7
    bes2:m7 ees:7
    aes1:maj7
    d2:m7 g:7

    c1:6
    aes2:7 g:7
    c1:m7+
  }
  \alternative {{c1:m7+} {c1:m7+}}
}

chordNamesAsingle = \chordmode {
  %% A
  c2:m7 f:7
  bes2:m7 ees:7
  aes1:maj7
  d2:m7 g:7

  c1:6
  aes2:7 g:7
  c1:m7+
  c1:m7+
}

intro_partial = \relative c'' {
  \partial 1
  \timestop "0:00"
  r8 d b c ees g b d~
}

chordNamesB = \chordmode  {
  %% B
  g1:m7
  c1:7
  f1:maj7
  f1:maj7

  f1:m7
  bes1:7
  ees1:maj7
  d2:m7 g:7
}

chordNamesCinterlude = \chordmode {
  %% C
  c2:m7 f:7
  bes2:m7 ees:7
  aes1:maj7
  d2:m7 g:7

  c1:6
  aes2:7 g:7
  c1:m7+
  f2:m7 bes:7

  f1:maj7
  c2:m7 f:7
  aes2:7 g:7
  c1:maj7
}


chordNamesC = \chordmode {
  %% C
  c2:m7 f:7
  bes2:m7 ees:7
  aes1:maj7
  d2:m7 g:7

  c1:6
  aes2:7 g:7
  c1:m7+
  c1:m7+
}

chordNamesIntroPartial = \chordmode { c1:m7+ }

chordNamesVolta = {
  \chordNamesAvolta
  \chordNamesB
  \chordNamesCinterlude
}

chordNamesNoVolta = {
  \chordNamesAsingle
  \chordNamesAsingle
  \chordNamesB
  \chordNamesC
}

head= \relative c''' {
  \repeat volta 2
  {
    \bar "[|:-|"
    \timestop "0:09"
    d1
    r4 c8 bes c ees c bes
    g8 ees e f r2
    r4 g8 f g f ees c~
    \break

    \timestop "0:05, 0:13"
    c1
    r8 ees c bes~ bes g bes b~
    b1
  }
  \alternative {
    { r8 d b c ees g b d \bar ":|]"}
    {
      r2 r8 b, c c'~
      \bar "|."
      \break
    }
  }

  %% B
  \timestop "0:17"
  c2~ c8 c c c->
  r4 r8 ees8-^~ ees c4-^ bes8-^
  c2. g8 f->
  r2 r8 a,8 bes bes'~
  \break

  \timestop "0:21"
  bes2~ bes8 bes bes bes->
  r4 r8 des8->~ des bes4-^ aes8-^
  bes2 g8 f ees g
  r8 d b c ees g b d~
  \bar "||"
  \break

  \timestop "0:25"
  d1
  r4 c8 bes c ees c bes
  g ees e f r2
  r4 g8 f g f ees c~
  \break

  \timestop "0:29"
  c1~
  c8 ees c bes~ bes g bes b->
  r1
  r4 g'8 f~ f bes aes g->~
  \break

  \timestop "0:33"
  g4. g8-> r8 f ees d->~
  d4. d8-> r c bes a~
  a8 ees' d f ees? d c b?
  r4 r8 bes \tuplet 3/2 { b8 d f } aes8 fis
  \bar "||"
  \break
}

solo = \relative c''' {
  %% 1st chorus
  \markManualBox "1st Chorus"
  \bar ".|"
  \timestop "0:37"
  \section
  g8 d' r b c g r f
  r8 c' r a bes des, r4
  r4 ees8 des c ees? f g
  bes8 a aes bes? b cis dis b
  \break

  \timestop "0:41"
  d4 c8 g ees c  bes aes
  f'8 ges8~ ges4 f8 ees c g
  b8 c e c d g r4
  r2 r8 \grace fis8 g4 f8
  \bar "||"
  \break

  \timestop "0:45"
  d8 ees b d c d ees? f
  ges8 ees f des c bes ees? des?
  bes8 b c ees f g bes a
  aes8 bes b cis dis b bes aes?
  %% \repeat unfold 4 {s1}
  \break

  \timestop "0:49"
  f8 fis a fis? g f d dis
  e8 ^\markup \fontsize #-2 \with-color #blue {"A" \flat "7alt like Gmaj7"}
  g, a b d b c d
  e8 f g a \tuplet 3/2 { b8 c cis } d g,
  r2 r4 r8
  \override Staff.OttavaBracket.font-series = #'medium
  \set Staff.ottavationMarkups = #ottavation-simple-ordinals
  \ottava #1
  \grace fis'8 g8
  %% \repeat unfold 4 {s1}
  \break
  \bar "|."

  \timestop "0:53"
  r8 a8
  \ottava #0
  r f e d c b
  bes8 d a \markBlue "Leads to 5" aes g f e d
  \tuplet 3/2 { c8 d c } a8 c f c4 r8
  r1
  %% \repeat unfold 4 {s1}
  \break

  \timestop "0:57"
  r8 g''16 fis f8 c aes f e c
  ees8 c d f aes b aes? a
  bes8 aes f fis g r8 r4
  r4 ees8 c d c b d
  %% \repeat unfold 4 {s1}
  \break
  \bar "|."

  \timestop "1:01"
  c8 g c d ees f fis e
  f8 des c bes ees des? bes? b
  c8 ees f g bes a aes bes?
  b8 cis dis b bes aes f fis
  %% \repeat unfold 4 {s1}
  \break

  \timestop "1:05"
  a8 fis g a ais b d b
  c8 a f ges g4 r4
  r2
  \override Staff.OttavaBracket.font-series = #'medium
  \set Staff.ottavationMarkups = #ottavation-simple-ordinals
  \ottava #1
  fis'8  g4.
  fis8 g4. fis8 g4.
  \break
  \bar "|."

  %% \pageBreak

  %% 2nd chorus
  \markManualBox "2nd Chorus"
  \section
  \timestop "1:09"
  g4. ees16 c b4 c
  \ottava #0
  f4. des16 bes a4 bes!
  ees4. bes16 aes g4 aes!
  ees'4. bes16 aes g4 aes!
  \break

  \timestop "1:13"
  r1
  \override Staff.OttavaBracket.font-series = #'medium
  \set Staff.ottavationMarkups = #ottavation-simple-ordinals
  \ottava #1
  r8 g aes8 bes c d e f
  g8 a g4 e r4
  r2 r8 gis8 a4
  \break
  \bar "|."

  \timestop "1:17"
  g4 f8 ees d c bes r
  \ottava #0
  f'4 r ees r8 des
  r4 c8 bes a4. g8
  aes8 bes b cis~ cis b bes aes
  \break

  \timestop "1:21"
  g8 g, c d ees f fis e
  f8 d ees b c d e f
  g8 a b g a4 r
  r2 r4 r8 \grace cis8 d8~
  \break
  \bar "|."

  \timestop "1:25"
  d4 bes8 a g r8 r4
  cis,8
  ^\markup \fontsize #-2 \with-color #blue {"Alt scale? (notes of scale 1/2 step lower)"}
  dis e fis gis e dis? cis?
  c4 d8 e f g a bes
  c4 a r2
  \break

  \timestop "1:29"
  r8 \grace b8 c4. aes8 f e c
  ees
  ^\markup \fontsize #-2 \with-color #blue {"Alt scale?"}
  aes, bes b des d e8 r
  r8 d ees f  g aes bes g
  aes8 fis g f ees d des b
  \break
  \bar "|."

  \timestop "1:33"
  c8 d ees f ges ees? f d
  ees8 des d c \tuplet 3/2 { b8 d f } aes8 f
  g8 fis f e ees des bes c
  r8 g' bes aes g f ees d
  \break

  \timestop "1:37"
  \tuplet 3/2 { c8 d c } g8 c \tuplet 3/2 { ees8 f ees } c8 ees
  \tuplet 3/2 {fis8 g fis} ees8 g f4 r4
  r8 f8 \tuplet 3/2 { g8 bes c } ees8 c d b
  c8 a f d e g d c
  \break
  \bar "|."
  \fine
}

%% Add scale tones below each note

scaleDegreesHead = \lyrics {
  ""8
  \markup \scaleDegree { 2 }8
  \markup \scaleDegree { 7 }
  \markup \scaleDegree { 1 }
  \markup \scaleDegree { f3 }
  \markup \scaleDegree { 5 }
  \markup \scaleDegree { 7 }
  \markup \scaleDegree { 9 }

  \repeat volta 2 {
    %% m1
    \markup \scaleDegree { 1 }1

    ""4
    \markup \scaleDegree { 2 }8
    \markup \scaleDegree { 1 }
    \markup \scaleDegree { 6 }
    \markup \scaleDegree { 1 }
    \markup \scaleDegree { 6 }
    \markup \scaleDegree { 5 }

    \markup \scaleDegree { 7 }8
    \markup \scaleDegree { 5 }
    \markup \scaleDegree { s5 }
    \markup \scaleDegree { 6 }
    ""2

    ""4
    \markup \scaleDegree { 4 }8
    \markup \scaleDegree { f3 }
    \markup \scaleDegree { 1 }
    \markup \scaleDegree { f7 }
    \markup \scaleDegree { f6 }
    \markup \scaleDegree { 2 }

    %% m5
    \markup \scaleDegree { 1 }1

    ""8
    \markup \scaleDegree { 5 }
    \markup \scaleDegree { 3 }
    \markup \scaleDegree { 2 }
    \markup \scaleDegree { f3 }
    \markup \scaleDegree { 1 }
    \markup \scaleDegree { f3 }
    \markup \scaleDegree { 3 }

    \markup \scaleDegree { 7 }1

    \alternative {
      {
        ""8
        \markup \scaleDegree { 2 }8
        \markup \scaleDegree { 7 }
        \markup \scaleDegree { 1 }
        \markup \scaleDegree { f3 }
        \markup \scaleDegree { 5 }
        \markup \scaleDegree { 7 }
        \markup \scaleDegree { 9 }
      }
      {
        ""2 ""8
        \markup \scaleDegree { 7 }8
        \markup \scaleDegree { 1 }
        \markup \scaleDegree { 1 }
      }
    }
  }

  %% m10
  \markup \scaleDegree { 4 }2
  ""8
  \markup \scaleDegree { 4 }
  \markup \scaleDegree { 4 }
  \markup \scaleDegree { 4 }

  ""4.
  \markup \scaleDegree { f3 }4
  \markup \scaleDegree { 1 }4
  \markup \scaleDegree { f7 }8

  \markup \scaleDegree { 5 }2.
  \markup \scaleDegree { 2 }8
  \markup \scaleDegree { 1 }

  ""2 ""8
  \markup \scaleDegree { f3 }8
  \markup \scaleDegree { 4 }
  \markup \scaleDegree { 4 }

  %% m14
  \markup \scaleDegree { 4 }2
  ""8
  \markup \scaleDegree { 4 }8
  \markup \scaleDegree { 4 }8
  \markup \scaleDegree { 4 }8

  ""4.
  \markup \scaleDegree { f3 }4
  \markup \scaleDegree { 1 }
  \markup \scaleDegree { 6 }8

  \markup \scaleDegree { 5 }2
  \markup \scaleDegree { 3 }8
  \markup \scaleDegree { 2 }
  \markup \scaleDegree { 1 }
  \markup \scaleDegree { 3 }

  ""8
  \markup \scaleDegree { 1 }8
  \markup \scaleDegree { 6 }
  \markup \scaleDegree { f7 }
  \markup \scaleDegree { f6 }
  \markup \scaleDegree { 1 }
  \markup \scaleDegree { 3 }
  \markup \scaleDegree { 5 }

  %% m18
  \markup \scaleDegree { 2 }1

  ""4
  \markup \scaleDegree { 2 }8
  \markup \scaleDegree { 1 }
  \markup \scaleDegree { 6 }
  \markup \scaleDegree { 1 }
  \markup \scaleDegree { 6 }
  \markup \scaleDegree { 5 }

  \markup \scaleDegree { 7 }8
  \markup \scaleDegree { 5 }
  \markup \scaleDegree { s5 }
  \markup \scaleDegree { 6 }
  ""2

  ""4
  \markup \scaleDegree { 4 }8
  \markup \scaleDegree { f3 }
  \markup \scaleDegree { 1 }
  \markup \scaleDegree { f7 }
  \markup \scaleDegree { f6 }
  \markup \scaleDegree { 4 }

  %% m22
  \markup \scaleDegree { 1 }1

  \markup \scaleDegree { 3 }8
  \markup \scaleDegree { 5 }
  \markup \scaleDegree { 3 }
  \markup \scaleDegree { 2 }
  \markup \scaleDegree { f3 }
  \markup \scaleDegree { 1 }
  \markup \scaleDegree { f3 }
  \markup \scaleDegree { 3 }

  ""1

  ""4
  \markup \scaleDegree { 2 }8
  \markup \scaleDegree { 1 }
  \markup \scaleDegree { 5 }
  \markup \scaleDegree { 1 }
  \markup \scaleDegree { f7 }
  \markup \scaleDegree { 6 }

  %% m26
  \markup \scaleDegree { 2 }4.
  \markup \scaleDegree { 2 }8
  ""8
  \markup \scaleDegree { 1 }
  \markup \scaleDegree { f7 }
  \markup \scaleDegree { 6 }

  \markup \scaleDegree { 2 }4.
  \markup \scaleDegree { 2 }8
  ""8
  \markup \scaleDegree { 5 }
  \markup \scaleDegree { 4 }
  \markup \scaleDegree { 3 }

  \markup \scaleDegree { s1 }8
  \markup \scaleDegree { 5 }
  \markup \scaleDegree { s4 }
  \markup \scaleDegree { 6 }
  \markup \scaleDegree { f6 }8
  \markup \scaleDegree { 5 }
  \markup \scaleDegree { 4 }
  \markup \scaleDegree { 3 }

  %% Solo begins 1 bar early
  ""4.
  \markup \scaleDegree { f7 }8
  \tuplet 3/2 { \markup \scaleDegree { n7 }8
                \markup \scaleDegree { 2 }
                \markup \scaleDegree { 4 } }
  \markup \scaleDegree { f6 }8
  \markup \scaleDegree { s4 }

  %% 1st solo chorus
  %% m30
  \markup \scaleDegree { 5 }8
  \markup \scaleDegree { 9 }
  ""8
  ""8
  \markup \scaleDegree { 5 }8
  \markup \scaleDegree { 2 }
  ""8
  \markup \scaleDegree { 1 }

  ""8
  \markup \scaleDegree { 2 }8
  ""8
  \markup \scaleDegree { n7 }
  \markup \scaleDegree { 5 }
  \markup \scaleDegree { f7 }
  ""4

  ""4
  \markup \scaleDegree { 5 }8
  \markup \scaleDegree { 4 }
  \markup \scaleDegree { 3 }
  \markup \scaleDegree { 5 }
  \markup \scaleDegree { 6 }
  \markup \scaleDegree { 7 }

  \markup \scaleDegree { f6 }8
  \markup \scaleDegree { 5 }
  \markup \scaleDegree { f5 }
  \markup \scaleDegree { f6 }
  \markup \scaleDegree { 3 }
  \markup \scaleDegree { s4 }
  \markup \scaleDegree { s5 }
  \markup \scaleDegree { 3 }

  %% m34
  \markup \scaleDegree { 9 }4
  \markup \scaleDegree { 1 }8
  \markup \scaleDegree { 5 }
  \markup \scaleDegree { f3 }
  \markup \scaleDegree { 1 }
  \markup \scaleDegree { 5 }
  \markup \scaleDegree { 6 }

  \markup \scaleDegree { 6 }8
  \markup \scaleDegree { f7 }4.
  \markup \scaleDegree { f7 }8
  \markup \scaleDegree { f6 }
  \markup \scaleDegree { 4 }
  \markup \scaleDegree { 1 }

  \markup \scaleDegree { 7 }8
  \markup \scaleDegree { 1 }
  \markup \scaleDegree { n3 }
  \markup \scaleDegree { 1 }
  \markup \scaleDegree { 2 }
  \markup \scaleDegree { 5 }
  ""4

  ""2
  ""8
  \markup \scaleDegree { 5 }4
  \markup \scaleDegree { 4 }8

  %% m38
  \markup \scaleDegree { 2 }8
  \markup \scaleDegree { f3 }
  \markup \scaleDegree { n7 }
  \markup \scaleDegree { 2 }
  \markup \scaleDegree { 5 }
  \markup \scaleDegree { 6 }
  \markup \scaleDegree { f7 }
  \markup \scaleDegree { 1 }

  \markup \scaleDegree { f6 }8
  \markup \scaleDegree { 4 }
  \markup \scaleDegree { 5 }
  \markup \scaleDegree { f3 }
  \markup \scaleDegree { 6 }
  \markup \scaleDegree { 5 }
  \markup \scaleDegree { 1 }
  \markup \scaleDegree { f7 }

  \markup \scaleDegree { 2 }8
  \markup \scaleDegree { s2 }
  \markup \scaleDegree { 3 }
  \markup \scaleDegree { 5 }
  \markup \scaleDegree { 6 }
  \markup \scaleDegree { 7 }
  \markup \scaleDegree { 9 }
  \markup \scaleDegree { s8 }

  \markup \scaleDegree { f5 }8
  \markup \scaleDegree { f6 }
  \markup \scaleDegree { 6 }
  \markup \scaleDegree { n7 }
  \markup \scaleDegree { s5 }
  \markup \scaleDegree { 3 }
  \markup \scaleDegree { f3 }
  \markup \scaleDegree { f9 }

  %% m42
  \markup \scaleDegree { 4 }8
  \markup \scaleDegree { s4 }
  \markup \scaleDegree { 6 }
  \markup \scaleDegree { s4 }
  \markup \scaleDegree { 5 }
  \markup \scaleDegree { n4 }
  \markup \scaleDegree { 2 }
  \markup \scaleDegree { s2 }

  \markup \scaleDegree { s5 }8
  \markup \scaleDegree { 7 }
  \markup \scaleDegree { s1 }
  \markup \scaleDegree { s2 }
  \markup \scaleDegree { 5 }
  \markup \scaleDegree { 3 }
  \markup \scaleDegree { 4 }
  \markup \scaleDegree { 5 }

  \markup \scaleDegree { n3 }8
  \markup \scaleDegree { 4 }
  \markup \scaleDegree { 5 }
  \markup \scaleDegree { 6 }
  \tuplet 3/2 {
    \markup \scaleDegree { n7 }8
    \markup \scaleDegree { 1 }
    \markup \scaleDegree { s1 }
  }
  \markup \scaleDegree { 9 }8
  \markup \scaleDegree { 5 }

  ""2.
  ""8
  \markup \scaleDegree { 5 }8

  %% m46
  ""8
  \markup \scaleDegree { 9 }8
  ""8
  \markup \scaleDegree { f7 }
  \markup \scaleDegree { 6 }
  \markup \scaleDegree { 5 }
  \markup \scaleDegree { 4 }
  \markup \scaleDegree { 3 }

  \markup \scaleDegree { f7 }8
  \markup \scaleDegree { 9 }
  \markup \scaleDegree { 6 }
  \markup \scaleDegree { f6 }
  \markup \scaleDegree { 5 }
  \markup \scaleDegree { 4 }
  \markup \scaleDegree { 3 }
  \markup \scaleDegree { 2 }

  \tuplet 3/2 {
    \markup \scaleDegree { 5 }8
    \markup \scaleDegree { 6 }
    \markup \scaleDegree { 5 }
  }
  \markup \scaleDegree { 3 }8
  \markup \scaleDegree { 5 }
  \markup \scaleDegree { 1 }
  \markup \scaleDegree { 5 }4
  ""8

  ""1

  %% m50
  ""8
  \markup \scaleDegree { 2 }8
  \markup \scaleDegree { 1 }
  \markup \scaleDegree { 5 }
  \markup \scaleDegree { f3 }
  \markup \scaleDegree { 1 }
  \markup \scaleDegree { 7 }
  \markup \scaleDegree { 5 }

  \markup \scaleDegree { 4 }8
  \markup \scaleDegree { 2 }
  \markup \scaleDegree { 3 }
  \markup \scaleDegree { 5 }
  \markup \scaleDegree { f7 }
  \markup \scaleDegree { f9 }
  \markup \scaleDegree { f7 }
  \markup \scaleDegree { n7 }

  \markup \scaleDegree { 5 }8
  \markup \scaleDegree { 4 }
  \markup \scaleDegree { 2 }
  \markup \scaleDegree { s2 }
  \markup \scaleDegree { 3 }
  ""4.

  ""4
  \markup \scaleDegree { f2 }8
  \markup \scaleDegree { f7 }
  \markup \scaleDegree { 5 }
  \markup \scaleDegree { 4 }
  \markup \scaleDegree { 3 }
  \markup \scaleDegree { 5 }

  %% m54
  \markup \scaleDegree { 1 }8
  \markup \scaleDegree { 5 }
  \markup \scaleDegree { 1 }
  \markup \scaleDegree { 2 }
  \markup \scaleDegree { f7 }8
  \markup \scaleDegree { 1 }
  \markup \scaleDegree { s1 }
  \markup \scaleDegree { n7 }

  \markup \scaleDegree { 5 }8
  \markup \scaleDegree { f3 }
  \markup \scaleDegree { 2 }
  \markup \scaleDegree { 1 }
  \markup \scaleDegree { 1 }8
  \markup \scaleDegree { f7 }
  \markup \scaleDegree { 5 }
  \markup \scaleDegree { s5 }

  \markup \scaleDegree { 3 }8
  \markup \scaleDegree { 5 }
  \markup \scaleDegree { 6 }
  \markup \scaleDegree { 7 }
  \markup \scaleDegree { 9 }
  \markup \scaleDegree { s8 }
  \markup \scaleDegree { 8 }
  \markup \scaleDegree { 9 }

  \markup \scaleDegree { 6 }8
  \markup \scaleDegree { n7 }
  \markup \scaleDegree { s8 }
  \markup \scaleDegree { 6 }
  \markup \scaleDegree { f3 }8
  \markup \scaleDegree { f2 }
  \markup \scaleDegree { f7 }
  \markup \scaleDegree { n7 }

  %% m58
  \markup \scaleDegree { 6 }8
  \markup \scaleDegree { s4 }
  \markup \scaleDegree { 5 }
  \markup \scaleDegree { 6 }
  \markup \scaleDegree { s6 }8
  \markup \scaleDegree { 7 }
  \markup \scaleDegree { 9 }
  \markup \scaleDegree { 7 }

  \markup \scaleDegree { 3 }8
  \markup \scaleDegree { s1 }
  \markup \scaleDegree { 6 }
  \markup \scaleDegree { f7 }
  \markup \scaleDegree { 1 }4
  ""4

  ""2
  ""8
  \markup \scaleDegree { 5 }4.

  ""8
  \markup \scaleDegree { 5 }4.
  ""8
  \markup \scaleDegree { 5 }4.

  %% 2nd chorus
  %% m62
  \markup \scaleDegree { 5 }4.
  \markup \scaleDegree { f3 }16
  \markup \scaleDegree { 1 }
  \markup \scaleDegree { s4 }4
  \markup \scaleDegree { 5 }

  \markup \scaleDegree { 5 }4.
  \markup \scaleDegree { f3 }16
  \markup \scaleDegree { 1 }
  \markup \scaleDegree { s4 }4
  \markup \scaleDegree { 5 }

  \markup \scaleDegree { 5 }4.
  \markup \scaleDegree { 2 }16
  \markup \scaleDegree { 1 }
  \markup \scaleDegree { 7 }4
  \markup \scaleDegree { 1 }

  \markup \scaleDegree { f9 }4.
  \markup \scaleDegree { f6 }16
  \markup \scaleDegree { f5 }
  \markup \scaleDegree { 1 }4
  \markup \scaleDegree { f2 }

  %% m66
  ""1

  ""8
  \markup \scaleDegree { 7 }8
  \markup \scaleDegree { 1 }
  \markup \scaleDegree { 2 }
  \markup \scaleDegree { 4 }8
  \markup \scaleDegree { 5 }
  \markup \scaleDegree { 6 }
  \markup \scaleDegree { f7 }

  \markup \scaleDegree { 5 }8
  \markup \scaleDegree { 6 }
  \markup \scaleDegree { 5 }4
  \markup \scaleDegree { n3 }
  ""4

  ""2
  ""8
  \markup \scaleDegree { s5 }8
  \markup \scaleDegree { 6 }4

  %% m70
  \markup \scaleDegree { 5 }4
  \markup \scaleDegree { 4 }8
  \markup \scaleDegree { f3 }
  \markup \scaleDegree { 6 }8
  \markup \scaleDegree { 5 }
  \markup \scaleDegree { 4 }
  ""8

  \markup \scaleDegree { 5 }4
  ""4
  \markup \scaleDegree { 1 }4
  ""8
  \markup \scaleDegree { f7 }8

  ""4
  \markup \scaleDegree { 3 }8
  \markup \scaleDegree { 2 }
  \markup \scaleDegree { s1 }4.
  \markup \scaleDegree { 7 }8

  \markup \scaleDegree { f5 }8
  \markup \scaleDegree { f6 }
  \markup \scaleDegree { n6 }
  \markup \scaleDegree { n7 }
  \markup \scaleDegree { s4 }8
  \markup \scaleDegree { 3 }
  \markup \scaleDegree { f3 }
  \markup \scaleDegree { 2 }

  %% m74
  \markup \scaleDegree { 5 }8
  \markup \scaleDegree { 5 }
  \markup \scaleDegree { 1 }
  \markup \scaleDegree { 2 }
  \markup \scaleDegree { f3 }
  \markup \scaleDegree { 4 }
  \markup \scaleDegree { s4 }
  \markup \scaleDegree { n3 }

  \markup \scaleDegree { 6 }8
  \markup \scaleDegree { s4 }
  \markup \scaleDegree { 5 }
  \markup \scaleDegree { s2 }
  \markup \scaleDegree { 4 }8
  \markup \scaleDegree { 5 }
  \markup \scaleDegree { 6 }
  \markup \scaleDegree { f7 }

  \markup \scaleDegree { 5 }8
  \markup \scaleDegree { 6 }
  \markup \scaleDegree { 7 }
  \markup \scaleDegree { 5 }
  \markup \scaleDegree { 6 }4
  ""4

  ""2..
  \markup \scaleDegree { 2 }8

  %% m78
  \markup \scaleDegree { 5 }4
  \markup \scaleDegree { f3 }8
  \markup \scaleDegree { 2 }
  \markup \scaleDegree { 1 }
  ""4.

  \markup \scaleDegree { f2 }8
  \markup \scaleDegree { f3 }
  \markup \scaleDegree { f4 }
  \markup \scaleDegree { f5 }
  \markup \scaleDegree { f6 }
  \markup \scaleDegree { f4 }
  \markup \scaleDegree { f3 }
  \markup \scaleDegree { f2 }

  \markup \scaleDegree { 5 }4
  \markup \scaleDegree { 6 }8
  \markup \scaleDegree { 7 }
  \markup \scaleDegree { 1 }
  \markup \scaleDegree { 2 }
  \markup \scaleDegree { 3 }
  \markup \scaleDegree { 4 }

  \markup \scaleDegree { 5 }4
  \markup \scaleDegree { 3 }
  ""2

  %% m82
  ""8
  \markup \scaleDegree { 5 }4.
  \markup \scaleDegree { f3 }8
  \markup \scaleDegree { 1 }
  \markup \scaleDegree { n7 }
  \markup \scaleDegree { 5 }

  \markup \scaleDegree { 4 }8
  \markup \scaleDegree { f7 }
  \markup \scaleDegree { 1 }
  \markup \scaleDegree { f2 }
  \markup \scaleDegree { f3 }
  \markup \scaleDegree { f4 }
  \markup \scaleDegree { f5 }
  ""8

  ""8
  \markup \scaleDegree { 7 }8
  \markup \scaleDegree { 1 }
  \markup \scaleDegree { 2 }
  \markup \scaleDegree { 3 }
  \markup \scaleDegree { 4 }
  \markup \scaleDegree { 5 }
  \markup \scaleDegree { 3 }

  \markup \scaleDegree { f5 }8
  \markup \scaleDegree { 3 }
  \markup \scaleDegree { 4 }
  \markup \scaleDegree { f3 }
  \markup \scaleDegree { f6 }8
  \markup \scaleDegree { 5 }
  \markup \scaleDegree { f5 }
  \markup \scaleDegree { 3 }

  %% m86
  \markup \scaleDegree { 1 }8
  \markup \scaleDegree { 2 }
  \markup \scaleDegree { f3 }
  \markup \scaleDegree { 4 }
  \markup \scaleDegree { f9 }8
  \markup \scaleDegree { f7 }
  \markup \scaleDegree { 8 }
  \markup \scaleDegree { 6 }

  \markup \scaleDegree { 4 }8
  \markup \scaleDegree { f3 }
  \markup \scaleDegree { n3 }
  \markup \scaleDegree { 2 }
  \tuplet 3/2 {
    \markup \scaleDegree { 5 }8
    \markup \scaleDegree { 7 }
    \markup \scaleDegree { 9 }
  }
  \markup \scaleDegree { 4 }8
  \markup \scaleDegree { 2 }

  \markup \scaleDegree { 7 }8
  \markup \scaleDegree { s6 }
  \markup \scaleDegree { 6 }
  \markup \scaleDegree { s5 }
  \markup \scaleDegree { 5 }
  \markup \scaleDegree { 4 }
  \markup \scaleDegree { 2 }
  \markup \scaleDegree { 3 }

  ""8
  \markup \scaleDegree { 4 }8
  \markup \scaleDegree { f6 }
  \markup \scaleDegree { f5 }
  \markup \scaleDegree { 1 }8
  \markup \scaleDegree { f7 }
  \markup \scaleDegree { f6 }
  \markup \scaleDegree { 5 }

  %% m90

}

%% %% Add harmonic analysis
%% harmonicAnalysis = \lyricmode {
%%  \override LyricText.font-name = #"serif"
%%  \set stanza = \markup \with-color #red  \fontsize #6 \keyIndication { VI }
%%  \markup \rN { V 7 / I }1
%%  \markup \rN { V 7 / ii }1
%%  \set stanza = \markup \with-color #darkgreen \fontsize #5 \keyIndication { II }
%%  \markup \rN { V 7 }1
%%  \markup \rN { V 7 }1
%% }

%% Chord names, chord tones, and harmonic analysis only
%% chordsAnalysisArpeg= {
%%  <<
%%    \new Lyrics \harmonicAnalysis
%%    \new ChordNames { \chordNamesHead }
%%    \new Staff {
%%      \global
%%      <<
%%        \scoreBreaks
%%        \chordNamesHead
%%      >>
%%    }
%%  >>
%% }

eFlatScore = \score {
  <<
    %% \new Lyrics \harmonicAnalysis  % add the harmonic harmonicAnalysis above the chord names
    \new ChordNames {
      % add the Chord Names above the staff
      \chordNamesIntroPartial % for intro_partial
      \chordNamesVolta

      \repeat unfold 2 { \chordNamesNoVolta }
    }
    \new Staff {
      \global
      %% the head
      \intro_partial
      \head
      %% \pageBreak
      \solo
    }
    %% add the scaleDegrees below the staff
    \new Lyrics {
      \scaleDegreesHead
    }
  >>
  \layout {
    indent = 0
  }
}

cScore= \score {
  \transpose c' ees {
  <<
    %% \new Lyrics \harmonicAnalysis  % add the harmonic harmonicAnalysis above the chord names
    \new ChordNames {
      % add the Chord Names above the staff
      \chordNamesIntroPartial % for intro_partial
      \chordNamesVolta

      \repeat unfold 2 { \chordNamesNoVolta }
    }
    \new Staff {
      \global
      %% the head
      \intro_partial
      \head
      %% \pageBreak
      \solo
    }
    %% add the scaleDegrees below the staff
    \new Lyrics {
      \scaleDegreesHead
    }
  >>
  }
  \layout {
    indent = 0
  }
}

sopScore= \score {
  \transpose bes ees {
  <<
    %% \new Lyrics \harmonicAnalysis  % add the harmonic harmonicAnalysis above the chord names
    \new ChordNames {
      % add the Chord Names above the staff
      \chordNamesIntroPartial % for intro_partial
      \chordNamesVolta

      \repeat unfold 2 { \chordNamesNoVolta }
    }
    \new Staff {
      \global
      %% the head
      \intro_partial
      \head
      %% \pageBreak
      \solo
    }
    %% add the scaleDegrees below the staff
    \new Lyrics {
      \scaleDegreesHead
    }
  >>
  }
  \layout {
    indent = 0
  }
}


%% \eFlatScore
%% \transposedScore