\version "2.20.0"

\header {
  title = "My Score"
  composer = "Composer"
}

\language "english"

<<
  \new Staff \with {instrumentName = "Violin I"}
  \relative c' {
  \numericTimeSignature \time 4/4
  c4 d8[ e\harmonic f g] a4
  c4\snappizzicato d8[ e\harmonic f g] a4
  \time 3/2
  e'2\flageolet b_\flageolet f
  % artificial harmonic
  \set harmonicDots = ##t

  }
>>