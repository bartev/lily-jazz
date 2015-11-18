\version "2.18.2"

\include "./stylesheets/lilyjazz.ily"
\include "./stylesheets/jazzchords.ily"

\score {
  \new Staff {
                                % \jazzOn
    \relative c'' {
      % c r c \tuplet 3/2 {d8-- es-- e-- } g4 ~ |
      % g r r r8 f~^ \noBeam es c -> \bar "|."
    }
  }
}