\version "2.24.0"

% combine notes into chords
\relative c'' {
r4 <c e g> <c f a> 2
}

% combine notes into chords
\relative c'' {
  r4 <c e g>~ <c f a> 2 |
  <c e g>8[ <c f a> <c e g> <c f a>] 
            <c e g>8\>[ <c f a> <c f a> <c e g>]\! |
  r4 <c e g>8.\p <c f a>16( <c e g>4-. <c f a>) |
}

