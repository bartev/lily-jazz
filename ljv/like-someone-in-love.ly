\version "2.24.2"

%% See here for a transcription in C
%% https://www.slideshare.net/slideshow/like-someone-in-love-dick-oatts-standard-time/6431754#3
%% Measure numbers are off by 28

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

tagline = "Bartev 2025-01"
copyright = #"Bartev 2025"

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
  %% \tempo 4=224  % this would be over the clef on the first line

  %% make only the first clef visible
  \override Score.Clef.break-visibility = #'#(#f #f #f) %%

  %% Make the signature visible at each line break
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
chordNamesAB = \chordmode {
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
}

chordNamesAC = \chordmode {
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
  \markManualBox "A: Head Chorus 1 (in C)"
  \key a \major
  \bar ".|"
  %% m1
  r4 cis cis4. bis8
  cis4 r fis8 e cis b~
  b2 r8 gis'4 e8~
  e2 r
  \break

  \timestop "0:07"
  %% m5
  r1
  r8 d r a' gis4 fis
  e4 e e cis'
  b2 r
  \break
  \bar "||"

  \markManualBox "B"
  \timestop "0:12"
  %% m9
  r2 r4 r8 ais8
  \tuplet 3/2 { cis4 b ais~ } ais4~ \tuplet 3/2 { ais8 gis eis } 
  \tuplet 3/2 { dis4 gis eis~ } eis2
  r1
  \break

  \timestop "0:17"
  %% m13
  r8 fis r a \tuplet 3/2 { a4 gis b~ }
  b4 a8 gis~ gis4 fis8 e~
  e4 d8 a' cis, b r8 g'8~
  g4 f8 a, e'4 d
  \break
  \bar "||"
  
  \markManualBox "A (modulate key to Eb)"
  \timestop "0:22"
  %% m17
  \key c \major
  e4 e2 r4
  r8 a, e' a g4 e
  c2. r8 c'8
  g2 r2
  \break

  \timestop "0:28"
  %% m21
  r4 r8 f r g a c
  b4 b2~ b8 a
  g4. fis8 g4 e'
  \tuplet 3/2 { d2 c4 } \tuplet 3/2 { bes4 a g }
  \break
  \bar "||"

  \markManualBox "C"
  \timestop "0:33"
  %% m25
  r4 r8 d' r d cis d
  \tuplet 3/2 { e4 d cis~ } cis4 b8 e,
  r8 e r b e4 e
  fis2 r
  \break

  \timestop "0:38"
  %% m29
  r4 g g g8 e
  f4 c' b g8 c
  r8 c4 b16 a g8 e d c
  d8 fis a fis gis b f dis
  \break
  \bar "|."

  \markManualBox "Head - Chorus 2 (back to C)"
  \timestop "0:43"
  \key a \major
  %% m33
  e8 cis r cis cis2
  r8 b cis a' fis4 cis
  b4 r r8 cis d cis
  r8 d e f r e dis e8
  \break

  \timestop "0:49"
  %% m37
  a8 fis r cis e d r a
  cis4 e b2
  r2. b'8 bes
  a8 g b, d fis a e cis
  \break
  \bar "||"
  
  \markManualBox "B"
  \timestop "0:54"
  %% m41
  ais8 gis a g fis e' r cis'
  r8 b8 ais gis8~ gis4 eis8 dis~
  dis4 gis8 eis4. r4
  r1
  \break

  \timestop "0:59"
  %% m45
  r2 cis'4 gis8 b
  a8 cis, f gis fis gis a b
  cis8 d e ees d cis b bes
  a8 f e d g dis b gis
  \break
  \bar "|."

  \markManualBox "A (modulate to Eb)"
  \timestop "1:05"
  \key c \major
  %% m49
  g8 f' e c d c b c
  ees8 e g fis f g a b
  c8 a b d gis,4. fis8
  g8 e c b bes f'~ f4
  \break

  \timestop "1:10"
  %% m53
  e4 a, g r
  r2 r8 e \tuplet 3/2 { g8 b e }
  g8 e f g16 f e8 d c b
  bes8 c d f a g e c
  \break
  \bar "||"

  \markManualBox "C"
  \timestop "1:16"
  %% m57
  g'8 f e f a c r bes
  b8 a gis b, d f d dis
  e8 cis b a gis a cis e
  g8 fis g2 r4
  \break

  \timestop "1:21"
  %% m61
  r8 e4 r8 g e c a
  d8 e f g e4 e
  c4 r r8 a \tuplet 3/2 { bes8 e g }
  f8 gis b cis c g f dis
  %% The transcription feels off, but I want to hit the c on the downbeat
  %% c4 r r8 a \tuplet 3/2 { bes8 cis e }
  %% a8 f gis b \grace cis c g f dis
  \break
  \bar "|."

  \markManualBox "Head - Chorus 3 (back to C)"
  \timestop "1:26"
  \key a \major
  %% m65
  e8 cis' a e  d4 b'
  a4 cis, b gis'
  fis4 a, gis e'8 fis
  e4 r r2
  \break

  \timestop "1:32"
  %% m69
  r8 cis'16 a fis8 d cis b ais b
  g'8 fis f cis c gis g f
  e8 g b d fis dis e fis
  g8 a bes gis a fis cis g
  \break

  \timestop "1:39"
  %% m73
  a8 g' e eis fis gis ais b
  cis8 cis b b ais4. gis8
  f8 f dis dis gis2
  r1
  \break

  \timestop "1:46"
  %% m77
  r8 cis g8 gis b bes a bes
  cis8 e gis a r e dis cis
  b8 cis d ais cis ais b cis
  \tuplet 3/2 { d8 dis e } c8 b a aes g f
  \bar "||" \break

  \key c \major
  e4 r8 b' c4 r8 g
  f8 fis a aes g g, c e
  f8 dis e d \tuplet 3/2 { cis16 d cis } aes8 g fis
  e4 r r2
  \break

  r4 a8 a c4 e
  g2 g4. f8
  e8 f g a bes d, e f
  a8 b f ais gis e fis cis
  \break

  c8 bes' a g f g a c
  cis e d ais cis b gis fis
  e4 e e e
  fis4 fis b a
  \break

  e4 f8 g~ g2
  r2 e16 f g f e ees d des
  c16 a g f e8 a16 b d8 b \tuplet 3/2 { c8 d e }
  dis16 d e fis a cis c e d cis c a32 gis g16 f e d
  \bar "||" \break

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
      \repeat unfold 3 {
        \transpose ees c { \chordNamesAB }
        \chordNamesAC
      }
    }
    \new Staff {
      \global
      \headEb
      \pageBreak
    }
  >>
  \layout { indent = 0 }
}

\myScore
