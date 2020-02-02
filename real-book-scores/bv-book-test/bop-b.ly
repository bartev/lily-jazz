\version "2.19.80"


fluteSolo = { \relative c'' { 
  \key c \major
  \time 2/2
  a4 b cis d 
} }

myChords = \chordmode {
  \set chordChanges = ##t
  c4:maj7
  c4:maj7
  d8:7
  g8:7
  c4:min
}

tit = "second song"
bop-b = \bookpart {
  \tocItem \markup \tit
  \header {
    title = \tit
  }
  \markup { "markup 2nd song" }
  \score { 
    <<
      \new ChordNames \myChords
      \new Voice = soloist \fluteSolo 
    >>
  }
}

\bop-b