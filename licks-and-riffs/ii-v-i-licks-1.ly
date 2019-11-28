\version "2.18.2"

\include "jazzextras.ily"

% jazzhchords defines m7 flat 5, so it doesn't
% come up as half diminished

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


maj_ii_v_i = \chordmode {
  d1:m7 | g:7 | c:maj7
}

\score {
  <<
  \new ChordNames \maj_ii_v_i
  \new Staff \maj_ii_v_i
  >>
  \header {
  piece = "major ii-v-i"
  }
}

min_ii_v_i = \chordmode {
  d1:m7.5- | g:7.9- | c:m7
}

\score {
  <<
  \new ChordNames \min_ii_v_i
  \new Staff \min_ii_v_i
  >>
  \header {
  piece = "minor ii-v-i"
  }
}

chordNames = \chordmode {
  b1:m7.5- |
  e:7.9- |
}

melody = \relative c'' {
  \tuplet 3/2 {b8 d f} d4 b a8 g |
  gis4 r4 r4 r4
}


% ii-v-i lick 1

chordNames_v_i = \chordmode { e1:7.9- | a:m7 }
\score {
  <<
  \new ChordNames \chordNames
  \new Staff \melody
  \new Staff \chordNames
  >>
  \header {
    piece="ii-v-i lick 1"
  } 
}


% v7-i lick 1


\score {
  <<
  \new ChordNames \chordNames_v_i
  \new Staff \relative c'' { r4 r r8 f e d | c2 r2 }
  \new Staff \chordNames_v_i
  >>
  \header {
    piece="V7-I lick 1"
  } 
}

% ii-v-i

chordNames_two = \chordmode {
  g2:m7  c:7 |
  f:maj7 |
}

melody_two = \relative c'' {
  g8 bes d f e d c bes |
  a2 r2
}

\score {
  <<
  \new ChordNames \chordNames_two
  \new Staff \melody_two
  \new Staff \chordNames_two
  >>
  \header {
    piece="ii-v-i lick 2"
  } 
}

chordNames_three = \chordmode {
  b2:m7.5-  e:7.9- |
  a:m7 |
}

melody_three = \relative c'' {
  b8 d f a gis f e d |
  c2 r2
}

\score {
  <<
  \new ChordNames \chordNames_three
  \new Staff \melody_three
  \new Staff \chordNames_three
  >>
  \header {
    piece="ii-v-i lick 3"
  } 
}
