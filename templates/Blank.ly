\version "2.18.2"

#(set-global-staff-size 28)

% Create blank staves
% http://lilypond.org/doc/v2.19/Documentation/snippets/staff-notation#staff-notation-creating-blank-staves

\paper {
  #(set-paper-size "letter")
  left-margin = 0.75\in
  right-margin = 0.75\in
  top-margin = 0.75\in
  bottom-margin = 0.5\in
  % markup-system-spacing = #'((padding . 10))
  % last-bottom-spacing = #'((padding . 5))
  % ragged-bottom = ##f
  % ragged-last = ##f
  ragged-last-bottom = ##f
  % ragged-right = ##f
}

\header {
  % title = "Blank Template"
  copyright = "Staff paper by Bartev"
  tagline = ##f
}

blankStaves = \score {
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

\blankStaves