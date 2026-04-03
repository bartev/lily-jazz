
\version "2.24.2"

#(set-global-staff-size 16)

\include "jazzchords.ily"
\include "lilyjazz.ily"
\include "jazzextras.ily"
\include "roman_numeral_analysis_tool.ily"
\include "bv_definitions.ily"

fall = \bendAfter #-4

%%%%%%%%%%%%%%%%%%%% Paper & Layout Settings

\paper {
  #(set-paper-size "letter")
  top-margin = 12\mm
  bottom-margin = 10\mm
  left-margin = 14\mm
  right-margin = 14\mm
  print-page-number = ##f
  indent = 0
}

\layout {
  \context {
    \Score
    \override RehearsalMark.font-family = #'jazz
    \override RehearsalMark.font-size = #5
    markFormatter = #format-mark-box-alphabet
  }
  \context {
    \ChordNames
    chordChanges = ##t
  }
}
o
%%%%%%%%%%%%%%%%%%%% Header

\header {
  title = "Dig Dis"
  composer = "Hank Mobley"
  arranger = "Bartev"
  instrument = "(sop/ten B♭)"
  meter = "148"
  tagline = "Bartev 2025-05"
  copyright = "Bartev 2025"
}

%%%%%%%%%%%%%%%%%%%% Music


%% See here for formatting text
%% https://lilypond.org/doc/v2.20/Documentation/notation/formatting-text



%% bv_definitions is in plugins/bv-lilyjazz/stylesheets.
%% It contains some useful functions such as:
%% timestop
%%   markManualBox
%%   markBlue
%%   blueChord
%%   redChord
%%   greenChord

%% set up title, compser, meter, copyright

tagline = "Bartev 2025-05"
copyright = #"Bartev 2025"

%%%%%%%%%%%%%%%%%%%% Boilerplate - Setup Page, title, header, etc.


title = #"Dig Dis"
meter = "148"
%% \concat spaces differently than if I didn't say \concat
instrument = \markup \with-color "blue" \concat {
  "(sop/ten B"
  \raise #0.5 \fontsize #-2 \flat ")"
}
composer = #"Hank Mobley"
arranger = #"Bartev"

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
introChords = \chordmode { \partial 2 s2 }
chordNamesEbInstr = \chordmode {
  \repeat percent 4 g1:min7 \break
  \repeat percent 2 c1:min7
  \repeat percent 2 g1:min7 \break
  ees1:7
  d1:7
  \repeat percent 2 g1:min7 \break
}

chordNamesBbInstr = \chordmode {
  \repeat percent 4 c1:min7 \break
  \repeat percent 2 f1:min7
  \repeat percent 2 c1:min7 \break
  aes1:7
  g1:7
  \repeat percent 2 c1:min7 \break
}

introBb = \relative c'' {
  \markManualBox "Head"
  \partial 2
  r8 c ees4
}

