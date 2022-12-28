\version "2.24.0"

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
  c1 \set Score.rehearsalMarkFormatter = #bjv-format-mark-boxed-letters \mark \default
  d 
  d \set Score.rehearsalMarkFormatter = #format-mark-numbers \mark \default
  e \mark \default
  f
  g \set Score.rehearsalMarkFormatter = #format-mark-letters \mark \default
  f \set Score.rehearsalMarkFormatter = #format-mark-box-numbers \mark \default
  g \set Score.rehearsalMarkFormatter = #format-mark-circle-numbers \mark \default
  a \set Score.rehearsalMarkFormatter = #format-mark-circle-letters \mark \default
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
