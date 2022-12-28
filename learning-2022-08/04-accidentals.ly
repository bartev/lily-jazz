\version "2.24.0"

musicA = {
  <<
    \relative c' { d8 e fis g a b cis d }
  >>
}


\new Staff = "up" {
      \key fis \minor
      \accidentalStyle teaching
      \musicA
    }


\new Staff = "up" {
      \key fis \minor
      \accidentalStyle modern
      \musicA
    }
