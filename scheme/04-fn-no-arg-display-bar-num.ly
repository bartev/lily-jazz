\version "2.24.0"

displayBarNum =
#(define-music-function
  ()
  ()
  (if (eq? #t (ly:get-option 'display-bar-numbers))
      #{ \once \override Score.BarNumber.break-visability = ##f #}
      #{#}))



theNotes = \relative c' {
  \key c \major
  \bar "[|:-|"
    c'4 g8 e ~ e2 ~ |
    e2 \tuplet 3/2 { c'4 d c } |
    b4 gis8 e ~ e2 ~ |
    e1 |\break
    a4. g8 e2 ~ |
    e4 dis e8 bes' a4 |
    g2 f2 ~ |
    f1 |\break
    e4. ees8 d2 ~ |
    d2 e8 gis c4 |
    d2 c2 ~ |
    c1 | \break
    b4. bes8 a2 ~ |
    a2 a8 d b4 |
    a1 |
    b1 \bar "||" \break
    c4 g8 e ~ e2 ~ |
    e2 \tuplet 3/2 { c'4 d c } |
    b4 gis8 e ~ e2 ~ |
    e1 | \break
    a4. g8 e2 ~ |
    e4 dis e8 bes' a4 |
    g2 f2 ~ |
    f1 | \break
  }

\score { \theNotes }