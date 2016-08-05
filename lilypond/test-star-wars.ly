\version "2.19.31"


% \include "star-wars-notes.ly"

melody = \relative c'' {
  % \clef treble
  \key g \major
  % \numericTimeSignature
  % \time 4/4
  \partial 4 \times 2/3 {g8 g g} \bar ".|"
  g2 d'2 | \times 2/3 {c8 b a} g'2 d4 | \times 2/3 {c8 b a} g'2 d4 | \break
  \times 2/3 {c8 b c} a2 \times 2/3 {d,4 d8} | g2 d'2    | 
  \times 2/3 {c8 b a} g'2 d4 | \times 2/3 {c8 b a} g'2 d4   | \break
  \times 2/3 {c8 b c} a2 \times 2/3 {d,4 d8} | e4. e8 c' b a g |
  \times 2/3 {g8 a b} \times 2/3 {a4 e8} f4 \times 2/3 {d4 d8} | \break
  e4. e8 c'8 b a g | d'8. a16 a2 \times 2/3 {d,4 d8} |
  e4. e8 c'8 b a g } \break
  \bar "||"
}

\melody

