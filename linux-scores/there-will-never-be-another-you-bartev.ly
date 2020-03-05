\version "2.18.2"

% #(set-global-staff-size 26)
\include "jazzchords.ily"
\include "lilyjazz.ily"
\include "jazzextras.ily"

% \include "there-will-never-be-another-you.ly"

\paper {
  #(set-paper-size "letter")
  indent = 0\mm
  between-system-space = 2.5\cm
  between-system-padding = #0
  %%set to ##t if your score is less than one page:
  ragged-last-bottom = ##t
  ragged-bottom = ##f
  ragged-right = ##f
  markup-system-spacing = #'((basic-distance . 23)
                             (minimum-distance . 8)
                             (padding . 1))
}

global = {
  \numericTimeSignature
  \time 4/4
}

% line 1

\score {
  <<
    \new ChordNames \chordmode {
      c1:maj7 | c1:maj7 | b:m7.5- | e1:7.9-
    }
    \new Staff \relative c''' {
      \global
      \key c \major
      \bar ".|"
      \mark "lick 1"
      g8 r8 r4 g4 r8 fis8
      g2 r4 r8 fis8
      f2 r2
      r4 r8 fis8 g fis f4
    }
  >>
}

% line 2

\score {
  <<
    \new ChordNames \chordmode {
      c1:maj7 | c1:maj7 | b:m7.5- | e1:7.9-
    }
    \new Staff \relative c'' {
      \global
      \key c \major
      \bar ".|"
      \mark "lick 2"
      r8 c'8 a bes8 r8 a fis g
      r8 a8 fis g   r8 fis dis e
      r8 g8 e f     r8 e cis d
      r8 b8 ais a   gis4 r4
    }
  >>
}

% line 3

\score {
  <<
    \new ChordNames \chordmode {
      b1:m7.5- | e1:7.9- | a1:min7
    }
    \new Staff \relative c'' {
      \global
      \key c \major
      \bar ".|"
      \mark "lick 3"
      r1
      d4 dis e r8 g8
      e8 a,4 r8 r2
    }
  >>
}

% line 4

\score {
  <<
    \new ChordNames \chordmode {
      g1:min7 | c1:7 | f1:maj7
    }
    \new Staff \relative c'' {
      \global
      \key c \major
      \bar ".|"
      \mark "lick 4"
      r1
      r4 r8 b8 c b bes4
      a2 r2
    }
  >>
}
