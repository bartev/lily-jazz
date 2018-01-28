\version "2.19.80"

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

chordNames = \chordmode {   c1:m7 g:maj7 }
melody = \relative c''   {  g1   ees }

\score  {  
  <<
    \new ChordNames     { \chordNames  }
    \new Staff {  \melody }
    % \new TabStaff {\melody}
  >>
}