headBb = \relative c''' {
  %% m1
  \timestop "0:40"
  g4 r r ees
  f8 ees r4 r8 c ees f
  g4 g \tuplet 3/2 { g8 f ees } c8 c~
  c4 r4 r8 c ees4
  \break

  %% m5
  \timestop "0:47"
  f4 r r g8 ees
  f8 f r4 r8 c ees f
  g4 g \tuplet 3/2 { g8 f ees } c8 c~
  c4 r4 r8 c ees4
  \break

  %% m9
  \timestop "0:53"
  f4 r r ees
  f4 r \tuplet 3/2 { f8 ees c } bes4
  c4 r r r
  r2 r8 c ees4
  %% { s1*4 \break }
  \bar "||"

  \markManualBox "Head (2nd chorus)"
  %% m13
  \timestop "1:01"
  g4 r r ees
  f8 ees r4 r8 c ees f
  g4 g \tuplet 3/2 { g8 f ees } c8 c~
  c4 r4 r8 c ees4
  \break

  %% 17
  \timestop "1:07"
  f4 r r g8 ees
  f8 f r4 r8 c ees f
  g4 g \tuplet 3/2 { g8 f ees } c8 c~
  c4 r4 r8 c ees4
  \break

  %% m21
  \timestop "1:14"
  f4 r r ees
  f4 r \tuplet 3/2 { f8 ees c } bes4
  c4 r r r
  r2 r8 c \tuplet 3/2 { e8 g a }
  \bar "||"
  
  %% { s1*4 \break }
  %% \bar "||"
}

soloBb = \relative c''' {
  \markManualBox "Solo"
  %% m25
  \timestop "1:21"
  c4 c8 d  bes g r g
  a4 c8 aes\fall r2
  r8 c16 b bes8 a g f e d
  c8 b bes16 c e g a8 g r4
  \break

  %% m29
  \timestop "1:28"
  r8 c,16 d f8 g aes a bes b
  c8 a f d ees \fall r8 r4
  r8 bes'~ bes4 \grace {a16 aes} g8 f e d
  \tuplet 3/2 { des8 e g } bes a r2
  \break

  %% m33
  \timestop "1:34"
  r8 e' d a e d r4
  r8 ees'? des aes? ees? des r4
  r8 d'16 des c8 b bes a g ges
  f8 c' a f e d r4
  \break
  \bar "||"

  \pageBreak
  
  \markManualBox "Solo (2nd Chorus)"
  %% m37
  \timestop "1:40"
  r8 c ees f g4 g
  g4~ \tuplet 3/2 { g8 f ees } c8 ees r4
  r8 c ees f g2
  g4~ \tuplet 3/2 { g8 f ees } c8 c r4
  \break

  %% m41
  \timestop "1:48"
  \tuplet 3/2 { r8 a c } \tuplet 3/2 { ees8 g a } \tuplet 3/2 { d4 d d }
  d4 a8 ees r2
  r8 c ees f g bes r g
  \tuplet 3/2 { ges8 f ees } c8 c r2
  \break

  %% m45
  \timestop "1:54"
  r8 des8 d16 e f g a8 d, r4
  r8 bes8 d16 e f g bes8 ees, r4
  r8 e~ \tuplet 3/2 { e16 g a } c8 f,4~ \tuplet 3/2 { f16 g a } c8
  ges4~ \tuplet 3/2 { ges16 g a } c8 g4 c8 d
  \break
  \bar "||"

  \markManualBox "Solo (3rd Chorus)"
  %% m49
  \timestop "2:00"
  c4 c2 r8 ees
  c8 c r4 r a
  c4 c8-. r r c16 b bes8 a
  g8 f e16 g bes d c4~ c8 bes
  \break

  %% m53
  \timestop "2:08"
  a4 f8 r r c16 f \tuplet 3/2 { a8 c d }
  ees4 d8 ees16 d c8 bes g f
  e4~ e8 c'~ c4 r
  r8 bes16 a g8 f e d des a
  \break

  %% m57
  \timestop "2:15"
  d4 a' f8 d r a
  des8 a c4 b~ b8 d16 a'
  g8 f e d c r r4
  r4 r8 c f4~ f8 e
  \break
  \bar "||"

  \markManualBox "Solo (4th Chorus)"
  \timestop "2:22"
  %% m61
  c8 c r4 r8 c f \grace { g16 f } e8
  c8 c r c f e c a
  c2 r8 c e16 g bes d
  c8 b bes a g \grace { g16 f } e8 ees des
  \break

  %% 65
  \timestop "2:28"
  \tuplet 3/2 { c8 r c } \tuplet 3/2 { ees c ees } \tuplet 3/2 { g ees g } \tuplet 3/2 { b g b }
  d4~ d8 \tuplet 3/2 { b16 g ees } b2
  r4 r8 e32 g b d c8 b a aes
  g8 f e d des bes'? a e
  \break

  %% 69
  \timestop "2:35"
  g4 a8 f~ f4~ \tuplet 5/2 { f8 e d c a }
  e'4 f8 d~ d4 r8 a
  d8 ees16 d a8 g c2
  r4 a' c8 d c a
  \break
  \bar "||"

  \markManualBox "Solo (5th Chorus)"
  c4 r e, r
  f4 r ges r
  s1
  s1
  \break

  { s1*4 \break }
  { s1*4 \break }
  \bar "||"
  \pageBreak


  \markManualBox "Solo (6th Chorus)"
  { s1*4 \break }
  { s1*4 \break }
  { s1*4 \break }
  \bar "||"

  \markManualBox "Solo (7th Chorus)"
  { s1*4 \break }
  { s1*4 \break }
  { s1*4 \break }
  \bar "||"

  \markManualBox "Solo (8th Chorus)"
  { s1*4 \break }
  { s1*4 \break }
  { s1*4 \break }
  \bar "||"

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
      \introChords
      \repeat unfold 10 \chordNamesBbInstr % With repeat
    }
    \new Staff {
      \global
      \introBb
      \headBb
      \soloBb
      %% \pageBreak \soloEb
    }
  >>
  \layout { indent = 0 }
}

\myScoreBb



