\version "2.20.0"

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
  title = "transcribed licks 2020-02-09"
}

\paper {
  ragged-bottom = ##t
}
global = {
  \numericTimeSignature
  \time 4/4
  \key c \major

  % make only the first clef visible
  \override Score.Clef #'break-visibility = #'#(#f #f #f)

  % make only the first time signature visible
  \override Score.KeySignature #'break-visibility = #'#(#f #f #f)

  % allow single-staff system bars
  \override Score.SystemStartBar #'collapse-height = #1
}

% 1
% There will never be another you - Konitz ~50sec
lick_i = \relative c'' { \global r8 d8 b g f r8 r4 }
chords_i = \chordmode { g1:7 } 

\score {
  <<
  \new ChordNames \chords_i
  \new Staff \lick_i
  >>
}

% 2 Blues for Philly Joe (Sonny Rollins)
lick_ii = \relative c'' { \global r4 r8 d8 b' g d c }

\score {
  <<
  \new ChordNames \chords_i 
  \new Staff \lick_ii 
  >>
}

% 3
chords_iii = \chordmode { 
  
  g1:m7^ c1:7 f1:7.9 }
lick_iii = \relative c'' { \global a8 bes c4 a8 g r4 }
\score {
  <<
  \new ChordNames {
  \once \override Score.RehearsalMark.self-alignment-X = #LEFT 
  \mark "Note: same rhythm fits over all these chords (ii-V-I)" 
  \chords_iii
  }
  \new Staff \repeat unfold 3 \lick_iii
  >>

}

% 4
\score {
 <<
 \new ChordNames \chordmode { bes1:7 bes1:7  bes1:7 f1:7}
  \new Staff \relative c'' { \global \repeat unfold #2
  { r2 r4 r8 d8 ees e f e! ees d ees! f \bar "||"}
  }
  >>
}

% 5
\score {
 <<
 \new ChordNames \chordmode { a1:m7 d1:7 f1:}
 \new Staff \relative c'' { \global \repeat unfold #3
  { b8 c~ c4 a-. r4 \bar "||"}
  }
  >>
}

% \score {
%   <<
%     \transpose d b  \chords_i
%     \transpose d b, \lick_i
%   >>
% }
%
% \score {
%   <<
%     \transpose d a  \chords_i
%     \transpose d a, \lick_i
%   >>
% }
%


\score {
  {
    \repeat unfold 5 { s1 \break }
  }
  \layout {
    #(layout-set-staff-size 28)
    indent = 0\in
    \context {
      \Staff
      \remove "Time_signature_engraver"
      \remove "Clef_engraver"
      \remove "Bar_engraver"
    }
    \context {
      \Score
      \remove "Bar_number_engraver"
    }
  }
}
