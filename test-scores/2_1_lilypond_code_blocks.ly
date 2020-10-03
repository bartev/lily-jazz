\version "2.20.0"

% 2.1 LilyPond code blocks

% http://lilypond.org/doc/v2.18/Documentation/extending/lilypond-code-blocks

% LilyPond code block looks like
% #{ LilyPond code #}

ritpp = #(define-event-function (parser location) ()
          #{ ^"rit." \p #}
        )

{ c'4 e'4\ritpp g'2 }

% Basic function format

% Scheme function

% function =
% #(define-scheme-function
%   (parser location arg1 arg2 …)
%   (type1? type2? …)
%   body)

% Music function


% function =
% #(define-music-function
%   (parser location arg1 arg2 …)
%   (type1? type2? …)
%   body)

% body is usually a LilyPond code block

% predefined type predicates
% http://lilypond.org/doc/v2.18/Documentation/notation/predefined-type-predicates

% 2.3.4 Intermediate substitution functions

manualBeam = 
#(define-music-function (parser location beg-end)
  (pair?)
  #{
  \once \override Beam.positions = #beg-end
  #})

\relative c' {
  \manualBeam #'(6 . 3) c8 d e f
}

manualBeamTwo = 
#(define-music-function (parser location beg end)
  (number? number?)
  #{
  \once \override Beam.positions = #(cons beg end)
  #})

\relative c' {
  \manualBeam #'(1 . 1) c8 d 
  \manualBeam #'(1 . 2) c8 d 
  \manualBeam #'(1 . 3) c8 d 
  \manualBeam #'(1 . 4) c8 d 

  \manualBeam #'(2 . 1) c8 d 
  \manualBeam #'(2 . 2) c8 d 
  \manualBeam #'(2 . 3) c8 d 
  \manualBeam #'(2 . 4) c8 d \break

  \manualBeamTwo #1 #1 c8 d
  \manualBeamTwo #1 #2 c8 d 
  \manualBeamTwo #1 #3 c8 d
  \manualBeamTwo #1 #4 c8 d 

  \manualBeamTwo #2 #1 c8 d
  \manualBeamTwo #4 #5 c8 d 
  \manualBeamTwo #2 #3 c8 d
  \manualBeamTwo #2 #4 c8 d 
}


crossStaff = 
#(define-music-function (parser location notes) (ly:music?)
  (_i "Create cross-staff stems")
  #{
  \temporary \override Stem.cross-staff = #cross-staff-connect
  \temporary \override Flag.style = #'no-flag
  #notes
  \revert Stem.cross-staff
  \revert Flag.style
#})

notes = \relative c {
  c8 d e f  g a b c 
  d e f g  a b c d
  e f g a  b c d e
}

\crossStaff \notes

% 2.3.5 Mathematics in functions

AltOn = 
#(define-music-function (parser location mag)
  (number?)
  #{
  \override Stem.length = #(* 7.0 mag)
  \override NoteHead.font-size = 
  #(inexact->exact (* (/ 6.0 (log 2.0)) (log mag)))
  #} )

AltOff = {
  \revert Stem.length
  \revert NoteHead.font-size
}

\relative c' {
  c2 \AltOn #0.5 c4 c
  \AltOn #1.5 c c \AltOff c2
}

withAlt = #(define-music-function (parser location mag music)
            (number? ly:music?)
            #{
              \override Stem.length = #(* 7.0 mag)
              \override NoteHead.font-size = 
            #(inexact->exact (* (/ 6.0 (log 2.0)) (log mag)))
            #music
            \revert Stem.length
            \revert NoteHead.font-size
            #} )


\relative c' {
  c2 \withAlt #0.5 { c4 c }
  \withAlt #1.5 { c c } c2
}
