\version "2.24.0"

% Jazz template with melody on treble cleff, and chord names on bass clef

#(set-global-staff-size 25)
\include "jazzchords.ily"
\include "lilyjazz.ily"
\include "jazzextras.ily"


title = "Title Template"
composer = ""
meter = \markup{ "" }
copyright = ""

realBookTitle = \markup {
  \score {
    {
      \override TextScript.extra-offset = #'(0 . -4.5)
      s4
      s^\markup{
        \fill-line {
          \fontsize #1 \lower #1 \rotate #7 \concat { " " #meter }
          \fontsize #7
          \override #'(offset . 7)
          \override #'(thickness . 6)
          \underline \larger #title
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
  copyright = \copyright
  % Remove default LilyPond tagline
  tagline = ##f
}

\paper {
  #(set-paper-size "letter")
  indent = 0\mm
  between-system-space = 2.5\cm
  between-system-padding = #0
  %%set to ##t if your score is less than one page:
  ragged-last-bottom = ##t
  ragged-bottom = ##f
  markup-system-spacing = #'((basic-distance . 23)
                             (minimum-distance . 8)
                             (padding . 1))

}

global = {
  \numericTimeSignature
  \time 4/4
  \key es \major
  \tempo  4=100

  % make only the first clef visible
  \override Score.Clef.break-visibility = #'#(#f #f #f)

  % make only the first time signature visible
  \override Score.KeySignature.break-visibility = #'#(#f #f #f)

  % allow single-staff system bars
  \override Score.SystemStartBar.collapse-height = #1

  \set Score.rehearsalMarkFormatter = #format-mark-box-alphabet
}

chordNamesPartial = \chordmode {  \partial 2 s2 }
melodyPartial =  \relative c' { \partial 2 s8 c8 e g }

chordNames = \chordmode {
  c1
  {
    { d1:m7 g1:7 }
    { c1:m7  c1:m7 }
  }
}

chordNamesHead = \chordmode {
  c1 c1 c1 c1
}


melody = \relative c' {
  \bar "[|:-|"
  \repeat volta 2 {
    c4 e g b
  }
  \alternative {
    % { c,1 c1}
    % { e1 e1}
    { d,8 f a c b g f d    e8 f g f e2 \bar ":|]"}
    { c4 a bes2 c4 ees2 r4  \bar "|." }
  }
}

solo = \relative c'' {
  c4 e g b
  r4 c8 a b4 g
  a8 c b4 d b
  r4 e2 r4
}

right = {
  \global
  % Music follows here.
  \melodyPartial
  \melody
  %   \pageBreak
  %   \solo
}

left = {
  \global
  % Music follows here
  \new ChordNames {

    % http://lilypond.org/doc/v2.18/Documentation/snippets/tweaks-and-overrides
    \override ChordNames.ChordName.extra-offset = #'(0 . 4.5)
    \chordNamesPartial
    \chordNames
    %   \chordNamesHead
  }
}

MyTranspose =
#(define-music-function (m)
   (ly:music?)
   #{ \transpose ees, c $m #})
% In the previous line the transposition of the whole score is defined
% (in this case up a 6th from E flat to C).

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
