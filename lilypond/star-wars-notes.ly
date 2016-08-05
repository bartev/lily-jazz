% Treble clef part

% melody = \new Staff \relative c'' {
% melody = \relative c'' {
  % \clef treble
  % \key g \major
  % \numericTimeSignature
  % \time 4/4
melody = \relative c {
  \clef \bass
  \key g \major
  \numericTimeSignature
  \time 4/4

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

% bassline = \new Staff \relative c {
%   \clef bass
%   \numericTimeSignature
%   \time 4/4
%   \partial 8 r8 |
%   c4. c8~c4 c~ | c2 g4 bes | c4. c8~ c4 c~ |
%   c2 c4 es     | f4. f8~ f4 f4~ | f2 g,4 bes |
%   c4. c8~ c4 c4~ | c1        | aes1       |
%   g1             | c4. c8~ c4 c~ | c2 g4 bes | \bar "||"
% }

chordmusic = \chordmode {
  \partial 4 g4 |
  g1 | c4 g2. | c4 g2. |
  f4 d2. | g1 | c4 g2. |
  c4 g2. | f4 d2. | c1  |
  c2 d2    | c1 | bes4 d2. |
  c1 |
}
