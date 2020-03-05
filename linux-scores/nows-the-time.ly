\version "2.20.0"

#(set-global-staff-size 25)
\include "jazzchords.ily"
\include "lilyjazz.ily"
\include "jazzextras.ily"

MyTranspose =
#(define-music-function (m)
   (ly:music?)
   #{ \transpose d g $m #})
% In the previous line the transposition of the whole score is defined
% (in this case up a 6th from E flat to C).

\paper {
  #(set-paper-size "letter")
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

title = "Now's The Time"
composer = #"Charlie Parker"
meter = \markup{ Blues }

realBookTitle = \markup {
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
  title = \realBookTitle
  tagline = ##f
}

global = {
  \numericTimeSignature
  \time 4/4
  \key c \major
  \tempo 4=220

  % make only the first clef visible
  \override Score.Clef #'break-visibility = #'#(#f #f #f)

  % make only the first time signature visible
  \override Score.KeySignature #'break-visibility = #'#(#f #f #f)

  % allow single-staff system bars
  \override Score.SystemStartBar #'collapse-height = #1
}

partial_chordNames = \chordmode { \partial 2 s2 }
partial_melody = \relative c'' { \partial 2 r4 r8 a8 }

% changes from OmniBook??
chordNames = \chordmode {
  d1:7 d1:7 d1:7 d1:7
  g1:7 g2:7 gis2:dim d1:7 d1:7
  e1:m7 a1:7 d1:7 a1:7
}

% changes from iRealPro
chordNames = \chordmode {
  d1:7 g1:7 d1:7 a2:m7 d:7
  g1:7 gis1:dim d1:7 fis2:m7 b:7
  e1:m7 a1:7 d2:7 b:7 e2:m7 a:7

}

melody = \relative c'' {
  \bar "[|:"
  d8 d e a, d4 r8 a
  d8 d e a, d4 r8 a
  d8 d e a, d8 d e a,
  d8 d e a, d4 r8 a |
  \break
  d8 d e a, d g,~ g4
  d'8 d e a, d gis,8~ gis4
  d'8 d e a, d8 d e a,
  d8 d e a, d4 r8 f8~
  \break
  \tuplet 3/2 {f16 g f} d8 b gis b4 r4
  r8 e8~ e4 d8 e d c
  r8 a r4 a4 r4
  r1
  \bar "|."
}

right = {
  \global
  \partial_melody
  \melody
}

left = {
  \global
  \new ChordNames {
    % http://lilypond.org/doc/v2.18/Documentation/snippets/tweaks-and-overrides
    \override ChordNames.ChordName.extra-offset = #'(0 . 4.5)
    \partial_chordNames
    \chordNames
  }
}

% \score {
%   <<
%     \new ChordNames{ \partial_chordNames  \chordNames }
%     \new Staff { \partial_melody \melody }
%   >>
%   \layout { }
% }


\score {
  \new GrandStaff  <<
    \set GrandStaff.systemStartDelimiter = #'SystemStartBar
    \new Staff = "right" \MyTranspose { \right }
    \new Staff = "left" { \clef bass \MyTranspose { \left } }
  >>
  \layout {
    \context {
      % http://lilypond.1069038.n5.nabble.com/Fixed-width-measures-td172597.html
      \Score proportionalNotationDuration = #(ly:make-moment 1/8)
    }
  }
}

