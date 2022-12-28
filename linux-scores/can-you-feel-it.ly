\version "2.24.0"

#(set-global-staff-size 25)
\include "jazzchords.ily"
\include "lilyjazz.ily"
\include "jazzextras.ily"

title = "Can You Feel it"
composer = "Paula Atherton"
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
  \override Score.Clef.break-visibility = #'#(#f #f #f)

  % make only the first time signature visible
  \override Score.KeySignature.break-visibility = #'#(#f #f #f)

  % allow single-staff system bars
  \override Score.SystemStartBar.collapse-height = #1

  \set Score.rehearsalMarkFormatter = #format-mark-box-alphabet
}

chordNames = \chordmode {
  d1:m7 g1:7 d1:m7 g1:7
  d1:m7 g1:7 d1:m7 g1:7
  s1
  d1:m7 g1:m7 d1:m7 f1
  d1:m7 g1:m7 d1:m7 f1


}

chordNamesHead = \chordmode {
  s1
}

melody = \relative c'' {
  \mark \default
  c8 d f8-. c16 d~ d2
  r8 d16 d f8 g a g~ g4

  c,8 d f8-. c16 d~ d2
  r8 c'8~ c bes a32 bes a16 g8~ g4
  \break

  c,8 d f8-. c16 d~ d2
  r8 d16 d f8 g a g~ g4


  c,8 d f8-. c16 d~ d2
  r8 c'8~ c bes a32 bes a16 g8~ g4~
  \break

  g4 r4 r2
  r2 c,8-- d8-. d8-- c8-.
  c' bes a32 bes a16 g8~ g8 f g f
  a4 r4 r r8 d8
  \break

  c8-- a f-- \tuplet 3/2 {d16 e f} e8 c r4
  r2 c16 d d c d8-- c
  c8 bes a g~ g8 f g f
  a8 d~ d4 r4 r4


}

solo = \relative c'' {
  \mark \markup{\small \with-color #red "Begin Solo"}
  % r8 e8 g c bes g e c
}

\score {
  <<
    \new ChordNames {
      \chordNames
      \chordNamesHead
    }

    \new Staff {
      \global
      \melody
      \pageBreak
      \solo
    }
  >>
  \layout { }
  \midi{}
}
