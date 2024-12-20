\version "2.24.0"

%% Checked against Bobby Stern Jazz transcription
%% https://bobbysternjazz.com/uploads/3/4/4/5/34450459/night___day_-_joe_henderson_transcription__bb__bsj.pdf

%% Also see youtube transcription (slightly different)
%% https://www.youtube.com/watch?v=WO7zI-mTtZU

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
title = #"Resolution - A Love Supreme Part II"
composer = #"John Coltrane"
arranger = #"E\flat"
tagline = "John Coltrane transcription 2024-04"
meter = "180"
copyright = #"Bartev 2024"

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

%% 48 measures (3 x 16)
chordNamesHead = \chordmode {
  %% A

  %% 8 bar form ?
    %% A
    %% 1-4
    \repeat percent 2 { c1:min }
    c2:min aes:sus7
    aes1:sus7

    %% 5-8
    \repeat percent 2 { d1:7.9+ }
    c1:min
    g1:7


    %% B
    %% 9-12
    \repeat percent 2 { c1:min }
    c2:min aes:sus7
    aes1:sus7

    %% 13-16
    \repeat percent 2 { d1:7.9+}
    \repeat percent 2 { g1:7.9- }


    %% C
    %% 17-20
    \repeat percent 2 { c1:min }
    c2:min aes:sus7
    aes1:sus7

    %% 21-24
    \repeat percent 2 { d1:7.9+}
    c1:min7.5-
    g1:7

    %% Bridge?
    %% 25-28
    %% \repeat percent 4 { c1:m9 }
    \repeat percent 2 { c1:min }
    c2:min aes:sus7
    aes1:sus7

    %% 29-32
    %% \repeat percent 4 { c1:m9 }
    \repeat percent 2 { d1:7.9+}
    c1:min7.5-
    g1:7

}

%% intro_partial_chords = \chordmode { s2 }
%% intro_partial= \relative c'' {
%%   \partial 2
%%   r4 g8 c8~
%% }

leadMusic = \relative c''' {
  \bar ".|-|"
  \markManualBox "Head"
  \timestop "0:22"
  \appoggiatura { g8 } c1~
  %% g8 c~ c4~ c2~
  c2 g8 c bes aes
  g4. fis8~ fis2~
  fis2 r4 r8 f16 fis
  \break

  \timestop "0:27"
  f1~
  f8 ees d ees d c b g
  ees'8 \parenthesize c ees ees c4 bes8 c~
  c2 r2
  \bar "|."
  \break

  \markManualBox "A"
  \timestop "0:33"
  \appoggiatura { g'8 } c1~
  c2 g8 c bes aes
  g4 bes8 fis~ fis2~
  fis2 r4 r8 fis8
  \break

  \timestop "0:38"
  f16 fis f8~ f4~ f2~
  f8 ees d ees d c b bes
  b2 aes8 ees f4~
  f2 r2
  \bar "|."
  \break

  \markManualBox "A"
  \timestop "0:44"
  \appoggiatura { g'8 } c1~
  c2 g8 c bes aes
  g4 g8 fis~ fis2~
  fis2 r4 r8 f16 fis
  \break

  \timestop "0:49"
  f2~ f8 ees d ees
  d4~ d8 c b aes bes4~
  bes4 g8 bes fis4 bes,8 c8~
  c2 r4 g''8 bes
  \break

  \markManualBox "Bridge"
  \timestop "0:55"
  bes8 g r c~ c f,8~ f4~
  f4~ f8 ees d bes8~ bes4
  r4 r8 bes c ees f aes
  f8 ees f8 ees~ ees4~ ees8 c16 ees
  \break

  \timestop "1:00"
  c8 bes aes8 ees'~ ees c ees c~
  c8 bes c bes~ bes4~ bes8 g
  ees'8 c~ c4 r2
  r4 r8 g' f4. c8
  \pageBreak \bar "|."


  \markManualBox "Solo"
  \timestop "1:05"
  \tuplet 3/2 { g'4 c c } ees8 f8~ f8 d8~
  d4~ d8 c8 bes g8~ g4~
  g8 r r4 r8 bes8 a g
  ees8 f g8 a f4~ f8 ees
  \break

  \timestop "1:11"
  \tuplet 3/2 { c8 g c } \tuplet 3/2 { ees c ees } \tuplet 3/2 { f ees  f} \appoggiatura { ees8 } c4~
  c4~ c8 \appoggiatura { g16 } ees'8 d c  bes g8
  d'8 bes g f c4 f8 c8~
  c4 r4 r4 g''8 g
  \break \bar "|."

  \timestop "1:17"
  c1~
  c2 g8 c bes aes
  g4. f8( fis2~ )
  fis2 r4 r8 f16 fis
  \break

  \timestop "1:22"
  f16 fis f4.~ f2~
  f8 ees d ees d c b g
  ees'8 \parenthesize c ees ees c4 bes8 c~
  c2 r4 g'4
  \break
  \bar "|."

  \timestop "1:28"
  c1~
  c2 g8 c bes aes
  g4. fis8~ fis2~
  fis2 r4 r8 f16 fis
  \break

  \timestop "1:34"
  f16[ f f f~ ] f4~ f2~
  f8 ees d ees d c b bes
  b2 aes8 ees f4~
  \override Glissando.style = #'zigzag
  f2 aes2 \bendAfter #-6
  %% \cadenzaOn
  %% aes4\glissando
  %% \hideNotes
  %% c,4
  %% \unHideNotes
  %% \cadenzaOff
  \break
  \bar "|."

  \timestop "1:40"
  r4 r8 g'8 c4 g8 c8
  r16 c c8~ c4 g8 c bes aes
  g4 bes8 fis~ fis2~
  fis4 r4 r4 r8 f16 fis
  \break

  \timestop "1:45"
  f4 ees8 d~ d2~
  d8 ees d c b c bes4~
  bes4 fis8 aes fis2
  bes,8 c~ c4~ c4 r
  \pageBreak \bar "|."


  \markManualBox "Solo"
  \timestop "4:39"

  \repeat unfold 4 { s1 } \break
  \repeat unfold 4 { s1 } \break \bar "|."

  \repeat unfold 4 { s1 } \break
  \repeat unfold 4 { s1 } \break \bar "|."

  \repeat unfold 4 { s1 } \break
  \repeat unfold 4 { s1 } \break \bar "|."

  \repeat unfold 4 { s1 } \break
  \repeat unfold 4 { s1 } \break \bar "|."
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
      %% \set chordChanges = ##f
      %% \intro_partial_chords
      \repeat unfold 3 { \chordNamesHead }

    }
    \new Staff {
      \global
      %% \intro_partial
      \leadMusic

    }
  >>
  \layout {
    indent = 0
  }
}

\myScore
