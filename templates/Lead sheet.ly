\version "2.20.0"
\include "lilyjazz.ily"

#(set-global-staff-size 28)
\include "lilyjazz.ily"  % use jazz fonts for cleff and text

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
  title = ""
  copyright = ""
  tagline = ##f
}

scoreBreaks = {
  \repeat unfold 8 { s1*4 \break }
}

leadMusic = {
  s1*32 \bar "|."
}

\score {
	
  \new Staff <<		
    \scoreBreaks
    \leadMusic
  >>
  \layout {
    indent = 0
    \omit Staff.TimeSignature
		\override Score.Clef #'break-visibility = #'#(#f #f #f) % make only the first clef visible
    \override Score.SystemStartBar #'collapse-height = #1  % allow single-staff system bars
  }
  %\midi {}  % uncomment for midi output
}