\version "2.24.0"

% http://lilypond.org/doc/v2.18/Documentation/extending/lilypond-variables

#(define (average a b c) (/ (+ a b c) 3 ))

#(begin
  (define foo 0)
  (define bar 1)
)

% these are equivalent ways of defining variables
twelve = 12
#(define thirteen 13)

twentyFour = #(* 2 twelve)

traLaLa = { c'4 d'4 }

#(define newLa (map ly:music-deep-copy
         (list traLaLa traLaLa)))
#(define twice
  (make-sequential-music newLa))


% 2 ways of running this code

\twice

$(make-sequential-music newLa)

{ #(first newLa) }

{ #(first newLa) #(last newLa) }

% option properties
% stored in alist-chains (lists of alists)

% set value for property: assign value to the alist (key-value)
% \override Stem.thickness = #2.6

% An alist entry '(thickness . 2.6) is added to the 
% property list of the Stem object

% http://lilypond.org/doc/v2.18/Documentation/extending/lilypond-compound-variables
% \override TextScript.extra-offset = #'(1 . 2)
% (1 . 2) = (x-coord . y-coord)
% These numbers are measured in staff-spaces, so this command 
% moves the object 1 staff space to the right, and 2 spaces up.



% display music expressions
% http://lilypond.org/doc/v2.18/Documentation/extending/displaying-music-expressions
{
  \displayMusic { c'4\f }
}

{
  #(with-output-to-file "new-display.txt"
    (lambda () #{ \displayMusic { c'4\f } #}))
}