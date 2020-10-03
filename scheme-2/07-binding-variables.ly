\version "2.20.0"


 % This is written in a LilyPond file 
variableA = "Hello, I'm defined in LilyPond" 

#(define variableB "And I'm defined in Scheme")


% Schema allows more freedom in naming variables
#(define solo9 "abc")

#solo9

% Cannot reference this way
% \solo9

% local binding with `let`
% Create a pair with a color and a damping factor 
#(define props (cons yellow 1.3)) 

dampedYellow = #(list 
             (/ (first (car props)) (cdr props)) 
             (/ (second (car props)) (cdr props)) 
             (/ (third (car props)) (cdr props)))

#(display "\n")
#(display dampedYellow)


dampedYellowWithLet = #(let 
                    ((color (car props)) 
                     (damping (cdr props))) 
                     (list (/ (first color) damping) 
                           (/ (second color) damping) 
                           (/ (third color) damping)))

#(display "\n")
#(display dampedYellowWithLet)