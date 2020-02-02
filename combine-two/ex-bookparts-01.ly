\version "2.18.2"

notes = \relative c'' { 
      \key c \major 
      c4 d e f g f e c }

\score {
       \transpose ees c \notes
}

\new Staff {
    \notes
    \transpose ees c { \notes }
    \transpose bes c { \notes }
 }