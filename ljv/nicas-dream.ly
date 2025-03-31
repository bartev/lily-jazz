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

tagline = "Bartev 2025-04"
copyright = #"Bartev 2025"

%%%%%%%%%%%%%%%%%%%% Boilerplate - Setup Page, title, header, etc.


title = #"Nica's Dream"
meter = "180"
%% \concat spaces differently than if I didn't say \concat
instrument = \markup \with-color "blue" \concat {
  "(sop/ten B"
  \raise #0.5 \fontsize #-2 \flat ")"
}
composer = #"Horace Silver"
arranger = #"Real Book v1, 5th ed p 319"

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
  \key c \minor
  %% \tempo 4=224  % this would be over the clef on the first line

  %% make only the first clef visible
  \override Score.Clef.break-visibility = #'#(#f #f #f)

  %% make only the first time signature visible --  #'#(#f #f #f)
  %% Make the signature visible at each line break -- #'#(#f #f #t)
  \override Score.KeySignature.break-visibility = #'#(#f #f #t)
  
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
introChords = \chordmode { s4 }
chordNamesBbInstr = \chordmode {
  %% A
  \repeat volta 2 {
    \repeat percent 2 c1:maj7.3- \repeat percent 2 bes1:maj7.3-
    \repeat percent 2 c1:maj7.3- bes1:m7 ees1:7
    bes1:m7 ees:7 aes:maj7 d:7.9+.5+
    \repeat percent 2 g1:7.5+
    c1:maj7.3-
    \alternative {
      { c1:maj7.3- }
      { c1:maj7.3- }
    }
    
  }
  
  %% B
  \repeat percent 2 bes1:7sus4 g1:m7.5- c1:7.5+
  f1:7 bes1:7  ees1:maj7 fis2:m7 b2:7
  \repeat percent 2 bes1:7sus4 g1:m7.5- c1:7.5+
  f1:7 bes1:7  ees1:maj7 d2:m7.5- g:7.9-
}

chordNamesBbInstrA = \chordmode {
  \repeat percent 2 c1:maj7.3- \repeat percent 2 bes1:maj7.3-
  \repeat percent 2 c1:maj7.3- bes1:m7 ees1:7
  bes1:m7 ees:7 aes:maj7 d:7.9+.5+
  \repeat percent 2 g1:7.5+
  \repeat percent 2 c1:maj7.3-
}
chordNamesBbInstrB = \chordmode {
  %% B
  \repeat percent 2 bes1:7sus4 g1:m7.5- c1:7.5+
  f1:7 bes1:7  ees1:maj7 fis2:m7 b2:7
  \repeat percent 2 bes1:7sus4 g1:m7.5- c1:7.5+
  f1:7 bes1:7  ees1:maj7 d2:m7.5- g:7.9-
}
chordNamesBbInstrExpanded = {
  \chordNamesBbInstrA
  \chordNamesBbInstrA
  \chordNamesBbInstrB
}

