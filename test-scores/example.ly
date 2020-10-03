\version "2.20.0"

\layout {
% Don't justify the output
  ragged-right = ##t
}

melody = \relative c'' { r4 d8\noBeam g, c4 r8 r8 }
text   = \lyricmode { And God said,}
upper  = \relative c'' { <g d g,>2~ <g d g,> }
lower  = \relative c { b2 e }

\score 
{
  <<
    \new Staff = "singer" << 
      \new Voice = "vocal" { \melody }
      \addlyrics { \text }
    >>
    \new PianoStaff = "piano"  << 
      \new Staff = "upper"  { \upper }
      \new Staff = "lower"  
      { 
        \clef "bass"
        \lower 
      }
    >>
  >>
  
}
