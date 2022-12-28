\version "2.24.0"

% https://lilypondblog.org/2014/04/music-functions-3-reusing-code/

% rewrite the function from 
% blog-03-function-w-arg.ly


% grob = GRaphicalOBject
% color? predicate for color
% grob name must be a symbol (symbol?)


colorGrob =
#(define-music-function (my-grob my-color)
(symbol? color?)
#{
 \temporary \override #my-grob #'color = #my-color
#})

uncolorGrob = 
#(define-music-function (my-grob)
(symbol?)
#{
\revert #my-grob #'color
#})

colorMusic =
#(define-music-function (my-color music)
   (color? ly:music?)
   #{
     \colorGrob NoteHead #my-color
     \colorGrob Stem #my-color
     \colorGrob Flag #my-color
     \colorGrob Beam #my-color
     \colorGrob Rest #my-color
     \colorGrob Slur #my-color
     \colorGrob PhrasingSlur #my-color
     \colorGrob Tie #my-color
     \colorGrob Script #my-color
     \colorGrob Dots #my-color

     #music

     \uncolorGrob NoteHead
     \uncolorGrob Stem
     \uncolorGrob Flag
     \uncolorGrob Beam
     \uncolorGrob Rest
     \uncolorGrob Slur
     \uncolorGrob PhrasingSlur
     \uncolorGrob Tie
     \uncolorGrob Script
     \uncolorGrob Dots
   #})

music = \relative c' {
 c4. d8 e16 d r cis( d4) ~ | d1 \fermata
}


\relative c' {
\colorMusic #blue \music
\colorMusic #red {c4 c} d
\colorMusic #green e\f
\colorMusic #magenta \music
}


% Using a list as an argument

% (map colorGrob my-grob-list)
% takes a function and a list of values, and applies thf funcgtion to each of the
% values 1 by 1.
% Returns a new list of modified values


% using a lambda function
% ((lambda (arg) (colorGrob arg my-color)) NoteHead)
% Here, `NoteHead` is the arg passed to the lambda function

% each element of my-grob-list is passed in turn to the lambda function as arg
% (map (lambda (arg) (colorGrob arg my-color)) my-grob-list)

% map creates a list of music expressions, but we need a single music expression
% so, we'll need to use recursion

% colorGrobs = 
% #(define-music-function (my-grob-list my-color)
%  (symbol-list? color?)
%  #{

%  #})


