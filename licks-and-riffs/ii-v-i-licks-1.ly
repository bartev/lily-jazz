\version "2.20.0"

\include "jazzextras.ily"

% jazzhchords defines m7 flat 5, so it doesn't
% come up as half diminished
% \include "jazzchords.ily"
% \include "lilyjazz.ily"

\header {
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
  \tuplet 3/2 {b8 d f} d4 b a8 g |
  gis4 r4 r4 r4
}

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


% ii-v-i lick 2

chordNames_two = \chordmode {
  g2:m7  c:7 |
  f1:maj7
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
  \new ChordNames \chordNames_three
  \new Staff \melody_three
  \new Staff \chordNames_three
  >>
  \header {
    piece="ii-v-i lick 3"
  }
}

% v7-i lick 1

chordNames_v_i = \chordmode { e1:7.9- | a:m7 }

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


\pageBreak

e_min_ii_v_i = \chordmode {
  fis1:m7.5- | b:7 | e:m7
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
  fis2:m7.5-  b:7.5- | e1:m7
}

melody_four = \relative c' { 
    fis8 a c e     dis c b a |
    g4
}

\score {
  <<
  \new ChordNames \chordNames_four
  \new Staff \melody_four
  >>
  \header {
    piece="ii-v-1 lick 4"
  }
}

% ii-v-i lick 5

melody_five = \relative c'' { 
    a8 c e g   a fis dis b |
    c b a b  e4
}

\score {
  <<
  \new ChordNames \chordNames_four
  \new Staff \melody_five
  >>
  \header {
    piece="ii-v-1 lick 5"
  }
}

% ii-v-i lick 6

melody_six = \relative c''' { 
    g8 e c a   b dis fis a |
    b a16 g a8 e g2 ~
    g4
}

\score {
  <<
  \new ChordNames \chordmode {
  fis2:m7.5- b:7 | e1:m7 | a:7
}
  \new Staff \melody_six
  >>
  \header {
    piece="ii-v-1 lick 6"
  }
}

\pageBreak

% lick of the week #5
% https://www.learnjazzstandards.com/blog/lick-of-the-week-5-learn-16-variations-of-the-lick/

\score {
 <<
 \new ChordNames \chordmode  {c1:min7 c1:min7}
 \new Staff \relative c' {d8 ees f g d4 bes8 c~ | c2 r2}
 >>
 \header {
   piece="lick of the week #5"
 }
}

% 12 easy ii-V-I licks
% Camden Hughes
% https://www.learnjazzstandards.com/blog/12-ii-v-i-licks/


c_maj_ii_V_I = \chordmode {d1:m7 | g:7 | c:7}


c_maj_ii_V_I_two_measure = \chordmode {d2:m7 g:7 | c1:7}

\score {
  <<
  \new ChordNames \c_maj_ii_V_I
  \new Staff \relative c' {
    d8 e f g a f g a |
    f d r4 r2 |
    c8 d e f g e f g e c r4 r2
    }
  >>
  \header { piece="ornithology lick" }
}


\score {
  <<
  \new ChordNames \c_maj_ii_V_I_two_measure
  \new Staff \relative c' {
    d8 f a c b a g f | e1
    }
  >>
  \header { piece="lick 2" }
}


\score {
  <<
  \new ChordNames \chordmode {d1:m7 | g:7.9- | c:7 | s}
  \new Staff \relative c' {
    d4 d8 e f e d4
    f4 f8 g aes g f c'~
    c4 r4 r2 
    r1
    }
  >>
  \header { piece="groovin' high lick" }
}


\score {
  <<
  \new ChordNames  \chordmode {d1:m7 | g:7 | c:7 | s}
  \new Staff \relative c'' {
    c8 a f d e d g ges
    \tuplet 3/2 {f8 a c} e8 ees~ ees4 r4
    \tuplet 3/2 {b8 c b} a8 aes g e d c
    d e r4 r2
    }
  >>
  \header { piece="lick 4" }
}


\score {
  <<
  \new ChordNames  \chordmode {d1:m7 | g:7 | c:7 | s}
  \new Staff \relative c'' {
    d8 a f d cis' a r4
    c8 a f d b' g r4
    e4 b'8 a g f e b4~
    b4 r4 r2
    }
  >>
  \header { piece="lick 5" }
}

\score {
  <<
  \new ChordNames  \chordmode {d1:m7 | g:7 | c:7 | s}
  \new Staff \relative c'' {
    c8 a f d cis' a f d
    c' a f d b' a g f
    e4 r4 r2
    r1
    }
  >>
  \header { piece="lick 6" }
}


\score {
  <<
  \new ChordNames  \chordmode {d1:m7 | g:7 | c:7 | s}
  \new Staff \relative c'' {
    r8 g ges e f a c e
    d8 c b a g ges f ges?
    e4 r4 r2 
    r1
    }
  >>
  \header { piece="lick 7" }
}


\score {
  <<
  \new ChordNames  \chordmode {d1:m7 | g:7 | c:7 | s}
  \new Staff \relative c' {
    d8 cis d e f e f g
    a8 c a ais b bes a aes
    g ges f g e r8 r4
    r1
    }
  >>
  \header { piece="lick 8" }
}


\score {
  <<
  \new ChordNames  \chordmode {d1:m7 | g:7 | c:7 | s}
  \new Staff \relative c'' {
    \tuplet 3/2 {b8 c cis} d8 b c a f d
    g f bes aes g ges f g
    d8 c b c e b' a4
    r1
    }
  >>
  \header { piece="lick 9" }
}


\score {
  <<
  \new ChordNames  \chordmode {d1:m7 | g:7 | c:7 | s}
  \new Staff \relative c' {
    d4 \tuplet 3/2 {f8 a c} e8 g f a,
    c8 e d c b aes g f
    e8 d f d e g r4
    r1
    }
  >>
  \header { piece="lick 10" }
}


\score {
  <<
  \new ChordNames  \chordmode {d1:m7 | g:7 | c:7 | s}
  \new Staff \relative c'' {
    \tuplet 3/2 {e8 f fis} \tuplet 3/2 {g ges f} e8 c r4
    \tuplet 3/2 {b8 c cis} \tuplet 3/2 {d des c} b8 g r4
    e8 f g b gis b a e~
    e4 r4 r2
    }
  >>
  \header { piece="lick 11" }
}


\score {
  <<
  \new ChordNames  \chordmode {d1:m7 | g:7 | c:7 | s}
  \new Staff \relative c'' {
    b8 c a f ais b g e
    gis a f d g4 r4
    gis8 a b gis a b c d
    b8 gis a e r8 e e4
    }
  >>
  \header { piece="lick 12" }
}

