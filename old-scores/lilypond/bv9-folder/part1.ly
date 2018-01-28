\include "subfolder/part2.ly"

\score {
  
  {
    \relative c'' {c4 d e f | g a b c}
    \foo
    \foo
  }
  \header {
    piece = \markup { \fontsize #4 \bold "name I" }
    opus = \markup { \italic "BWV 846" }
  }

 
  % \include "../bv9-folder/subfolder/part2.ly"
}
