\version "2.24.0"

\header {
  title = "Eight miniatures"
  composer = "Igor Stravinsky"
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

\book {
\score {
  \header { piece = "Romanze" }
  \violin
}
\markup {
   …text of second verse…
}
\markup {
   …text of third verse…
}
\score {
  \header { piece = "Menuetto" }
  \cello
}
}