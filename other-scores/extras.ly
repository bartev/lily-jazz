\version "2.24.0"

downarrow = \markup {
  \with-color #red
  \center-column {
    \combine
    \draw-line #'(0 . 2)
    \arrow-head #Y #DOWN ##t
  }
}

