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
  \bookpart {
    \header {
      title = "Book title"
      subtitle = "First part"
    }
    \score { 
      \violin
    }
  }

  \bookpart {
    \header {
      subtitle = "Second part"
    }
    \score { \cello
           }
  }
}