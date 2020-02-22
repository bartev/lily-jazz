\version "2.18.2"

#(set-global-staff-size 25)
\include "jazzchords.ily"
\include "lilyjazz.ily"
\include "jazzextras.ily"


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
  \time 4/4
  \key c \major
  \tempo 4=220
}

chordNames = \chordmode {
  \global
  d1:7 d1:7 d1:7 d1:7
  g1:7 g2:7 aes2:dim d1:7 d1:7
  e1:m7 a1:7 d1:7 a1:7
  
}
partial_chordNames = \chordmode { s1 }
partial_melody = \relative c'' { r2 r4 r8 a8 }
melody = \relative c'' {
  \global
  d8 d e a, d4 r8 a
  d8 d e a, d4 r8 a
  d8 d e a, d8 d e a, 
  d8 d e a, d4 r8 a |
  d8 d e a, d g,~ g4
  d'8 d e a, d gis,8~ gis4
  d'8 d e a, d8 d e a,
  d8 d e a, d4 r8 f8~
  \tuplet 3/2 {f16 g f} d8 b gis b4 r4
  r8 e8~ e4 d8 e d c
  r8 a r4 a4 r4
  r1
  
}

words = \lyricmode {
  
  
}

\score {
  <<
    \new ChordNames{ \partial_chordNames  \chordNames }
    \new Staff { \partial_melody \melody }
  >>
  \layout { }
  \midi { }
}
