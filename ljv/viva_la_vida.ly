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
tagline = "Transcribed by Bartev 2024-10 for E♭"
meter = "130"
copyright = #"Transcribed by Bartev 2024-10 for E♭"

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
  bes1:sus2 c1 f1 d1:m7 \break
  bes1:sus2 c1 f1 d1:m7 \break
}

chordNamesVerse = \chordmode {
  bes:maj7 c1:7sus4 f1 d1:m7 \break
  bes:maj7 c1:7sus4 f1 d1:m7 \break
}

chordNamesChorus = \chordmode {
  bes:maj7 c1:7sus4 f1 d1:m11 \break
  bes:maj7 c1:7sus4 f1 d1:m11 \break
  bes:maj7 c:7sus4 f:6 d:m11 \break
  bes:maj7 c:7 f:maj9 d:m \break
}

chordNamesBridge = \chordmode {
  bes1 d:m bes d:m \break
  bes1 d:m c:7sus4 c:7sus4 \break
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

  One min- ute I held the key
  next the walls were closed on me
  And I dis- co- vered that my cast- les stand
  Up- on pil- lars of salt and pil- lars of sand

  %% Chorus
  I hear Je- rusa- lem be- ells are ring- ing
  Ro- man Cal- va- ry choirs are sing- ing
  Be my mir- ror, my sword, and shie- ld
  My miss- ion- a- ries in a for- eign fie- ld

  For some rea- son I can't ex- plain
  Once you go there was ne- ver,
  ne- ver an hon- est word
  That was when I ruled the world

  %% 8 bar rest

  It was the wick- ed and wi- ld wind
  Blew down the doors to let me in
  Shatt- ered win- dows and the sound of drums
  Peo- ple could- n't be- lieve what I'd be- come
  Re- vo- lu- tion- a- ries wait
  For my head on a sil- ver plate
  Just a pup- pet on a lone- ly string
  Oh who would ev- er want to be king?

  %% Chorus
  I hear Je- rusa- lem be- ells are ring- ing
  Ro- man Cal- va- ry choirs are sing- ing
  Be my mir- ror, my sword, and shie- ld
  My miss- ion- a- ries in a for- eign fie- ld

  For some rea- son I can't ex- plain
  I know Saint Pe- ter will call my name,
  ne- ver an ho- nest word
  But that was when I ruled the world

  %% 8 bar rest

  %% 8 bar ohhh

  %% Chorus
  I hear Je- rusa- lem be- ells are ring- ing
  Ro- man Cal- va- ry choirs are sing- ing
  Be my mir- ror, my sword, and shie- ld
  My miss- ion- a- ries in a for- eign fie- ld

  For some rea- son I can't ex- plain
  I know Saint Pe- ter will call my name,
  ne- ver an ho- nest word
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

stringBackgroundInstrumental = \relative c' {
  \repeat unfold 2 {
    f4 f f f8 g
    r8 g r g g4 g4
    f4 f f f8 g
    r8 g r g g4 g4
    \break
  }
  \bar "||"
}

noBackground = \relative c' { \repeat unfold 4 { r1 } \break }

strings = \relative c' {
  \bar ".|-|"
  \timestop "0:00" \stringBackground % intro
  \timestop "0:14" \stringBackground % verse
  \timestop "0:28" \stringBackgroundInstrumental
  \timestop "0:42" \stringBackground % verse
  \timestop "0:56" \stringBackground % verse
  \timestop "1:10" \stringBackground % chorus
  \timestop "1:24" \stringBackground % chorus (still)
  \timestop "1:38" \stringBackgroundInstrumental
  \timestop "1:52" \stringBackground % verse
  \timestop "2:06" \stringBackground % verse
  \timestop "2:20" \stringBackground % chorus
  \timestop "2:34" \stringBackground % chorus (still)
  \timestop "2:48" \stringBackgroundInstrumental
  \timestop "3:02" \stringBackground % ooh
  \timestop "3:16" \stringBackground % chorus
  \timestop "3:30" \stringBackground % chorus (still)
  \timestop "3:44" \noBackground
  \timestop "3:51" \noBackground
  \timestop "3:58" \noBackground


  %% \timestop "3:52" \stringBackground
  %% \timestop "3:59" \stringBackground
  %% \timestop "3:06" \stringBackground
  %% \timestop "3:13" \stringBackground
  %% \timestop "3:20" \stringBackground
  %% \timestop "3:27" \stringBackground
  %% \timestop "2:34" \stringBackground
  %% \timestop "2:41" \stringBackground
  %% \timestop "2:48" \stringBackground % instrumental
  %% \timestop "2:55" \stringBackground
  %% \timestop "3:02" \stringBackground % oh oh
  %% \timestop "3:09" \stringBackground % oh oh
  %% \timestop "3:16" \stringBackground
  %% \timestop "3:23" \stringBackground
  %% \timestop "3:30" \stringBackground
  %% \timestop "3:37" \stringBackground
  %% \timestop "3:44" \stringBackground
  %% \timestop "3:51" \stringBackground
  %% \timestop "3:58" \stringBackground

}

