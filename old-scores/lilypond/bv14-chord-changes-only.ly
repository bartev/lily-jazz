\version "2.24.0"

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
