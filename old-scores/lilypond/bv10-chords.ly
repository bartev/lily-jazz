\version "2.20.0"

                                % just prints chord names
\new ChordNames {
  \chordmode {
    c2 f4. g8
  }
}


chordmusic = \relative c' {
  \chordmode {
    c2 f:sus4 c1:/f
  }
}

<<
  \new ChordNames {
    \chordmusic
  }
  {
    \chordmusic
  }
>>

\markup "define mychords"

mychords = \chordmode{ c2 f4.:m g8:maj7 }

  \markup "use mychords"
  \chords {
    \mychords
  }

  \markup "use mychords 2"
  <<
    \chords {
      \mychords
    }
    {
      \mychords
    }
  >>

  \markup "use chordNames"
  \new ChordNames {
    \chordmode {
      \mychords
    }
  }