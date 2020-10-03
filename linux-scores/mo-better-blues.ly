\version "2.20.0"

#(set-global-staff-size 25)
\include "jazzchords.ily"
\include "lilyjazz.ily"
\include "jazzextras.ily"

title = "Mo Better Blues"
composer = "?"
meter = \markup{}
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
  ragged-last-bottom = ##f
  ragged-bottom = ##f
  markup-system-spacing = #'((basic-distance . 23)
                             (minimum-distance . 8)
                             (padding . 1))
}

global = {
  \numericTimeSignature
  \time 4/4
  \key c \major
  \tempo 4=100

  % make only the first clef visible
  \override Score.Clef #'break-visibility = #'#(#f #f #f)

  % make only the first time signature visible
  \override Score.KeySignature #'break-visibility = #'#(#f #f #f)

  % allow single-staff system bars
  \override Score.SystemStartBar #'collapse-height = #1

  \set Score.markFormatter = #format-mark-box-alphabet
}

chordNames = \chordmode {

}

melody = \relative c'' {

  {
   \mark \markup{\small \with-color #red "1:09"} 
   bes8 c ees f g2~
   g1
   f8 g f ees c2~
   c1
   \break
   f8 g f ees c2~
   c1
   f8 g f c ees2~
   ees1
   \break

   bes8 c ees bes' g2~
   g1
   f8 g f ees c2~
   c1
   \break
   f8 g f ees c2~
   c1
   f8 g f c ees2~
   ees1
   \break

   bes16 c8. ees16 f8. ees8 g8~ g4~
   g2 f8 ees f g~
   g2 f8 ees c4~
   c2
   }
 
}

\score {
  % <<
    % \new ChordNames {
    %      \chordmode
    %      }
    \new Staff {
         \global
         \melody
         }
  % >>
}