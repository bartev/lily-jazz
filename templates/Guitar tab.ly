\version "2.18.2"

\paper {
  #(set-paper-size "letter")
  left-margin = 0.75\in
  right-margin = 0.75\in
  top-margin = 0.75\in
  bottom-margin = 0.5\in
  markup-system-spacing = #'((padding . 10))
  last-bottom-spacing = #'((padding . 5))
  ragged-bottom = ##f
  ragged-last = ##f
  ragged-last-bottom = ##f
  ragged-right = ##f
}

\header {
  title = "Guitar TAB Template"
  copyright = "Copyright ©"
  tagline = ##f
}

scoreBreaks = {
  \repeat unfold 8 { s1*10 \break }
}

guitarMusic = {
  R1*80 \bar "|."
}

\score {
  \new TabStaff <<
    \scoreBreaks
    %\clef moderntab  % uncomment for sans-serif TAB letters
    \transpose c c, \guitarMusic
  >>
  \layout {
    indent = 0
    \context {
      \TabStaff
      \revert MultiMeasureRest.stencil  % comment this out to remove MMRs

      %% by default, arpeggios are hidden, uncomment these to bring them back
      %\revert Arpeggio.stencil
      %\consists "Span_arpeggio_engraver"
      %connectArpeggios = ##t
    }
  }
  %\midi {}  % uncomment for midi output
}