vocals = \relative c'' {
  \bar ".|-|"
  \repeat unfold 7 {r1}
  r4. a8 a4 a


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
  e8 d~ d8 d'8 d d d4

  d2. a8 c~
  c2 r8 c4 c8
  c4. bes8 c4 bes
  a8 a a a a a a a

  a2~a8 bes8~ bes8 g~
  g2 r8 g8 f4
  a8 g f f~ f8 f8 a8 g
  f8 f~ f4 r8 a8 c4

  %% Chorus
  %% m41
  d4 d d8 c d8(c~
  c4~ c8) g8 a bes~ bes4
  c4 c c8 bes c a~
  a4 e8 f~ f a~ a4

  d4 d d8 c d c~
  c4 g8 a8~ a8 bes8~ bes c
  c8 c c4 c8 bes c a~
  a4 e8 f~ f a r4

  d4 d d8 c d8 e
  r8 e r e8~ e2
  c4 c c c8 bes
  c8 a~ a4 c8 a a4

  a2 r8 bes r g~
  g2 r8 f8 f4
  e8 e~ e4 a e8 f~
  f8( e d4) r2

  %% Instrumental
  \repeat unfold 7 { r1 }

  %% copied - need to check
  %% r4. a'8 a4 a

  %% a2. bes8 g~
  %% g2 r8 g4 f8
  %% g4 g8 f a4 e8 f
  r8 a'8 a a a a a r

  a2. bes8 g~
  g2 r8 g g f8
  g4. g8 a4 e8 f~
  f4 a8 a a a a a

  a2. bes8 g~
  g2 r4 g8 g
  a8 g f f~ f4 f8 a8~
  a8 f8 f8 r c' c c c

  %% m73
  d2. a8 c~
  c2 r4 c8 c
  c4 c8 bes c4 bes8 a~
  a8 r a8 a a a a a

  a2~a8 bes8~ bes8 g~
  g2 r4 f4
  a8 g f f f8 f8 a8 g(
  f8 f~) f4 r8 a8 c4

  %% Chorus
  %% m81
  d4 d d8 c d8(c~
  c4~ c8) g8 a bes~ bes4
  c4 c c8 bes c a~
  a4 e8 f~ f a~ a4

  %% m85
  d4 d d8 c d c~
  c4 g8 a8~ a8 bes8~ bes c
  c8 c c4 c8 bes c a~
  a4 e8 f~ f a r4

  %% m89
  d4 d d8 c d8 e
  r8 e r e8~ e4. c8
  c4 c c8 c c8 bes
  r8 a r a r8 c a a

  %% m93
  a2 r8 bes r g~
  g2 r8 f8 f f
  e8 e~ e4 a e8 f~
  f8( e d4) r2

  %% instrumental
  \repeat unfold 8 { s1 }

  %% ooh
  \repeat unfold 7 { s1 }
  r2 r8 a'8 c4

  %% Chorus
  %% m81
  d4 d d8 c d8(c~
  c4~ c8) g8 a bes~ bes4
  c4 c c8 bes c a~
  a4 e8 f~ f a~ a4

  %% m85
  d4 d d8 c d c~
  c4 g8 a8~ a8 bes8~ bes c
  c8 c c4 c8 bes c a~
  a4 e8 f~ f a r4

  %% m89
  d4 d d8 c d8 e
  r8 e r e8~ e4. c8
  c4 c c8 c c8 bes
  r8 a r a r8 c a a

  %% m93
  a2 r8 bes r g~
  g2 r8 f8 f f
  e8 e~ e4 a e8 f~
  f8( e d4) r2

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
      \markManualBox "Instrumental" \chordNamesVerse
      \markManualBox "Verse" \chordNamesVerse
      \markManualBox "Verse" \chordNamesVerse
      \markManualBox "Chorus" \chordNamesChorus % 2x as long as verse
      \markManualBox "Istrumental" \chordNamesVerse

      \markManualBox "Verse" \chordNamesVerse
      \markManualBox "Verse" \chordNamesVerse
      \markManualBox "Chorus" \chordNamesChorus
      \markManualBox "Instrumental" \chordNamesBridge
      \markManualBox "Ooh" \chordNamesVerse
      \markManualBox "Chorus" \chordNamesChorus
      \markManualBox "Verse" \chordNamesVerse

    }
    \new Staff \with { instrumentName = "strings"} {
      \global
      \new Voice = "strings" { \strings }
    }
    \new Staff \with { instrumentName = "vocals" } {
      \new Voice = "vocals" { \vocals }
    }
    \new Lyrics \lyricsto "vocals" { \verseOne }
  >>
  \layout { indent = 0 }
}

\myScore
