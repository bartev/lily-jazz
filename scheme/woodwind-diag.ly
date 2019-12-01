\version "2.18.2"

% http://lilypond.org/doc/v2.18/Documentation/notation/text-markup-commands

#(print-keys 'saxophone)

\relative c' { c d e f }
\markup \woodwind-diagram
  #'saxophone #'()

\relative c' { c d e f }
\markup \woodwind-diagram
  #'saxophone #'((lh  . (T ees d f front-f bes gis cis b low-bes)) 
    (cc . (one two three four five six)) 
    (rh  . (e c bes high-fis fis ees low-c)))

\relative c' { c d e f }
\markup \woodwind-diagram
  #'saxophone #'((lh  . (T)) 
    (cc . (one)) 
    (rh  . (e)))

\relative c' { c d e f }

\markup \woodwind-diagram
  #'saxophone #'((lh  . (front-f)) 
    (cc . ()) 
    (rh  . ( bes )))



