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
  title = "Blank Template"
  copyright = "Copyright ©"
  tagline = ##f
}

scoreBreaks = {

}

theMusic = {

}

\score {
  \new Staff <<
    \scoreBreaks
    \theMusic
  >>
  \layout { }
  %\midi {}  % uncomment for midi output
}