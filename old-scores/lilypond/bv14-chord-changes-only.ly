\version "2.20.0"

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
