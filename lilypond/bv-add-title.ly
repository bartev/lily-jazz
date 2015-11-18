\version "2.18.2"
\paper {
  #(define fonts
    (set-global-fonts
     #:music "lilyjazz"
     #:brace "lilyjazz"
     #:roman "lilyjazz-text"
     #:sans "lilyjazz-chord"
     #:typewriter "lilyjazz-chord"
     #:factor(/ staff-height pt 20)
   ))
}

\header {
  title = "Symphony"
  composer = "Me"
  opus = "Op. 9"
}


\relative c'' {
\bar ".|"
 c4 d e f | g a b c \bar "|."
}