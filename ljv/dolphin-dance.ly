\version "2.24.2"

%% See here for formatting text
%% https://lilypond.org/doc/v2.20/Documentation/notation/formatting-text

%% set to 18 to fit entire head and title on 1 page
#(set-global-staff-size 16)
\include "jazzchords.ily"
\include "lilyjazz.ily"
\include "jazzextras.ily"
\include "roman_numeral_analysis_tool.ily"
\include "bv_definitions.ily"

%% bv_definitions is in plugins/bv-lilyjazz/stylesheets.
%% It contains some useful functions such as:
%% timestop
%%   markManualBox
%%   markBlue
%%   blueChord
%%   redChord
%%   greenChord

%% set up title, compser, meter, copyright

tagline = "Bartev 2025-01"
copyright = #"Bartev 2025"

%%%%%%%%%%%%%%%%%%%% Boilerplate - Setup Page, title, header, etc.


title = #"Dolphin Dance"
meter = "100?"
%% \concat spaces differently than if I didn't say \concat
instrument = \markup \with-color "blue" \concat {
  "Alto (E "
  \raise #0.5 \fontsize #-2 \flat ")"
}
composer = #"Herbie Hancock"
arranger = #"Real Book v1, 5th ed p122"

realBookTitle = \markup {
  \score {
    {
      \override TextScript.extra-offset = #'(0 . -6) % Adjust vertical position (X . Y)
      s^\markup {
        \fill-line {
          %% Left side: Meter and instrument
          \vcenter { % Center everything vertically
            \column {
              %% Meter
              {\fontsize #2 \lower #2 \rotate #7 \concat { \note { 4 } #1  " = " #meter }}
              {\fontsize #1 \instrument}
            }
          }
          %% Center: Title
          %% Title
          \vcenter {
            \fontsize #7 % Bigger number is larger font
            \override #'(thickness . 6)
            { \override #'(offset . 18) % Add space above the underline (raises text)
              \underline
              #title
            }
          }
          %% Right side: Composer and Arranger
          \vcenter {
            \right-column {
              \fontsize #3 \lower #1 \concat { #composer " " }
              \fontsize #0 \lower #1 \concat { #arranger " " }
            }
          }
        }
      }
    }
    \layout {
      \omit Staff.Clef
      \omit Staff.TimeSignature
      \omit Staff.KeySignature
      ragged-right = ##f
      ragged-bottom = ##f
      ragged-last-bottom = ##t
      \override Score.BarLine.transparent = ##t  % Remove barline at the end of the staff
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
  %% arranger = \arranger
  %% instrument = \instrument
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
  \key a \major
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

%% Define the chords here. The same chords will be used for chord names and notes

chordNamesIntro = \chordmode {
  %% Intro
  c1:maj7
  bes1:maj7
  c1:maj7
  b2:m7.5- e:7.9-
}

chordNamesHead = \chordmode {
  %% A
  a1:m7
  f1:maj7.11+
  a1:m7
  fis2:m7 b:7

  e1:maj7
  f:m7
  d:m7
  d2:m7  e:7.5+

  \repeat percent 2 a1:m7
  fis1:m7
  b1:7

  %% B
  e1:maj7
  e1:sus7
  fis1:m7
  b1:7

  d1:sus7
  b1
  d1:sus7
  cis2:m7 fis:7

  %% C
  c1:7
  fis2:m7 b:7
  gis1:m7
  cis2:7 b:m7
  bes1:m7
  ees1:7

  %% D
  b1:maj7
  a1:maj7
  b1:maj7
  a1:maj7

  bes1:maj7
  g1:13.9-
  f1:maj7.5+
  e1:7.5+
}

arpeggios= \relative c'' {
  \markManualBox "Intro"
  \bar ".|"

  %% m1 - Intro
  c8 e g b~ b2
  bes,8 d f a~ a2
  c,8 e g b~ b2
  b,8 d f a e gis b d
  \bar "||"
  \break

  \markManualBox "A"
  %% m5 A section
  a,8 c e g~ g2
  f,8 a b e~ e2
  a,8 c e g~ g2
  fis,8 a cis e b dis fis a
  \break

  %% m9
  e,8 gis b dis~ dis2
  f,8 aes c ees~ ees2
  d,8 f a c~ c2
  d,8 f a c e gis bis d
  \break

  %% m13
  a,8 c e g~ g2
  a,8 c e g~ g2
  fis,8 a cis e~ e2
  b8 dis fis a~ a2
  \break

  \markManualBox "B"
  %% m17 B section
  e,8 gis b dis~ dis2
  e,8 gis b d~ d2
  fis,8 a cis e~ e2
  b8 dis fis a~ a2
  \break

  %% m21
  d,8 fis g c~ c2
  b,8 dis fis ais~ ais2
  d,8 fis g c~ c2
  cis,8 e gis b fis8 ais cis e

  \break

  \markManualBox "C"
  %% m25 C section
  c,8 e g bes~ bes2
  fis,8 ais cis e b8 dis fis a
  \break

  %% m27
  gis,8 b dis fis~ fis2
  cis,8 e gis b b d fis a


  %% m29
  bes,8 des f aes~ aes2
  ees8 g bes des~ des2
  \break

  \markManualBox "D"
  %% m31 D section
  b,8 dis fis a~ a2
  a,8 cis e g~ g2
  b,8 dis fis a~ a2
  a,8 cis e g~ g2
  \break


  %% m35
  bes,8 d f a~ a2
  g,8 b d f aes c ees r
  f,,8 a cis e~ e2
  e8 gis bis d~ d2
  \break

  \bar "|."
  \break
}

intro = \relative c'' {
  \markManualBox "Intro"
  \bar ".|"

  %% m1 - Intro
  \repeat unfold 1 { s1*4 \break } \bar "||"
}

headEb = \relative c'' {
  \markManualBox "A"
  %% m5 A section
  \repeat unfold 1 { s1*4 \break }

  %% m9
  \repeat unfold 1 { s1*4 \break }

  %% m13
  \repeat unfold 1 { s1*4 \break } \bar "||"

  \markManualBox "B"
  %% m17 B section
  \repeat unfold 1 { s1*4 \break }

  %% m21
  \repeat unfold 1 { s1*4 \break } \bar "||"

  \markManualBox "C"
  %% m25 C section
  \repeat unfold 1 { s1*3 \break }

  %% m29
  \repeat unfold 1 { s1*3 \break } \bar "||"

  \markManualBox "D"
  %% m31 D section
  \repeat unfold 1 { s1*4 \break }

  %% m35
  \repeat unfold 1 { s1*4 \break }
  \bar "|."
  \break
}

myScore = \score {
  <<
    %% \new Lyrics \harmonicAnalysis  % add the harmonic harmonicAnalysis above the chord names
    %% \new ChordNames { \repeat unfold 1 \chordNamesHead }  % add the Chord Names above the staff
    %% \pageBreak
    \new ChordNames \with {
      \consists Percent_repeat_engraver
      \override PercentRepeat.Y-offset = 1
    }
    {
      %% Arpeggios
      \chordNamesIntro
      \chordNamesHead

      %% Head
      \chordNamesIntro
      \chordNamesHead

    }
    \new Staff {
      \global
      \arpeggios
      \pageBreak
      \intro
      \headEb
      %% \solo
    }
  >>
  \layout { indent = 0 }
}

\myScore
