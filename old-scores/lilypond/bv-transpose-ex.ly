\version "2.24.0"

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
      #:music "lilyjazz"
      #:brace "lilyjazz"
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

keyTime = { \key c \minor 
            \time 4/4 }

% Read in the notes for C instrument from here
\include "bv-transpose-ex-melody.ly"

\score {

% For C instrument
  \relative c {
  % \keyTime
    % c1 | d | e | f \bar "|."
  \piano
  }
}

% transpose for E flat instrument
\relative c {
  \mark \markup {transpose for E\flat instrument "\\transpose es c"}
  \transpose es c \piano
}

% transpose for B flat instrument
\relative c {
  \mark \markup {transpose for B\flat instrument "\\transpose bes c"}
  \transpose bes c \piano
}
\relative c {
  \mark \markup {transpose for B\flat instrument "\\transpose bes c'"}
  \transpose bes c' \piano
}

% transpose down a major fifth
\relative c {
  \mark \markup {"down a major fifth \\transpose g c"
               }
  \transpose g c \piano
}

 
text = \lyricmode {
  do 4 re me fa | so la ti do |
}

\score {
  <<
    \new StaffGroup = "horns" <<
      \new Staff \soprano
      \new Staff \alto
      \new Staff \tenor
      \new Staff \bari
    >>

    \new StaffGroup = "rhythm" <<
      \new Staff  = "Piano" \piano
      \new Lyrics \text
    >>
  >>
}