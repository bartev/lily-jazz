\version "2.18.2"

% WHY DOESN'T THIS WORK?

% from a comment from this blog
% https://lilypondblog.org/2014/04/music-functions-3-reusing-code/

% Wrap the input list of music elements in a single sequential
% music element


% note, this is a scheme function
% e.g. (https://see.stanford.edu/materials/icsppcs107/30-Scheme-Functions.pdf)
% (define (celsius->fahrenheit celsius) (+ (* 1.8 celsius) 32))
% the stuff in () is the name and param list

#(define (wrap-music-list music-list)
(let ((out #{ {} #} ))
     (ly:music-set-property! out 'elements music-list)
     out))

colorGrob =
#(define-music-function (parser location my-grob my-color)
(symbol? color?)
#{
 \temporary \override #my-grob #'color = #my-color
#})

uncolorGrob = 
#(define-music-function (parser location my-grob)
(symbol?)
#{
\revert #my-grob #'color
#})

colorGrobs = 
#(define-music-function (parser location grobs color)
(symbol-list? color?)
(wrap-music-list
  (map 
     (lambda (arg) #{ \colorGrob $arg $color #})
     grobs)))

uncolorGrobs = 
#(define-music-function (parser location grobs)
(symbol-list?)
(wrap-music-list
  (map
     (lambda (arg) #{ \uncolorGrob $arg #})
     grobs)))


#(define grobs (list 
      NoteHead
      Stem
      Flag
      Beam
      Rest
      Slur
      PhrasingSlur
      Tie
      Script
      Dots))

colorMusic = 
#(define-music-function (param location grobs color music)
  #{
  \colorGrobs \grobs \color 
  \music
  \uncolorGrobs \grobs
  #}
)

music = \relative c' {
 c4. d8 e16 d r cis( d4) ~ | d1 \fermata
}

\relative c' {
\colorMusic \grobs #blue \music
\colorMusic \grobs #red {c4 c} d
\colorMusic \grobs #green e\f
\colorMusic \grobs #magenta \music
}

