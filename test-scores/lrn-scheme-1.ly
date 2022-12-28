\version "2.24.0"

\layout {
% Don't justify the output
  ragged-right = ##t
}

#(define (average a b c) (/ (+ a b c ) 3))

% Combine multiple definitions in 1 statement
#(begin
  (define foo 0)
  (define bar 1))

% Variables

% Lilypond style
twelve = 12

% Scheme style
#(define twelve_a 12)

% twelve and twelve_a are equivalent

% Can use LilyPond variables in Scheme expressions
twentyFour = #(* 2 twelve)


% When calling a variable with a backslash, \twelve, 
% it creates a copy of the value

traLaLa = { c'4 d'4 }
#(define newLa (map ly:music-deep-copy
                (list traLaLa traLaLa)))
#(define twice
  (make-sequential-music newLa))

\twice

\score { \traLaLa }

\traLaLa 

$(make-sequential-music newLa)

% 1.2.5 object properties

% alist-chains

% Set new value
% \override Stem.thickness = #2.6

% add '(thickness . 2.6) to the Stem alist
% thickness is relative to the thickness of staff lines,
% so these stems will be 2.6 times the width of staff lines


#(define (scoop-stencil grob)   
  (ly:stencil-combine-at-edge (ly:note-head::print grob) 0 -1 
   (grob-interpret-markup grob (markup #:with-dimensions '(0 . 0) '(0 . 0) 
     #:translate '( -2 . -2) #:musicglyph "brackettips.up" )) 0 0 )) 
scoop = \once \override NoteHead.stencil = #scoop-stencil 

\score { c4\scoop d e f }