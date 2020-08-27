\version "2.20.0"

#(set-global-staff-size 25)
\include "jazzchords.ily"
\include "lilyjazz.ily"
\include "jazzextras.ily"
\include "roman_numeral_analysis_tool.ily"

title = #"Yardbird Suite"
composer = #"Charlie Prker"
meter = "224"
copyright = #""

realBookTitle = \markup {
  \score {
    {
      \override TextScript.extra-offset = #'(0 . -4.5)
      s4
      s^\markup{
        \fill-line {
          \fontsize #1 \lower #2 \rotate #7 \concat {\note #"4" #1 " = " #meter }
          \fontsize #5
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
  tagline = ##f
  copyright = \copyright
}

\paper {
  #(set-paper-size "letter")
  top-margin = 0.5\in
  bottom-margin = 0.5\in
  left-margin = 0.5\in
  right-margin = 0.5\in
  indent = 0\mm
  between-system-space = 2.\cm
  between-system-padding = #0
  %%set to ##t if your score is less than one page:
  ragged-last-bottom = ##t
  ragged-bottom = ##f
  markup-system-spacing = #'((basic-distance . 23)
                             (minimum-distance . 8)
                             (padding . 1))
}

% \chords { … } is a shortcut notation for \new ChordNames \chordmode { … }.
% http://lilypond.org/doc/v2.19/Documentation/notation/displaying-chords

ysChords = \chords {

  a1
  d2:min g2:7 a2:7 g2:7 fis1:7
  b1:7 e1:7 cis2:min fis2:7 b2:min e2:7

  a1 d2:min g2:7 a2:7 g2:7 fis1:7
  b1:7 e1:7 a1:7 a2 aes2:7+9

  cis1:min dis2:m7.5- gis2:7 cis1:min fis1:7
  b1:min cis2:m7.5- fis2:7 b1:7 b2:7 bes2:7

  a1 d2:min g2:7 a2:7 g2:7 fis1:7
  b1:7 e1:7 cis2:min fis2:7 b2:min e2:7

}

% #(define-markup-command (rN2 layout props symbols) (markup-list?) (rN symbols))

analysis = \lyricmode {
  \override LyricText #'font-name = #"serif"
  \set stanza = \markup \keyIndication { A }
  \markup \rN { I }1
  \markup \rN { iv - }2
  \markup \rN { flatvii 7 }2
  \markup \rN { I 7 }2 \markup \rN { flatvii 7 }2
  \markup \rN { VI 7 }1
  \markup \rN { ii 7 }1
  \markup \rN { V 7 }1
  \markup \rN { iii - }2
  \markup \rN { VI 7 }2
  \markup \rN { ii - }2
  \markup \rN { V 7 }2

  \set stanza = \markup \keyIndication { A }
  \markup \rN { I }1
  \markup \rN { iv - }2
  \markup \rN { flatvii 7 }2
  \markup \rN { I 7 }2 \markup \rN { flatvii 7 }2
  \markup \rN { VI 7 }1
  \markup \rN { ii 7 }1
  \markup \rN { V 7 }1
  \markup \rN { I 7 }
  \markup \rN { I }2
  \markup \rN { flatI 7+9 }2

  \set stanza = \markup \keyIndication { C-sharp }
  \markup \rN { I - }1
  \markup \rN { ii h }2
  \markup \rN { V 7+9 }2
  \markup \rN { I - }1
  \markup \rN { IV 7 }1
  \markup \rN { vii - }1
  \markup \rN { I h }2
  \markup \rN { IV 7 }2
  \markup \rN { vii 7 }1
  \markup \rN { vii 7 }2
  \markup \rN { fvii 7 }2

  \set stanza = \markup \keyIndication { A }
  \markup \rN { I }1
  \markup \rN { iv - }2
  \markup \rN { flatvii 7 }2
  \markup \rN { I 7 }2 \markup \rN { flatvii 7 }2
  \markup \rN { VI 7 }1
  \markup \rN { ii 7 }1
  \markup \rN { V 7 }1
  \markup \rN { iii - }2
  \markup \rN { VI 7 }2
  \markup \rN { ii - }2
  \markup \rN { V 7 }2

}

ysMelody = \relative c'' {
  \bar "[|:"
  a8 cis e gis~ gis2
  \repeat unfold 3 {s1} \break
  \repeat unfold 4 {s1} \break
  \bar "||"

  \repeat unfold 4 {s1} \break
  \repeat unfold 4 {s1} \break
  \bar "||"

  \repeat unfold 4 {s1} \break
  \repeat unfold 4 {s1} \break
  \bar "||"

  \repeat unfold 4 {s1} \break
  \repeat unfold 4 {s1} \break
  \bar ":|]"
}


\score {
  <<
  \new Lyrics \analysis
  \ysChords
  \new Staff \ysMelody
  >>
}