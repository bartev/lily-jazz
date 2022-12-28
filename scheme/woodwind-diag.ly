\version "2.24.0"

% http://lilypond.org/doc/v2.18/Documentation/notation/text-markup-commands

#(print-keys 'saxophone)

\relative c' { c d e f }
\markup \woodwind-diagram
  #'saxophone #'()

\relative c' { c d e f }
\markup \woodwind-diagram
  #'saxophone #'(
    (lh  . (T ees d f front-f bes gis cis b low-bes)) 
    (cc . (one two three four five six)) 
    (rh  . (e c bes high-fis fis ees low-c)))

\markup \woodwind-diagram
  #'saxophone #'(
    (lh  . (ees f)) 
    (cc . ()) 
    (rh  . ()))

\markup \woodwind-diagram
  #'saxophone #'(
    (lh  . (d)) 
    (cc . ()) 
    (rh  . ()))

\markup \woodwind-diagram
  #'saxophone #'(
    (lh  . (front-f bes)) 
    (cc . ()) 
    (rh  . ()))

\markup \woodwind-diagram
  #'saxophone #'(
    (lh  . (front-f bes gis cis)) 
    (cc . ()) 
    (rh  . ()))

\relative c' { c d e f }
% \markup \woodwind-diagram
%   #'saxophone #'((lh  . (T)) 
%     (cc . (one)) 
%     (rh  . (e)))

% \markup \woodwind-diagram
%   #'saxophone #'((lh .()) 
%     (cc . (two)) 
%     (rh  . ()))

\markup \woodwind-diagram
  #'saxophone #'((lh .()) 
    (cc . (two four)) 
    (rh  . ()))

\relative c' { c d e f }
% \markup \woodwind-diagram
%   #'saxophone #'((lh  . (front-f)) 
%     (cc . ()) 
%     (rh  . ( bes )))


#(print-keys-verbose 'saxophone) 
\markup \woodwind-diagram
  #'saxophone #'((lh .()) 
    (cc . (two four six)) 
    (rh  . ()))
