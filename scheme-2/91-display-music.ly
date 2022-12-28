\version "2.24.0"


% To inspect how a music expression is stored internally
% http://lilypond.org/doc/v2.18/Documentation/extending/displaying-music-expressions

{
  \displayMusic { c'4\f }
}


% To save this to a file
% lilypond 91-display-music.ly > display.txt

% or

{
  #(with-output-to-file "display.txt"
    (lambda () #{ \displayMusic { c'4\f } #})) 
}

myMusic = \relative c'' { 
        c8 e g\f bes\mf 
        c1
        d2 e4 ees 4
        f8 fis8 ges16 g8. 
        a8.. b8... c8 c, d, e, f, g,
        }
{
  #(with-output-to-file "display.txt"
    (lambda () #{ \displayMusic \myMusic #})) 
}


% (ly:make-duration 0) - whole note
% (ly:make-duration 1) - half note
% (ly:make-duration 2) - quarter note
% (ly:make-duration 3) - eigth note
% (ly:make-duration 4) - sixteenth note

% (ly:make-duration 2 1) - quarter note with 1 dot
% (ly:make-duration 2 2) - quarter note with 2 dots
% etc

melody = \relative c'' { bes8 c ees f g2 }

% \melody

% #(ly:music-transpose melody #{d#})