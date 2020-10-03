\version "2.20.0"

% 2.5.1 Markup construction in Scheme

% http://lilypond.org/doc/v2.18/Documentation/extending/markup-construction-in-scheme


% in scheme, represented as
% (markup expr)

% To see a markup expression in scheme form, use \displayScheme
\displayScheme
\markup {
  \column{
    \line { \bold \italic "hello" \raise #0.4 "world" }
    \larger \line { foo bar baz }
}}

% (markup
%   #:line
%   (#:column
%    (#:line
%     (#:bold (#:italic "hello") #:raise 0.4 "world")
%     #:larger
%     (#:line
%      (#:simple "foo" #:simple "bar" #:simple "baz")))))


% Double box example
\displayScheme
\markup \override #'(box-padding . 0.4) \box 
  \override #'(box-padding . 0.6) \box A

#(define-markup-command (double-box layout props text) (markup?)
  "Draw a double box around text."
  (interpret-markup layout props
   #{
   \markup \override #'(box-padding . 0.4) \box 
  \override #'(box-padding . 0.6) \box { #text }
   #}))

% or equivalently

#(define-markup-command (double-box-two layout props text) (markup?)
  "Draw a double box around text."
  (interpret-markup layout props
   ( markup #:override '(box-padding . 0.4) #:box 
            #:override '(box-padding . 0.6) #:box text )))


\markup \double-box A

\markup \double-box-two B

% Adapting builtin commands

% draw a double line
 	
#(define-markup-command (my-draw-line layout props dest)
  (number-pair?)
  #:properties ((thickness 1)
                (line-gap 0.6))
  "..documentation.."
  (let* ((th (* (ly:output-def-lookup layout 'line-thickness)
                thickness))
         (dx (car dest))
         (dy (cdr dest))
         (w (/ line-gap 2.0))
         (x (cond ((= dx 0) w)
                  ((= dy 0) 0)
                  (else (/ w (sqrt (+ 1 (* (/ dx dy) (/ dx dy))))))))
         (y (* (if (< (* dx dy) 0) 1 -1)
               (cond ((= dy 0) w)
                     ((= dx 0) 0)
                     (else (/ w (sqrt (+ 1 (* (/ dy dx) (/ dy dx))))))))))
     (ly:stencil-add (make-line-stencil th x y (+ dx x) (+ dy y))
                     (make-line-stencil th (- x) (- y) (- dx x) (- dy y)))))

\markup \my-draw-line #'(4 . 4)
\markup \override #'(line-gap . 1.2) \override #'(thickness . 8) \my-draw-line #'(4 . 3)
