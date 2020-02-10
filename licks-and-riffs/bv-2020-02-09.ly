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
  title = "Copied licks - Konitz"
}

\paper {
  ragged-bottom = ##t
}
global = {
  \time 4/4
  \key c \major
}

% There will never be another you - Konitz ~50sec

lick_i ={
  \global
  \relative c'' {
    r8 d8 b g f r8 r4
  }
}
%
chords_i = \new ChordNames \chordmode { g:7 }

mus_i = <<
  \chords_i
  \lick_i
>>

\score {
 <<
    \chords_i
     \lick_i
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