introBb = \relative c'' { \markManualBox "Head" g4 }
headBb = \relative c'' {
  \markManualBox "A"
  \repeat volta 2 {
    \bar ".|:" % Start repeat
    %% m1
    d1~
    d2 \tuplet 3/2 { c4 g ees }
    g1~
    g2. g4
    \break

    %% m5
    \tuplet 3/2 { d'4  ees b } d2~
    d2 \tuplet 3/2 { c4 g ees }
    \tuplet 3/2 { f4 g ees } f2~
    f2. ees4
    \break

    %% m9
    c'1~
    c2 \tuplet 3/2 { bes4 g ees }
    f1~
    f2 r
    \break

    %% m13
    f8 ^\markup \sans \small {"(D-7" \flat "5)"} g f g aes2~
    aes2  ^\markup \sans \small {"(G7alt)"} g4 ees8 d~
    d1~
    \alternative {
      { d2. g4 }
      { d2. r4 }
    }
    \break
  }
  
  \markManualBox "B"
  %% m17
  r4 ^\markup \sans \small {"(F-7)"} g ees4. f8
  g4 ^\markup \sans \small {"(B" \flat "7)"} ees2 f4
  g4 aes bes c8 des~
  des2 ^\markup \sans \small {"(C7" \flat "9)"}  r8 c4.
  \break

  %% m21
  b4 ^\markup \sans \small {"(F-7)"}  c8 c, r8 ees4 f8
  g4 ees2 d8 f~
  f1
  gis8 e fis gis?~ gis2  ^\markup \sans \small {"(B7" \flat "13)"} 
  \break

  %% m25
  r4 ^\markup \sans \small {"(F-7)"} g ees4. f8
  g4 ^\markup \sans \small {"(B" \flat "7)"} ees2 f4
  g4 ^\markup \sans \small {"(E" \flat "M7)"} aes bes c8 des8~
  des2 ^\markup \sans \small {"(C7" \flat "9)"}  r8 c4.
  \break

  %% 29
  b4 c8 c, r8 ees4 f8
  g4 ees2 d8 f~
  f1 
  r8 g fis8 g ees'4 b8 d_\markup \right-align \marksans { "D.C. al 2nd ending" }
  \break
}

scalesBb = \relative c' {
  \markManualBox "Scales"
  c8 d ees f g a b c
  s1
  bes8 c des ees f g a bes
  s1
  \break
  c,,8 d ees f g a b c
  s1
  bes8 c d ees f g aes bes
  ees,,8 f g aes bes c des ees
  \break

  bes8 c des ees f g aes bes
  ees,,8 f g aes bes c des ees
  aes,8 bes c des ees f g aes
  d,,8 _\markup \marksans {"Altered scale"} ees f ges aes bes c d
  \break

  g,8 _\markup \marksans "Whole tone"  a b cis dis f g4
  g,8 _\markup \marksans "Altered" aes bes b des ees f g
  c,,8 d ees f g a b c
  s1
  \bar "||"
  \break

  %% A section
  \markManualBox "A"
  \repeat unfold 4 { s1*4 \break } \bar "||"

  %% B section
  \markManualBox "B"
  
  bes8 c d ees f g aes bes
  s1
  g,8 _\markup \marksans "Loc nat 2" a bes c des ees f g
  c,8 _\markup \marksans "Altered" des ees  e ges aes bes c
  \break

  f,,8 g a bes c d ees f
  bes,8 c d ees f g aes bes
  ees,,8 f g aes bes c d ees
  fis,16 gis a b cis dis e fis  b,! cis! dis! e! fis! gis! a! b!
  \break

  s1 s1 s1 s1 \break
  s1 s1 s1
  d,,16 _\markup \marksans "Loc nat 2"  e f g aes bes c d   g, _\markup \marksans "H/W dim" aes bes b cis d ees f
  \break \bar "||"
  %% \repeat unfold 2 { s1*4 \break } \bar "||"
}

soloBb = \relative c'' {
  \markManualBox "Solo"

  %% \markManualBox "A"
  \repeat unfold 4 { s1*4 \break } \bar "||"
  \markManualBox "A"
  \repeat unfold 4 { s1*4 \break } \bar "||"
  \markManualBox "B"
  \repeat unfold 4 { s1*4 \break } \bar "||"
}


myScoreBb = \score {
  <<
    %% \new Lyrics \harmonicAnalysis  % add the harmonic harmonicAnalysis above the chord names
    %% \new ChordNames { \repeat unfold 1 \chordNamesHead }  % add the Chord Names above the staff
    %% \pageBreak
    \new ChordNames \with {
      \consists Percent_repeat_engraver
      \override PercentRepeat.Y-offset = 1
    }
    {
      \partial 4 \introChords
      \chordNamesBbInstr % With repeat
      \repeat unfold 2 {\chordNamesBbInstrExpanded}
    }
    \new Staff {
      \global
      \partial 4 \introBb
      \headBb \pageBreak
      \scalesBb \pageBreak
      \soloBb
    }
  >>
  \layout { indent = 0 }
}

\myScoreBb
