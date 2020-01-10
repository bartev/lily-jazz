\version "2.18.2"

% #(set-global-staff-size 26)
\include "jazzchords.ily"
\include "lilyjazz.ily"
\include "jazzextras.ily"

\include "there-will-never-be-another-you.ly"

chords_twnbay_line_one = \chordmode {
  ees1:maj7 | ees1:maj7 | d:m7.5- | g:7.9-
  }

twnbay_bjv = \score {
  <<

  \new ChordNames \chordmode {
  c1:maj7 | c1:maj7 | b:m7.5- | e1:7.9-
  c1:maj7 | c1:maj7 | b:m7.5- | e1:7.9-
  c1:maj7 | c1:maj7 | b:m7.5- | e1:7.9-
  c1:maj7 | c1:maj7 | b:m7.5- | e1:7.9-
  
  a1:min7 | a1:min7 | g1:min7 | c1:7
  f1:maj7 | bes1:7.11+
  }
  \new Staff \relative c''' {
    \global
    \key c \major
    \bar ".|"
    g8 r8 r4 g4 r8 fis8 
    g2 r4 r8 fis8
    f2 r2
    r4 r8 fis8 g fis f4
    \break

    r1
    r1
    r1
    d4 dis e r8 g8 
    \break

    e8 a,4 r8 r2
    s1
    s1
    s1
    \break

    r8 c'8 a bes8 r8 a fis g
    r8 a8 fis g   r8 fis dis e
    r8 g8 e f     r8 e cis d
    r8 b8 ais a gis~ gis 4 r8
    \break

    s1
    s1
    s1
    r4 r8 b8 c b bes4
    \break

    a2 r2
    s1
  }
  >>
}

\twnbay_bjv