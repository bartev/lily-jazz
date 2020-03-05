\version "2.20.0"

\header { }

violin = \new Staff {
  \relative c'' {
    a4 b c b
  }
}

cello = \new Staff {
  \relative c {
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
