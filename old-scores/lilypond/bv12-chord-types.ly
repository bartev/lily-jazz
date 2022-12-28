\version "2.24.0"

chordmusic = \chordmode { 
	c1 	| c:maj | 
	d:m | d:m7 | 
	e:aug | e:aug7 | 
	f:dim | f:dim7 }

% \markup { add a stave with the chords }
<<
  \chords { \chordmusic }
	{
      \chordmusic
    }
>>
