\version "2.24.0"

\displayScheme
\markup {
  \column {
    \line { \bold \italic "hello" \raise #0.4 "world" }
    \larger \line { foo bar baz }
    }
  }

#(newline)
#(display "some music")
\displayScheme
\score { \relative c'' {c4 d e f} }