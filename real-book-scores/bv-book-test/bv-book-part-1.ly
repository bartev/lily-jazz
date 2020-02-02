fb-book-part-a = \bookpart {
  \tocItem \markup "First song 1"
  \header {
    title = "First song - 1"
  }
  \markup { "markup 1st song" }
  \score { 
    <<
      \new ChordNames \myChords
      \new Voice = soloist \fluteSolo 
    >>
  }
}
