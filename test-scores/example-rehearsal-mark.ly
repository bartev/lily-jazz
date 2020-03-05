\version "2.20.0"

% See http://lilypond.org/doc/v2.15/Documentation/notation/bars.html#rehearsal-marks

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

#(define 
  (bjv-format-mark-boxed-letters mark context)
  (make-bold-markup
   (make-rounded-box-markup
    (make-markletter-markup
     (1- mark)))))

melody = \relative c'' { 
  c1 \set Score.markFormatter = #bjv-format-mark-boxed-letters \mark \default
  d 
  d \set Score.markFormatter = #format-mark-numbers \mark \default
  e \mark \default
  f
  g \set Score.markFormatter = #format-mark-letters \mark \default
  f \set Score.markFormatter = #format-mark-box-numbers \mark \default
  g \set Score.markFormatter = #format-mark-circle-numbers \mark \default
  a \set Score.markFormatter = #format-mark-circle-letters \mark \default
  b \mark "A1"
  c
  
}

\score 
{
  <<
    \new Staff = "singer" << 
      \new Voice = "vocal" { \melody }
    >>
  >>
  
}
