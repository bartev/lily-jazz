\version "2.18.2"

#(set-global-staff-size 23)
\include "jazzextras.ily"
\include "jazzchords.ily"
\include "lilyjazz.ily"

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

\header {
  title = "Dominant 7 Resolutions (BV copy)"
}

global = {
  \time 4/4
  \key c \major
}

mychords = \chordmode { g1:7 c1 }
% see jazzextras.ily for jazz rests
rests = { \repeat unfold #8 { \rs } }

single_transition = \score {
  <<
    \new ChordNames \mychords
    \new Staff { \repeat unfold #8 { \rs } }
  >>
}


\score {
  <<
    \new ChordNames {
      \transpose g g \mychords
      \transpose g c \mychords
      \transpose g f \mychords
      \transpose g bes \mychords
      \transpose g ees \mychords
      \transpose g aes \mychords
      \transpose g cis \mychords
      \transpose g fis \mychords
      \transpose g b \mychords
      \transpose g e \mychords
      \transpose g a \mychords
      \transpose g d \mychords
    }
    \new Staff {
      \bar "[|:"
      \repeat unfold #12 \rests 
      \bar ":|]" }
  >>
}

\score {
  <<
    \new ChordNames {
      \transpose g g \mychords
      \transpose g f \mychords
      \transpose g ees \mychords
      \transpose g cis \mychords
      \transpose g b \mychords
      \transpose g a \mychords
      \transpose g aes \mychords
      \transpose g fis \mychords
      \transpose g e \mychords
      \transpose g d \mychords
      \transpose g c \mychords
      \transpose g bes \mychords
    }
    \new Staff {
      \bar "[|:"
      \repeat unfold #12 \rests
      \bar ":|]" }
  >>
}

% 1
\score {
  <<
    \new ChordNames \mychords
    \new Staff \relative c'' {
      \global
      d8 f e d g f e d
      c2 r2
    }
  >>
}

% 2
\score {
  <<
    \new ChordNames \mychords
    \relative c'' {
      \global
      b8 f a f b aes g f
      e2 r2
    }
  >>
}

% 3
\score {
  <<
    \new ChordNames \mychords
    \relative c''' {
      \global
      a8 c a bes b bes a aes
      g2 r2
    }
  >>
}

% 4
\score {
  <<
    \new ChordNames \mychords
    \relative c'' {
      \global
      d8 a c a b aes' f fis
      g2 r2
    }
  >>
}


% 5
\score {
  <<
    \new ChordNames \mychords
    \relative c'' {
      \global
      d8 e f g a f e d
      c2 r2
    }
  >>
}


% 6
\score {
  <<
    \new ChordNames \mychords
    \relative c''' {
      \global
      a8 f e d ees ges b a
      g2 r2
    }
  >>
}


% 7
\score {
  <<
    \new ChordNames \mychords
    \relative c'' {
      \global
      b8 aes' f fis g f e d
      c2 r2
    }
  >>
}


% 8
\score {
  <<
    \new ChordNames \mychords
    \relative c'' {
      \global
      b8 aes g fis f g a b
      c2 r2
    }
  >>
}


% 9
\score {
  <<
    \new ChordNames \mychords
    \relative c''' {
      \global
      a8 c b g aes a f d
      g2 r2
    }
  >>
}


% 10
\score {
  <<
    \new ChordNames \mychords
    \relative c'' {
      \global
      f8 a, ais b e ees d des
      c2 r2
    }
  >>
}


% 11
\score {
  <<
    \new ChordNames \mychords
    \relative c'' {
      \global
      d8 e f g bes aes f fis
      g2 r2
    }
  >>
}


% 12
\score {
  <<
    \new ChordNames \mychords
    \relative c'' {
      \global
      d8 f e d g dis b g
      c2 r2
    }
  >>
}
