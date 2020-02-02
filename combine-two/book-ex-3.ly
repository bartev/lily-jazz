\version "2.18.2"

\book {
  \paper {
    indent = 0\mm
    scoreTitleMarkup = \markup {
      \fill-line {
        \fontsize #1 \lower #1 \rotate #7 \fromproperty #'header:meter
        \fontsize #7 \bold \underline \fromproperty #'header:title
        \fromproperty #'header:composer
      } }
  }
  \header { tagline = ##f 
  title = "top title"
  composer = "not me"
  piece = "top piece"
  }
  \score {
    { s1 }
    \header {
      piece = "PRAELUDIUM I"
      opus = "BWV 846"
      title = "score title"
      composer = "don't forget the composer"
      meter = "moderato"
      breakbefore = ##t
    }
  }
}