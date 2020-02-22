\version "2.18.2"

\include "jazzextras.ily"
\include "jazzchords.ily"
\include "lilyjazz.ily"

startParenthesis = {
  \once \override ParenthesesItem.stencils = #(lambda (grob)
        (let ((par-list (parentheses-item::calc-parenthesis-stencils grob)))
          (list (car par-list) point-stencil )))
}

endParenthesis = {
  \once \override ParenthesesItem.stencils = #(lambda (grob)
        (let ((par-list (parentheses-item::calc-parenthesis-stencils grob)))
          (list point-stencil (cadr par-list))))
} 

\header {
  title = "Copied licks - Rollins, pink panther, Brecker?"
}

global = {
  \time 4/4
  \key c \major
}

chordNames = \chordmode {
  \global
  fis1:7 b2:m7 e2:7
  
}

melody = \relative c'' {
  \global
  r2 r4 r8 fis8-1~ | 
  fis4-5 g8 -6 gis-6 a-11 fis-9 r4 
}

words = \lyricmode {
  
  
}

\score {
  <<
    \new ChordNames \chordNames
    \new Staff { \melody }
  >>
}

\score {
  <<
    \new ChordNames \chordmode { a1:7  d1 }
  
  { 
    \global
     \relative c'' {r2 r4 e8-5 cis-3 | d4-1 fis8-3 d-1 e-2 d-1 a4-5 }
  }
  >>
}

% Blues for Philly Joe (Sonny Rollins)
\score {
  <<
    \new ChordNames \chordmode { a1:m7  d1:7 g}
  
  { 
    \global
     \relative c'' {r8   \override ParenthesesItem.font-size = #5
       \startParenthesis \parenthesize c8 a c e g b g | 
       r8 \endParenthesis \parenthesize b8 r g a b c d | 
       b8 g r4 r2 }
  }
  >>
}

% Blues for Philly Joe (Sonny Rollins)
\score {
  <<
    \new ChordNames \chordmode { e1:7 a2:m7  d2:7 g}
  
  { 
    \global
     \relative c'' {r4 r8 d8 b' gis e4 |
     a8 b c4 b8 g d4 
     g4 r8 d8 b' g d c}
  }
  >>
}

% Blues for Philly Joe (Sonny Rollins)
\score {
  <<
    \new ChordNames \chordmode { g1:7 c1:7}
  
  { 
    \global
     \relative c''' { 
       \override ParenthesesItem.font-size = #0.5
       \startParenthesis \parenthesize d4 \endParenthesis \parenthesize d8 
       c b g f a | 
       g8 e c a bes4 r4
       \bar "||"
       a'8 c b g r4 f8 a
       g8 e r4 c8 a bes4}
  }
  >>
}

% pink panther
\score {
  <<
    \new ChordNames \chordmode { a1:m6 a:m6 d:7}
  
  { 
    \global
     \relative c' {
     r4 r8 e8 a b c d
     e8 a, ees' a, d a c a
     b8 a g e~ e4 r4
  }
  }
  >>
}

