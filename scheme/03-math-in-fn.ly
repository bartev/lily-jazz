\version "2.20.0"

AltOn =
#(define-music-function
  (mag)
  (number?)
  #{
    \override Stem.length = #(* 7.0 mag)
    \override NoteHead.font-size =
      #(inexact->exact (* (/ 6.0 (log 2.0)) (log mag)))
  #})
  

AltOff = {
  \revert Stem.length
  \revert NoteHead.font-size
}

\relative c' {
  c2 \AltOn #0.5 c4 c
  \AltOn #1.5 c c \AltOff c2
}


withAlt =
#(define-music-function
     (mag music)
     (number? ly:music?)
   #{
     \override Stem.length = #(* 7.0 mag)
     \override NoteHead.font-size =
       #(inexact->exact (* (/ 6.0 (log 2.0)) (log mag)))
     #music
     \revert Stem.length
     \revert NoteHead.font-size
   #})

\relative c' {
  c2 \withAlt #2.3 { c4 c }
  \withAlt #0.75 { c c } c2
}
