\version "2.20.0"

#(set-global-staff-size 25)
\include "jazzchords.ily"
\include "lilyjazz.ily"
\include "jazzextras.ily"

title = "Green Dolphin St."
composer = "Kaper/Washington"
meter = \markup{ A-Latin, B,C-Swing }
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
  c1:maj7 c1:maj7 c1:m7 c1:m7
  d1:7 des1:7 c1:maj7 c1:maj7
  {
    {
      d1:m7 g1:7 c1:maj7 c1:maj7
      f1:m7 bes1:7 ees:maj7 ees:maj7
    }
    {
      d2:m7 d2:m b2:m7.5- e2:7.9- a2:m7 a2:m fis2:m7.5- b2:7
      e2:m7 a2:7 d2:m7 g2:8 c1:maj7 d2:m7 g2:7
    }
  }
}

chordNamesHead = \chordmode {
  c1:maj7 c1:maj7 c1:m7 c1:m7
  d1:7 des1:7 c1:maj7 c1:maj7
  d1:m7 g1:7 c1:maj7 c1:maj7
  f1:m7 bes1:7 ees:maj7 ees:maj7
}

melody = \relative c'' {
  \bar "[|:"
  \repeat volta 2 {
    \mark \default
    % 1
    c2 c~
    c2 \tuplet 3/2 {b4 g e }
    bes'1~
    bes1
    \break

    % 5
    a2 a2~
    a2 \tuplet 3/2 {aes4 f des }
    g1~
    g1
    \break
  }
  \alternative {
    {
      \mark \default
      %9
      \bar ".." r8 g4. d4 e
      f4 g aes bes
      g1~
      g1
      \break

      %13
      r8 bes4. f4 g
      aes4 bes ces des
      bes1~
      bes2 b2 \bar
      ":|]"
      \break
    }

    {
      \mark \default
      %17
      r8 g4. d4 e
      f4 g gis e'
      d4. c8~c2
      c,4 d dis b'
      \break

      %21
      a4. g8~ g2
      r8 g4. g4 g4
      g1~
      g1
      \bar ".."
      \break
    }
  }
}

% as played by Alto
solo = \relative c'' {
  \mark \markup{\small \with-color #red "1:09"}
  e8 r8 r4 r2
  r4 r8 g,8 c d ees c
  ees f g8 d ees c8~ c4
  r2 r8 bes8 c4
  \break

  d4 r8 ees8 f4 r8 des8~
  des8 d8~ d e8~e8 r8 r4
  s1
  s1
  \break

  s1
  s1
  s1
  s1
  \break

  s1
  s1
  s1
  s1
  \break

  s1
  s1
  s1
  s1
  \break

  s1
  s1
  s1
  s1
  \break

  s1
  s1
  s1
  s1
  \break

  s1
  s1
  s1
  s1
  \break
}

\score {
  <<
    \new ChordNames {
      \chordNames
      \chordNamesHead
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
}