% Melody for c instrument
% Include key signature here

melody =  \relative c'' {
  \key c \major
  \time 4/4
    c4 d e f | g a b c | \bar "|."
}

piano  = {
  \set Staff.instrumentName = #"Piano"
  \clef treble
  <<
    \melody
    % \harmony
  >>
}

alto =  {
  \set Staff.instrumentName = #"Alto Sax"
  \clef treble
  \transpose es c \melody 
}

bari =  {
  \set Staff.instrumentName = #"Bari Sax"
  \clef bass
  \transpose es c,, \melody
}

tenor = {
  \set Staff.instrumentName = #"Tenor Sax"
  \clef treble
  \transpose bes c' \melody
}

soprano = \transpose bes c {
  \set Staff.instrumentName = #"Soprano Sax"
  \clef treble
  \melody
}


harmony =  \chordmode {
  c2:7 g:m | d:maj ces:m7
}

% \new ChordNames \with {
%   \override ChordName #'font-size = #0
%   \override ChordName #'font-name = #"lilyjazzchord"
% }
