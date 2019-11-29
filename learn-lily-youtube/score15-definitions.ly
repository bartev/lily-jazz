\version "2.18.0"

% these are the instrument definitions

\language "english"

playerone = \relative c' {
  cs4\mf d8[( ef\< f) g-.] a4 |
  f16-. g( a e) a4 d->-. f->-. |
  \time 3/2
  e2\ff^Intense b f |
  \clef alto
  \numericTimeSignature \time 4/4
  <c a>1\fermata \bar "|." |
}

playertwo = \relative c' {
  \clef "bass"
  g2 <af c>2 |
  \tuplet 5/4 { a16 g f e f } g2 e4 |
  fs2 d2 c2 |
  \numericTimeSignature <d ef>1\fermata |
}