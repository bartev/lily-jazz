\version "2.20.0"

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
  \bookOutputSuffix "Romanze"
  \header {
    title = "Book title"
    subtitle = "First part"
  }
  \score { 
    \violin
  }
}

\book {
  \bookOutputSuffix "Menuetto"
  \header {
    subtitle = "Second part"
  }
  \score { \cello
         }
}
