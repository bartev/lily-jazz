\version "2.24.0"

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
%% markManualBox
%%   markBlue
%%   blueChord
%%   redChord
%%   greenChord

%% set up title, compser, meter, copyright
title = #"Viva la Vida"
composer = #"Coldplay"
arranger = #"E\flat"
tagline = "Bartev 2024-10"
meter = "130"
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
chordNamesIntro = \chordmode {
  bes1:sus2 c1 f1 d1:m7
  bes1:sus2 c1 f1 d1:m7
}

chordNamesVerse = \chordmode {
  bes:maj7 c1:7sus4 f1 d1:m7
  bes:maj7 c1:7sus4 f1 d1:m7
}

chordNamesChorus = \chordmode {
  bes:maj7 c1:7sus4 f1 d1:m11
  bes:maj7 c1:7sus4 f1 d1:m11
  bes:maj7 c:7sus4 f:6 d:m11
  bes:maj7 c:7 f:maj9 d:m
}

chordNamesBridge = \chordmode {
  bes1 d:m bes d:m
  bes1 d:m c:7sus4 c:7sus4
}

verseOne = \lyricmode {
  I used to
  rule the world
  Seas would rise when i gave the word
  now in the mor- ning I
  sweep a- lone
  Sweep the streets I used to own

  I used to roll the dice
  Feel the fear in my ene- my's eyes
  List- en as the crowd would sing
  now the old king is dead! Long live the king!

  One minute I held the key
  Next the walls were closed on me
  And I discoverd that my castles stand
  Upon pollars of salt and pillars of sand

  %% Chorus
  I hear Jerusalem bells are ringing
  Roman Calvary choirs are singing
  Be my mirror, my sowrd, and shield
  My missionaries in a foreign field

  For some reason I can't explain
  Once you go there was never,
  never an honest word
  That was when I ruled the world

  %% 8 bar rest

  It was the wicked and wild wind
  Blew down the doors to let me in
  Shattered windows and the sound of drums
  People couldn't believe what I'd become
  Revolutionaries wait
  For my head on a silver plate
  Just a puppet on a lonely string
  Oh who would ever want to be king?

  %% Chorus
  I hear Jeruselem bells are ringing
  Roman Calvary choirs are singing
  Be my mirror, my sword and shield
  My missionaries in a foreign field

  For some reason I can't explain
  I know Saint Peter will call my name,
  Never an honest word
  But that was when I ruled the world

  %% 8 bar rest

  %% 8 bar ohhh

  %% Chorus
  I hear Jeruselem bells are ringing
  Roman Calvary choirs are singing
  Be my mirror, my sword and shield
  My missionaries in a foreign field

  For some reason I can't explain
  I know Saint Peter will call my name,
  Never an honest word
  But that was when I ruled the world

  %% 8 bar ohhh
  %% Fading
}

stringBackground = \relative c' {
  \repeat unfold 2 {
    f4 f f f8 g
    r8 g r g g4 g4
    e4 e e e8 f
    r8 f r f f4 f
    \break
  }
  \bar "||"
}

stringBackgroundTwo = \relative c' {
  \repeat unfold 2 {
    f4 f f f8 g
    r8 g r g g4 g4
    f4 f f f8 g
    r8 g r g g4 g4
    \break
  }
  \bar "||"
}
strings = \relative c' {
  \bar ".|-|"
  \timestop "0:00" \stringBackground
  \timestop "0:07" \stringBackground
  \timestop "0:14" \stringBackgroundTwo
  \timestop "0:21" \stringBackground
  \timestop "0:28" \stringBackground % different
  \timestop "0:35" \stringBackground
  \timestop "0:42" \stringBackground
  \timestop "0:49" \stringBackground
  \timestop "0:56" \stringBackground
  \timestop "1:03" \stringBackground
  \timestop "1:10" \stringBackground
  \timestop "1:17" \stringBackground
  \timestop "1:24" \stringBackground
  \timestop "1:31" \stringBackground
  \timestop "1:38" \stringBackground % different
  \timestop "1:45" \stringBackground
  \timestop "1:52" \stringBackground
  \timestop "1:59" \stringBackground
  \timestop "2:06" \stringBackground
  \timestop "2:13" \stringBackground
  \timestop "2:20" \stringBackground
  \timestop "2:27" \stringBackground
  \timestop "2:34" \stringBackground
  \timestop "2:41" \stringBackground
  \timestop "2:48" \stringBackground % instrumental
  \timestop "2:55" \stringBackground
  \timestop "3:02" \stringBackground % oh oh
  \timestop "3:09" \stringBackground % oh oh
  \timestop "3:16" \stringBackground
  \timestop "3:23" \stringBackground
  \timestop "3:30" \stringBackground
  \timestop "3:37" \stringBackground
  \timestop "3:44" \stringBackground
  \timestop "3:51" \stringBackground
  \timestop "3:58" \stringBackground
}

vocals = \relative c'' {
  \bar ".|-|"
  \repeat unfold 7 {r1}
  r4. a8 a4 a
  \break

  a2. bes8 g~
  g2 r8 g4 f8
  g4 g8 f a4 e8 f
  r8 a8 a a a a a r

  a2. bes8 g~
  g2 r8 g4 f8
  g4 g g a16 f8.~(
  f8 e d2) r4

  r1 r1 r1 r1

  r1 r1 r1
  r4. a'8 a4 a

  a2. bes8 g~
  g2 r8 g4 f8
  g4 g8 f a4 e8 f~(
  f8 e d) a'8 a a a r

  a2. bes8 g~
  g2 r4 g8 f
  a8 f e d~ d4 a'8 f
  e8 d~ d4 r8 d'8 d d

  d2. a8 c~
  c4 r2.


  \repeat unfold 67 { s1*4 \break } \bar "||"
}

myScore = \score {
  <<
    %% \new Lyrics \harmonicAnalysis  % add the harmonic harmonicAnalysis above the chord names
    %% \new ChordNames { \repeat unfold 1 \chordNamesHead }  % add the Chord Names above the staff

    \new ChordNames \with {
      \consists Percent_repeat_engraver
      \override PercentRepeat.Y-offset = 1
    }
    {
      \markManualBox "Intro" \chordNamesIntro
      \markManualBox "Verse" \chordNamesVerse
      \markManualBox "Verse" \chordNamesVerse
      \markManualBox "Verse" \chordNamesVerse
      \markManualBox "Verse" \chordNamesVerse
      \markManualBox "Chorus" \chordNamesChorus
      \markManualBox "Verse" \chordNamesVerse
      \markManualBox "Verse" \chordNamesVerse
      \markManualBox "Verse" \chordNamesVerse
      \markManualBox "Chorus" \chordNamesChorus
      \markManualBox "Bridge" \chordNamesBridge
      \markManualBox "Verse" \chordNamesVerse
      \markManualBox "Verse" \chordNamesVerse
      \markManualBox "Verse" \chordNamesVerse
      \markManualBox "Verse" \chordNamesVerse
    }
    \new Staff {
      \global
      \new Voice = "strings" { \strings }
    }
    \new Voice = "vocals" { \vocals }
    \new Lyrics \lyricsto "vocals" { \verseOne }
  >>
  \layout { indent = 0 }
}

\myScore
