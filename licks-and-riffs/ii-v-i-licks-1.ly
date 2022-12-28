\version "2.24.0"

\include "jazzextras.ily"

% jazzhchords defines m7 flat 5, so it doesn't
% come up as half diminished
% \include "jazzchords.ily"
% \include "lilyjazz.ily"

\header {
  title = "ii-v-i-licks"
  copyright = "lesson 2019-11-25"
  tagline = # #f
}

#(set-global-staff-size 24)

\paper {
  #(set-paper-size "letter")
  #(define fonts
    (set-global-fonts
      #:music "lilyjazz"
      #:brace "lilyjazz"
      #:roman "lilyjazz-text"
      #:sans "lilyjazz-chord"
      #:factor (/ staff-height pt 18)
      ))
  ragged-last-bottom = ##t
  ragged-bottom = ##t
  indent = 0\cm
  oddHeaderMarkup = \markup
    \fill-line {
      \fromproperty #'header:title " " % This will make sure that the header is never completely empty, to
      % avoid some layout problems. Also, moving it in between the title and
      % the page number, makes these be typeset left and right aligned, respectively.
      \if \should-print-page-number
      \fromproperty #'page:page-number-string
    }

  evenHeaderMarkup = \markup
    \fill-line {
      \if \should-print-page-number
      \fromproperty #'page:page-number-string " "
      \fromproperty #'header:title
    }
}


c_maj_ii_v_i = \chordmode {
  d'1:m7 | g:7 | c:maj7
}


\score {
  <<
  \new ChordNames \c_maj_ii_v_i
  \new Staff \c_maj_ii_v_i
  >>
  \header {
  piece = "C major ii-v-i"
  }
}

c_min_ii_v_i = \chordmode {
  d'1:m7.5- | g:7.9- | c:m7
}

\score {
  <<
  \new ChordNames \c_min_ii_v_i
  \new Staff \c_min_ii_v_i
  >>
  \header {
  piece = "minor ii-v-i"
  }
}

% ii-v-i lick 1


chordNames = \chordmode {
  b1:m7.5- |
  e:7.9- |
}

melody = \relative c'' {
  \grace \parenthesize {c16 ais }
  \tuplet 3/2 {b8 d f} d4 b a8 g |
  gis4 r4 r4 r4
}

\score {
  <<
  \new ChordNames {\chordNames \transpose b fis \chordNames}
  \new Staff {\melody \transpose b fis \melody}
  \new Staff {\chordNames \transpose b fis \chordNames}
  >>
  \header {
    piece="ii-v-i lick 1"
  }
}

% ii-v-i lick 2

chordNames_two = \chordmode {
  g2:m7  c:7 |
  f1:maj7
}

melody_two = \relative c'' {
  \grace {a16 fis}
  g8 bes d f e d c bes |
  a2 r2
}

\score {
  <<
  \new ChordNames {
       \chordNames_two
       \transpose f g \chordNames_two }
  \new Staff {
       \melody_two
       \transpose f g \melody_two }
  \new Staff {
       \chordNames_two
       \transpose f g \chordNames_two }
  >>
  \header {
    piece="ii-v-i lick 2"
  }
}

% ii-v-i lick 3

chordNames_three = \chordmode {
  b2:m7.5-  e:7.9- |
  a1:m7 |
}

melody_three = \relative c'' {
  b8 d f a gis f e d |
  c2 r2
}

\score {
  <<
  \new ChordNames {
       \chordNames_three
       \transpose a e \chordNames_three
       \transpose a d \chordNames_three
       \transpose a g \chordNames_three
}
  \new Staff {
       \melody_three
       \transpose a e \melody_three
       \transpose a d \melody_three
       \transpose a g \melody_three
}
  \new Staff {
       \chordNames_three
       \transpose a e \chordNames_three
       \transpose a d \chordNames_three
       \transpose a g \chordNames_three
}
  >>
  \header {
    piece="ii-v-i lick 3"
  }
}

% v7-i lick 1

chordNames_v_i = \chordmode { e1:7.9- | a:m7 }
melody_four = \relative c'' { r4 r r8 f e d | c2 r2 }
\score {
  <<
  \new ChordNames {
       \chordNames_v_i
       \transpose a d \chordNames_v_i
       \transpose a g \chordNames_v_i
       \transpose a c \chordNames_v_i }

  \new Staff {
       \melody_four
       \transpose a d \melody_four
       \transpose a g \melody_four
       \transpose a c \melody_four }
  \new Staff {
       \chordNames_v_i
       \transpose a d \chordNames_v_i
       \transpose a g \chordNames_v_i
       \transpose a c \chordNames_v_i }
  >>
  \header {
    piece="V7-I lick 1"
  }
}


\pageBreak

e_min_ii_v_i = \chordmode {
  fis1:m7.5- | b:79 | e:m7
}

\score {
  <<
  \new ChordNames \e_min_ii_v_i
  \new Staff \e_min_ii_v_i
  >>
  \header {
  piece = "E minor ii-v-i"
  }
}

% ii-v-i lick 4

chordNames_four = \chordmode {
  fis2:m7.5-  b2:7.5- | e1:m7
}

melody_four_a = \relative c' {
    fis8 a c e     dis c b a |
    g4 r4 r2 \bar "||"
}

\score {
  <<
  \new ChordNames {
       \chordNames_four
       \transpose e a \chordNames_four
       \transpose e d \chordNames_four
       \transpose e g \chordNames_four }
  \new Staff {
       \melody_four_a
       \transpose e a \melody_four_a
       \transpose e d \melody_four_a
       \transpose e g \melody_four_a }
  >>
  \header {
    piece="ii-v-1 lick 4"
  }
}

% ii-v-i lick 5

melody_five = \relative c'' {
    a8 c e g   a fis dis b |
    c8 b a b r4 r4
    \bar "||"
}

\score {
  <<
  \new ChordNames {
       \chordNames_four
       \transpose e a \chordNames_four
       \transpose e d \chordNames_four
       \transpose e g \chordNames_four }
  \new Staff {
       \melody_five
       \transpose e a \melody_five
       \transpose e d \melody_five
       \transpose e g \melody_five }
  >>
  \header {
    piece="ii-v-1 lick 5"
  }
}

\pageBreak
% ii-v-i lick 6

chordNames_six = \chordmode {
  fis2:m7.5- b:7 | e1:m7 | a1:7
}

melody_six = \relative c''' {
    g8 e c a   b dis fis a |
    b a16 g a8 e g2 ~
    g4 r4 r2
    \bar "||"
}

\score {
  <<
  \new ChordNames {
       \chordNames_six
       \transpose a d \chordNames_six
       \transpose a g \chordNames_six
       \transpose a c \chordNames_six
}
  \new Staff {
       \melody_six
       \transpose a d \melody_six
    \break
       \transpose a g \melody_six
       \transpose a c \melody_six
}
  >>
  \header {
    piece="ii-v-1 lick 6"
  }
}
