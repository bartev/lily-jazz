\version "2.18.2"
\language "english"

\header {
  title = "title"
  composer = "composer"
  tagline = # #f
}

\paper { 
  % set-paper-size function
  % note: landscape has a single quote in front of it
  #(set-paper-size "letter")
}

global = { 
  \key e \minor
  \time 3/4
}

fun = \relative c'' {
  \global
  ef g d | f d bf
}

morefun = \relative c' {
  \global
  d f g | bf af f
}

<<
\fun
\morefun
>>