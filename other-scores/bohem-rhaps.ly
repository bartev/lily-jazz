\version "2.24.0"

\include "extras.ly"

#(set-global-staff-size 24)
\include "../stylesheets/jazzchords.ily"
\include "../stylesheets/lilyjazz.ily"
\include "../stylesheets/jazzextras.ily"

\paper {
  #(set-paper-size "letter")
%  paper-height = 11\in
%  paper-width = 8.5\in
  indent = 0\mm
  between-system-space = 2.5\cm
  between-system-padding = #0
  %%set to ##t if your score is less than one page:
  ragged-last-bottom = ##f
  ragged-bottom = ##f
  markup-system-spacing = #'((basic-distance . 23)
                             (minimum-distance . 8)
                             (padding . 1))
}

title = #"Bohemian Rhapsody"
composer = #"Queen"
meter = #""
copyright = #"Queen"

BohemRhapsRealBookTitle = \markup {
  \score {
    {
      \override TextScript.extra-offset = #'(0 . -4.5)
      s4
      s^\markup{
        \fill-line {
          \fontsize #1 \lower #1 \rotate #7 \concat { " " #meter }
          \fontsize #8
            \override #'(offset . 7)
            \override #'(thickness . 6)
            \underline \larger \larger #title
          \fontsize #1 \lower #1 \concat { #composer " " }
        }
      }
      s
    }
    \layout {
      \omit Staff.Clef
      \omit Staff.TimeSignature
      \omit Staff.KeySignature
      ragged-right = ##f
    }
  }
}


\header {
  title = \BohemRhapsRealBookTitle
  tagline = ##f
  copyright = \copyright
}

theBassLine = \relative c {
  \clef bass
  \key c \major
  \partial 8 r8 |
  \showStartRepeatBar \bar "[|:-|"
  c4. c8 ~ c4 c4 ~ |
  c2 g4 bes4 |
  c4. c8 ~ c4 c4 ~ | \break

  c2 c4 ees4 |
  f4. f8 ~ f4 f4 ~ |
  f2 g,4 bes4 | \break

  c4. c8 ~ c4 c4 ~ |
  c1 |
  aes1 | \break
  
  g1 |
  c4. c8 ~ c4 c4 ~ |
  c2 g4 bes | \break
}

% look at PercentRepeat, SlashRepeat, Percent_repeat_engraver, Slash_repeat_engraver

theChordsC = \chordmode {
  % \partial bes:m6 |
  c4.:m7 bes8:m6 c2:m7|
}


melodyPartOne = \relative c'' {
  \key bes \major
  \time 4/4
  \showStartRepeatBar \bar "[|:-|"
  r8 bes bes bes bes4 bes |
  r8 bes bes bes bes bes g4 |
  \time 5/4
  r8 a a a bes4 a f,8 f |
  \break

  \time 4/4
  bes'8 bes bes bes a f4. |
  d8 d d d ~ d4. d8 |
  d8 d es f ~ f4 bes,4 | 
  \break

  g'1 |
  r8 g g g g4 g |
  \time 5/4
  r8 f8 f g f es c g' a bes |
  \break

  \time 4/4
  b8 b bes4 a8 a bes 4 |
  b8 b bes4 a8 a bes 4 |
  g8 g g g f4 bes |
  \break

  e,8 e e e f4 f,8 a |
  a'2. a,8 bes |
  % bes2. r4 |
  r8 f'( bes d g4 f) |
  % r1 |
  r8 f,( bes d g4 f) |
  
    

}

piano =  {
  \set Staff.instrumentName = #"Piano"
  \clef treble
  \melodyPartOne
}

alto =  {
  \set Staff.instrumentName = #"Alto Sax"
  \clef treble
  \transpose es c' \melodyPartOne
}


trombone = {
  \set Staff.instrumentName = #"Trombone"
  \clef bass
  \transpose c c, \melodyPartOne
}

\score {
  % <<
  %   \new Voice {
  %     \set Staff.instrumentName "Alto"
  %     \clef "G_8"
  %     soloist \theNotesPone
  %     }
  %   \new ChordNames \theChordsC
  %   % \new Voice = soloist \theBassLine
  % >>
  <<
    \new StaffGroup = "horns" <<
      \new Staff \alto
      \new Staff \trombone
      >>
    \new StaffGroup = "rhythm" <<
      \new Staff \piano
    %   \new Lyrics \text
    >>
  >>
  \layout {
    % \override Score.Clef.break-visibility = #'#(#f #f #f)  % make only the first clef visible
    % \override Score.KeySignature.break-visibility = #'#(#f #f #f)  % make only the first time signature visible
    \override Score.SystemStartBar.collapse-height = #1  % allow single-staff system bars
  }
}   