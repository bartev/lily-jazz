\version "2.19.31"

\header { 
  title = "Symphony"
  composer = "Me"
  opus = "Op. 9"
}

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
