\version "2.19.31"

\include "./font-stylesheets/lilyjazz.ily"
\include "./font-stylesheets/jazzchords.ily"

\header {
  title    = \markup { \fontsize #3 \override #'(font-name . "lilyjazz-text") "All Of Me" }
  composer = \markup { \fontsize #1 \override #'(font-name . "lilyjazz-text") "-Simons & Marks" }
  meter    = \markup { \fontsize #1 \override #'(font-name . "lilyjazz-text") "(Med. Swing)" }
  tagline  = \markup { \fontsize #1 \override #'(font-name . "lilyjazz-text") "(Typeset by BJV)" }
}

mychords  = \new ChordNames \with {
  \override ChordName #'font-size = #0
  \override ChordName #'font-name = #"lilyjazz-chord"
} \chordmode {
  c1:maj7 | c1:maj7 | e:7 | e:7 | 
  a:7 | a:7 | d:min7 | d:min7 | 
  e:7 | e:7 | a:min7 | a:min7 | 
}

melody = \new Staff \relative c'' {
  \jazzOn
  \clef treble
  \numericTimeSignature
  \time 4/4
  c4 g8 e~e2~ | e2 \tuplet 3/2 { c'4 d c } |
  b4 gis8 e~e2~ | e1 | \break
  
  a4. g8 e2~ | e4 dis e8 bes' a4 |
  g2 f2~ | f1 | \break
  
  e4. es8 d2~ | d2 e8 gis c4 |
  d2 c2~ | c1 |
  \bar "||"
}

mylyrics = \lyricmode {
  All of me | Why not take |
  all of me | |
  
  Can't you see | I'm no good with- |
  out you | |
  
  Take my lips | I want to |
  lose them | |
}

\showStartRepeatBar
<<
  \chords { \mychords }
  \melody
  \addlyrics { \mylyrics }
>>

\layout { indent = 0 }