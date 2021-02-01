\version "2.20.0"

                                % size = 28 -> 10 staves
#(set-global-staff-size 28)

                                % Create blank staves
                                % http://lilypond.org/doc/v2.19/Documentation/snippets/staff-notation#staff-notation-creating-blank-staves

\paper {
  #(set-paper-size "letter")
  left-margin = 0.75\in
  right-margin = 0.75\in
  top-margin = 1\in
  bottom-margin = 0.75\in
  ragged-last-bottom = ##f
}

\header {
  copyright = "Staff paper by Bartev"
  copyright = ##f
  tagline = ##f
}

\score {
  {
    \repeat unfold 12 { s1 \break }
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
