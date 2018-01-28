\version "2.19.31"

mychords = \chordmode { c2 g:sus4 f:maj e:min7 }
mynotes = \relative c'' {
    a4 e c8 e r4
    b2 c4( d)
  }

<<
  \chords { \mychords }
  \mynotes
  \addlyrics { One day this shall be free __ }
>>

\markup { add a stave with the chords }
\markup { }
\markup { }
<<
  \chords { \mychords }
  \mynotes
  \addlyrics { One day this shall be free __ }

	{
      \mychords
    }
>>

\new ChordNames{
	\mychords
}

{ \chords {
	\mychords
}
}