\version "2.24.2"

%% See here for a transcription
%% https://duckduckgo.com/?q=joe+henderson+on+song+for+my+father+solo+transcription&t=osx&ia=videos&iax=videos&iai=https%3A%2F%2Fwww.youtube.com%2Fwatch%3Fv%3D34q-8rkMWTg
%%
%% Measure numbers in solo are off by 92

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

tagline = "Bartev 2025-04"
copyright = #"Bartev 2025"

%%%%%%%%%%%%%%%%%%%% Boilerplate - Setup Page, title, header, etc.


title = #"Song For My Father"
meter = "128"
%% \concat spaces differently than if I didn't say \concat
instrument = \markup \with-color "blue" \concat {
  "(sop/ten B"
  \raise #0.5 \fontsize #-2 \flat ")"
}

composer = #"Horace Silver"
arranger = #"Real Book v1, 6th ed p394"

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
  \key g \minor
  
  %% \tempo 4=224  % this would be over the clef on the first line

  %% make only the first clef visible
  \override Score.Clef.break-visibility = #'#(#f #f #f) %%

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
introChords = \chordmode { s2 }
chordNamesBbInstrA = \chordmode {
  \repeat percent 2 g1:m7 \repeat percent 2 f1:7
  ees1:7 d1:7sus4 \repeat percent 2 g1:m7
}

chordNamesBbInstrB = \chordmode {
  \repeat percent 2 f1:7 \repeat percent 2 g1:m7
  f2:7 ees:7 d1:7 g1:m7 g1:m7
}

chordNamesBbInstrHead = \chordmode {
  %% A (with repeats)
  \repeat volta 2 {
    \repeat percent 2 g1:m7 \repeat percent 2 f1:7
    ees1:7 d1:7sus4 g1:m7
    \alternative {
      { g1:m7 }
      { g1:m7 }
    }
  }
  \chordNamesBbInstrB
}

chordNamesBbInstrExpanded = {
  \chordNamesBbInstrA
  \chordNamesBbInstrA
  \chordNamesBbInstrB
}



introBb = \relative c' { r8 d g bes }
headBb = \relative c'' {
  \markManualBox "Head"
  \repeat volta 2 {
    %% m1
    d8 \tuplet 3/2 { ees16 d c } bes8 c~ c \tuplet 3/2 { d16 c bes } g8 bes~
    bes8 \tuplet 3/2 { c16 bes g } f8 g~ g \tuplet 3/2 { a16 g f } d8 f~
    f1~
    f2. \ottava -1 a,8 aes
    \break
    
    %% m5
    
    g8 ees'~ ees2.
    \ottava 0
    r4 r8 g~ g4. a8~
    a1~
    \alternative {
      { a2 r8 d, g bes }
      { a2 r8 f f f}
    }
    \break    
  }
  \markManualBox "B"
  f8 ees4 g8~ g2~
  g2 r8 g g g
  g8 f4 a8~ a2~
  a2 r8 f f f
  \break
  
  f8 ees4 a8~ a2~
  a4 r bes4. c8~
  c1~
  c2 r8 \markManualBox "Solo" g bes c-.
  \break \bar "||"
}

introSolo = \relative c'' {}

soloBb= \relative c'' {
  
  %% \timestop "3:55"
  %% r8 g bes c-. r4 r8 bes
  %% c8 bes g-. r r g bes c~
  %% c8 bes f c'-. r4 r8 bes
  %% c8 bes~ bes4 r8 g bes c~
  %% \break
  %% 
  %% \timestop "4:02"
  %% c8 bes g des'~ des4 r 
  %% des8 c des4-. r8 g, bes des~
  %% des des4 des bes8 c4
  %% des8 bes g d f4. a8~
  %% \break \bar "||"
  %% 
  %% \markManualBox "A"
  %% a4~ a8 d,16 f g8 d16 f g8 d16 f
  %% g16 d f8 g d16 f g d f g d f g8
  %% d16 f g8  d16 f g8  d16 g a8~ a4
  %% r4 r16 a r a bes a bes8 r16 g bes g
  %% \break
  %% a8. g16 bes g a8_\markup{"wrong!"} r f a16 g a8
  %% r2 r8 g16 bes c cis d f
  %% g16 bes c cis   d bes c g   bes f a ees g a f c
  %% d4 s2.
  %% \break \bar "||"

  \timestop "3:55"
  %% m18
  r4 r8 bes c bes g-. r
  r8 g bes c~ c bes f c'-.
  r4 r8 bes c bes~ bes4
  r8 g bes c~ c8 bes g des'
  \break

  \timestop "4:02"
  %% m22
  r2  des8 c des4-.
  r8 g, bes des4 des des8~
  des8 bes c4 des8 bes g d
  f4. a2 d,16 f
  \break \bar "||"

  \markManualBox "A"
  \timestop "4:10"
  %% m26
  g8 d16 f   g8 d16 f g16 d f8 g d16 f
  g16 d f g  d f g8 d16 f g8  d16 f g8
  f16 g a8~   a4   r4   r16 a8 g16
  bes16 a bes8  r16 g bes g  a8 f16 g bes g a8
  \break

  \timestop "4:18"
  %% m30
  r8 f a16  aes a8 r2
  \tuplet 3/2 { r8 g bes } \tuplet 3/2 { c8 cis d }
  \tuplet 3/2 { f8 g bes } \tuplet 3/2 { c8 cis d }
  
  \tuplet 3/2 { bes8 c g } \tuplet 3/2 { bes f a }
  \tuplet 3/2 { f8 g a } \tuplet 3/2 { f8 c d }

  \tuplet 3/2 { bes8 c g } \tuplet 3/2 { bes g a }
  \tuplet 3/2 { d,8 f d } \tuplet 3/2 { ees8 d f~ }
  \break \bar "||"

  %% \repeat unfold 2 { s1*4 \break } \bar "||"
  \markManualBox "B"
  \timestop "4:25"
  f2 r
  s1
  s1
  s1
  \break
  \repeat unfold 1  { s1*4 \break } \bar "||"
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
      \partial 2 \introChords
      \chordNamesBbInstrHead % With repeat
      \repeat unfold 1 { \chordNamesBbInstrExpanded }
    }
    \new Staff {
      \global
      \introBb
      \headBb
      %% \pageBreak
      \soloBb \pageBreak
    }
  >>
  \layout { indent = 0 }
}

\myScoreBb
