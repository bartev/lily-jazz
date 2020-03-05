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
\score {
 <<
 \new ChordNames \chordmode { g:7 }
  \relative c'' { \global r8 d8 b g f r8 r4 }
  >>
}

% 2
\score {
 <<
 \new ChordNames \chordmode { g1:m7 c1:7 f1:7.9 }
  \relative c'' { \global \repeat unfold #3 { a8 bes c4 a8 g r4} }
  >>
}

% 3
\score {
 <<
 \new ChordNames \chordmode { bes1:7 bes1:7  bes1:7 f1}
  \relative c'' { \global \repeat unfold #2
  { r2 r4 r8 d8 ees e f e! ees d ees! f} 
  }
  >>
}

% 4
\score {
 <<
 \new ChordNames \chordmode { a1:m7 d1:7 f1:}
  \relative c'' { \global \repeat unfold #3
  { b8 c~ c4 a-. r4 } 
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
