\version "2.18.2"

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

tripletA = \tuplet 3/2 {c,8 e g}
barA = { \tripletA \tripletA \tripletA \tripletA }

\relative c'' {
  \barA \barA
}

