\version "2.20.0"

% http://lilypond.org/doc/v2.18/Documentation/notation/file-structure

#(set-global-staff-size 24)
\include "jazzchords.ily"
\include "lilyjazz.ily"
\include "jazzextras.ily"

\paper {
  #(set-default-paper-size "letter")
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

\layout {}

\midi {}




equinoxNotes = \relative c'' {
  \key c \major
  \partial 8 g8 |
  \showStartRepeatBar \bar "[|:"
  ees'4. c8 ~ c2 ~ |
  c2. ~c8 g8 |
  ees'8 c8 ~ c2 ~ c8 g8 | \break

  c8 ees8 r4 r4 r8 ees8 |
  f4. c8 ~ c2 |
  c2.. f8 | \break

  ees4. c8 ~ c4. g8 |
  c8 ees8 r4 r2 |
  r8 d8 r4 d4. c8 | \break

  d4. c8 ees c ees4 |
  c1 ~ |
  c2.. g8 | \break
}


\book {
  \header {
    title = "Equinox"
  }
  \score {
    \new Staff {
      \new Voice {
        \equinoxNotes
      }
    }
    \layout {
      ragged-right = ##t
    }
  }
  \paper {}
}