\score {
  {
    \repeat unfold 5 { s1 \break }
  }
  \layout {
    #(layout-set-staff-size 28)
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
