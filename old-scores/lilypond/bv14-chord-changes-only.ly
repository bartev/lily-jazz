\version "2.19.31"

chordmusic = \chordmode { c2 c | c c/g | c/g d }

<<
  \chords { \chordmusic }
	{ \chordmusic }
>>

<<
  \chords { 
	\set chordChanges = ##t
	\chordmusic 
	}
	{ \chordmusic }
>>
