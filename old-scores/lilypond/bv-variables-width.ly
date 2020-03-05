\version "2.20.0"

width = 4.5\cm
name = "Wendy"
aFivePaper = \paper { paperheight = 21.0 \cm }

\paper {
  \aFivePaper
  line-width = \width
}

% \name is not working below
\relative c'' {
  {
    c4^"Peter"
    % c4_\name
  }
}
