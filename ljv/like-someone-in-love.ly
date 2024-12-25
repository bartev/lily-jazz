\version "2.24.2"

%% See here for formatting text
%% https://lilypond.org/doc/v2.20/Documentation/notation/formatting-text

%% set to 18 to fit entire head and title on 1 page
#(set-global-staff-size 16)
\include "jazzchords.ily"
%% \include "lilyjazz.ily"
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

tagline = "Bartev 2024-12"
copyright = #"Bartev 2024"

%%%%%%%%%%%%%%%%%%%% Boilerplate - Setup Page, title, header, etc.


title = #"Like Someone In Love"
meter = "180"
%% \concat spaces differently than if I didn't say \concat
instrument = \markup \with-color "blue" \concat {
  "Alto (E "
  \raise #0.5 \fontsize #-2 \flat ")"
}
composer = #"Van Heusen/Burke"
arranger = #"Real Book v1, 5th ed p 262"

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
  ragged-last-bottom = ##f
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
chordNames = \chordmode {
  %% Chorus 1
  c2:maj7 e:7
  a1:m7
  fis2:7.5- f2:7.9+
  e2:m7 a:7.9-

  d1:m7
  fis2:m7 b:7
  e1:m7
  g2:m7 c:7

  f1:maj7
  b2:m7 e:7
  a1:maj7
  a1:maj7

  a1:m7
  d1:7
  d1:m7
  g1:7+ % :7+ is augmented 7 chord (flat 7, sharp 5)

  %% Chorus 2 (Different final 8 bars)
  c2:maj7 e:7
  a1:m7
  fis2:7.5- f2:7.9+
  e2:m7 a:7.9-

  d1:m7
  fis2:m7 b:7
  e1:m7
  g2:m7 c:7

  f1:maj7
  b2:m7 e:7
  a1:maj7
  dis1:dim

  e2:m7 a:7.9-
  d2:m7 g:7
  c1:6 % 1 3 5 6
  d2:7 g:7

}

headEb = \relative c'' {
  \markManualBox "Head - Chorus 1"
  \bar ".|"
  %% m1
  \repeat unfold 4{ s1*4 \break }
  \bar "||"
  \markManualBox "Head - Chorus 2"
  \repeat unfold 4{ s1*4 \break }
  \bar "||"
  \break

  %% %% m5
  %% \repeat unfold 4{ s1*4 \break }
  %% "||" \bar
  %% \break
  %%
  %% %% m9
  %% \repeat unfold 4{ s1*4 \break }
  %% "||" \bar
  %% \break
  %%
  %% %% m13
  %% \repeat unfold 4{ s1*4 \break }
  %% "||" \bar
  %% \break
  %%
  %% %% m17
  %% \repeat unfold 4{ s1*4 \break }
  %% "||" \bar
  %% \break
  %%
  %% %% m21
  %% \repeat unfold 4{ s1*4 \break }
  %% "||" \bar
  %% \break
}

solo = \relative c' {
  \markManualBox "Scales"


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
      \repeat unfold 1 {\chordNames}
    }
    \new Staff {
      \global
      \headEb
      \pageBreak
      %% \solo
    }
  >>
  \layout { indent = 0 }
}

\myScore
