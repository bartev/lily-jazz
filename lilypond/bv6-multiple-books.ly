\version "2.19.31"

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
  \header {
    title = "Book title"
    subtitle = "First part"
  }
  \score { 
    \violin
  }
}

\book {
  \header {
    subtitle = "Second part"
  }
  \score { \cello
         }
}
