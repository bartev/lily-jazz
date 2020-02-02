\version "2.18.2"

\layout {
% Don't justify the output
  ragged-right = ##t
}

downarrow = \markup {
  \with-color #red
  \center-column {
    \combine
    \draw-line #'(0 . 2)
    \arrow-head #Y #DOWN ##t
  }
}

melody = \relative c'' { 
  r4^\downarrow
 d8^\downarrow g, c4^\downarrow r8^\downarrow r8 
}

\score 
{
  <<
    \new Staff = "singer" << 
      \new Voice = "vocal" { \melody }
    >>
  >>
  
}
