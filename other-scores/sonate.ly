\version "2.19.31"


\header {
  % http://lilypond.org/doc/v2.18/Documentation/notation/creating-titles-headers-and-footers

  title = "Sonate"
  % dedication = 
  subtitle = "Op. 167"

  instrument = \markup \with-color #darkred "Alto Sax"
  % poet = 
  composer = "C. Saint-Saens"

  opus = "Trans by Larry Teal"
  arranger = "Music Autography by Elaine Zajac"
  meter = "Allegretto"

  tagline = "Typeset by Bartev using Lilypond"
  copyright = "&copyright Copyright 1976 by Etolis Quality Music, Bloomington, Indiana"
}

#(set-default-paper-size "letter")
\paper {
  ragged-bottom = ##t
  % page-number-type = #'roman
  system-system-spacing.basic-distance = #12
  % page-breaking = #ly:page-turn-breaking
  page-breaking = #ly:minimal-breaking
  % page-breaking = #ly:one-page-breaking
}

\layout {
  % #(layout-set-staff-size 20)  % default is 20
}

\include "sonate-movement-1.ly"

movementII =  \relative c' { 
  \key c \minor
  \time 4/4
  c8 d e f g a b c ||
}

\book {
  \paper {
    print-all-headers = ##t
    print-page-number = ##t
    print-first-page-number = ##t
    % oddHeaderMarkup = \markup \null
    % evenHeaderMarkup = \markup \null
    % oddFooterMarkup = \markup {
    %   \fill-line {
    %     \on-the-fly \print-page-number-check-first
    %     \fromproperty #'page:page-number-string
    %   }
    % }
    % evenFooterMarkup = \oddFooterMarkup

    %% toc markup
    tocTitleMarkup = \markup \huge \column {
      \hspace #1
      \fill-line { \null "Table of Contents" \null }
      \hspace #1
    }
    %% user larger font size
    % tocItemMarkup = \markup \large \fill-line {
    %   \fromproperty #'toc:text \fromproperty #'toc:page
    % }
    %% add dots to fill line
    tocItemMarkup = \tocItemWithDotsMarkup
  }
  \markuplist \table-of-contents
  \pageBreak

  \tocItem \markup "Movement I"
  \score {
    \new Staff \with { midiInstrument = #"alto sax" } {
      \accidentalStyle modern-cautionary
      \new Voice { 
        \compressFullBarRests
        \override MultiMeasureRest.expand-limit = #1
        \movementI
      }
    }
    \header{
      piece = \markup { \fontsize #5 "Movement I" }
    }
    \layout {}
    \midi {
      \tempo 4 = 120
    }
  }

  \pageBreak

  \tocItem \markup "Movement II"
  \score {
    \new Staff {
      \new Voice { \movementII }
    }
    
    \header {
      piece = \markup { \fontsize #5 "Movement II" }
      meter = "Adagio"
    }
    \layout {}
    \midi {}
  }
}