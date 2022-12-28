\version "2.24.0"

%% Variables

violin = \new Staff {
  \relative {
    a'4 b c b
  }
}

cello = \new Staff {
  \relative {
    \clef "bass"
    e2 d
  }
}

{
  <<
    \violin
    \cello
  >>
}
