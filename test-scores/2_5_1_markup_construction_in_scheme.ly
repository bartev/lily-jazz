\version "2.19.31"

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