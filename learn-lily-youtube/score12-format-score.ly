\version "2.24.0"

\header {
  title = "title"
  composer = "composer"
  tagline = # #f
}

\paper { 
  % set-paper-size function
  % note: landscape has a single quote in front of it
  #(set-paper-size "letter"  'landscape)
  % #(set-paper-size "11x17" 'landscape)
  % #(set-paper-size "5x7"  'landscape)
  % #(set-paper-size "legal")
  % #(set-paper-size "tabloid")
}

{ f g a b }