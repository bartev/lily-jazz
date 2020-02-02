\version "2.18.2"

#(set-global-staff-size 28)

% Create blank staves
% http://lilypond.org/doc/v2.19/Documentation/snippets/staff-notation#staff-notation-creating-blank-staves

\paper {
  #(set-paper-size "letter")
  left-margin = 0.5\in
  right-margin = 0.5\in
  top-margin = 0.25\in
  bottom-margin = 0.25\in
  ragged-last-bottom = ##f
}

\header {
  copyright = "Staff paper by Bartev"
  copyright = ##f
  tagline = ##f
}

\score {
  {
    \repeat unfold 10 { s1 \break }
  }
  \layout {
    indent = 0\in
    \context {
      \Staff
      \remove "Time_signature_engraver"
      \remove "Clef_engraver"
      \remove "Bar_engraver"
    }
    \context {
      \Score
      \remove "Bar_number_engraver"
    }
  }
}
