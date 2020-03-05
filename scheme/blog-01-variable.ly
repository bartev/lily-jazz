\version "2.20.0"

% define a variable using the usual LilyPond syntax
bpmA = 60

% define a variable using Scheme
#(define bpmB 72)

{
  % assign a tempo literally
  \tempo 8 = 54
  R1

  % assign tempos using the LilyPond syntax for variables
  \tempo 8 = \bpmA
  R1

  \tempo 8 = \bpmB
  R1

   % assign tempos by referencing variables using Scheme
  \tempo 8 = #bpmA
  R1

  \tempo 8 = #bpmB
  R1
}
