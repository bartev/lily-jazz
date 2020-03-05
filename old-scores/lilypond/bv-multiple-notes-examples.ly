\version "2.20.0"

% Staff groups
\relative c'' {
  \new PianoStaff <<
    \new Staff { \time 2/4 c4 e | g g, |  }
    \new Staff { \clef "bass" c,,4 c' | e c | }
  >>
}

% Also
% * \new GrandStaff
% * \new ChoirStaff