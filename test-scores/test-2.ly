\version "2.24.0"

\include "jazzextras.ily"

\paper {
  #(define fonts
     (set-global-fonts
      #:music "lilyjazz"
      #:brace "lilyjazz"
      #:roman "lilyjazz-text"
      #:sans "lilyjazz-chord"
      #:factor (/ staff-height pt 20)
      ))
}

chordNames = \chordmode {   
           c1:m7 | 
           g:maj7 | 
           g:maj7 | 
           g:maj7 }
melody = \relative c''   {  
  \numericTimeSignature

       g1  | 
       ees |  
       c2 \rs \rs |
       \comp #4 |
       \comp #3 c4 |
  }

\score  {  
  <<
    \new ChordNames     { \chordNames  }
    \new Staff {  \melody }
    % \new TabStaff {\melody}
  >>
}
