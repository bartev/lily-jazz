\version "2.18.2"

% ‖:	C#m	|	F#m	|	:‖
% ‖:	C#m	|	C#m	|	C#m	|	C#m	:‖
% ‖:	C#m7	|	C#m7	|	C#m7	|	C#m7	|
% |	F#m7	|	F#m7	|	C#m7	|	C#m7	|
% |	A7	|	G#7	|	C#m7	|	C#m7	:|

%#(set-global-staff size 36)  % this MUST go PRIOR to defining the fonts!!!
\include "./stylesheets/lilyjazz.ily"
\include "./stylesheets/jazzchords.ily"

\paper {
  #(define fonts
    (set-global-fonts
      #:music "lilyjazz-20"
      #:brace "lilyjazz-20"
      #:roman "lilyjazz-text"
      #:sans "lilyjazz-chord"
      #:factor (/ staff-height pt 20)
  ))
}

date = "2015-11-18"

\header {
  title = "Transpose Example"
  subtitle = "(C Major Scale)"
  composer = "Nobody Knows"
  meter = "moderato"
  tagline =  \markup {
    \column {
      "Some tagline at the bottom"
      "2nd row"
    } 
  }
  copyright = "copyright BJV"
  arranger = "Bartev V"
  instrument = "sax quartet"
  metre = "metre"
  opus = \date
  piece = "Swing"
  poet = "poet"
  texidoc = "All header fields with special meanings"
  enteredby = "bjv"
  source = "urtext"
}

keyTime = { \key c \minor \time 4/4 }

% Read in the notes for C instrument from here
\include "bv-transpose-ex-melody.ly"

\score {

% For C instrument
  \relative c'' {
  % \keyTime
    % c1 | d | e | f \bar "|."
  \piano
  }
}

% transpose for E flat instrument
\relative c'' {
  \transpose es c \piano
}

<<
  \new Staff  \piano
  \new Lyrics \text
  \new Staff \soprano
  \new Staff \alto
  \new Staff \tenor
  \new Staff \bari
>>
