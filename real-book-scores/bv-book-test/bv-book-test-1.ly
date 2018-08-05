\version "2.19.80"

\header {
  title = "The Real Book"
  }
\pageBreak

\markuplist \table-of-contents
\pageBreak

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

fb-book-part = \bookpart {
  \tocItem \markup "First song"
  \header {
    title = "First song"
  }
  \markup { "markup first song" }
  \score { 
    <<
      \new ChordNames \myChords
      \new Voice = soloist \fluteSolo 
    >>
  }
}

\fb-book-part

\include "bv-book-part-1.ly"

\fb-book-part-a

\bookpart {
  \tocItem \markup "Second song"
  \header {
    title = "Second song"
    % subtitle = "First part"
  }
  \markup { "markup second song" }
  \score { \relative c' { c8 d d e e f f g } }
}