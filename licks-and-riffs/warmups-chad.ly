\version "2.18.2"

% https://www.youtube.com/watch?v=hOQL9grV7Lw

#(set-global-staff-size 24)
\include "jazzchords.ily"
\include "lilyjazz.ily"
\include "jazzextras.ily"

\header {
  title = "warm up exercises - chad"
  subtitle = "https://www.youtube.com/watch?v=hOQL9grV7Lw"
  tagline = # #f
}

global = { 
  \key c \major
  \numericTimeSignature
  \time 4/4
}

warmup_one_chords = \chordmode { \repeat percent 4 { c1:maj c:maj } }
warmup_one = \relative c' { 
  \global
  c8 d e f  g f e c
  d e f g  a g f d
  % e f g a  b a g e
  % f g a b  c b a f
  % g a b c  d c b g
  % a b c d  e d c a
  % b c d e  f e d b
  % c d e f  g f e c
  % c d e f  e d c b
}

warmup_two = \relative c' {
  \global
  c8 d e f  g f e cis
  d e f g   a g f dis
}

warmup_three = \relative c' {
  \global
  c8 d e g  f e d c
  d e f a  g f e d
}

warmup_four = \relative c' {
  \global
  c d e g  f fis dis e
} 
sec = {
  <<
    \new ChordNames {\set chordChanges = ##t \warmup_one_chords }
    \new Staff \warmup_one
  >>
  <<
    \new ChordNames {\set chordChanges = ##t \warmup_one_chords }
    \new Staff \warmup_two
  >>
  <<
    \new ChordNames {\set chordChanges = ##t \warmup_one_chords }
    \new Staff \warmup_three
  >>
  <<
    \new ChordNames {\set chordChanges = ##t \warmup_one_chords }
    \new Staff \warmup_four
  >>
}

\score {\sec}

% \score {\transpose c g \sec}

% \score {\transpose c d \sec}

% \score {\transpose c a \sec}

% \score {\transpose c e \sec}

% \score {\transpose c b, \sec}

% \score {\transpose c fis \sec}

% \score {\transpose c cis \sec}

% \score {\transpose c aes \sec}

% \score {\transpose c ees \sec}

% \score {\transpose c bes, \sec}

% \score {\transpose c f \sec}

