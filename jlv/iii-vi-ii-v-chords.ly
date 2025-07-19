\version "2.24.0"

#(set-global-staff-size 22)
\include "jazzextras.ily"
\include "jazzchords.ily"
\include "lilyjazz.ily"

\paper {
  #(set-paper-size "letter")
  #(define fonts
		(set-global-fonts
		 #:music "lilyjazz"
		 #:brace "lilyjazz"
		 #:roman "lilyjazz-text"
		 #:sans "lilyjazz-chord"
		 #:factor (/ staff-height pt 18)
	 ))
  ragged-last-bottom = ##t
  ragged-bottom = ##t
  indent = 0\cm
}

\header {
  % title = "ii-V-I chord progressions"
}

global = {
  \numericTimeSignature
  \time 4/4
  \key c \major

	%% make only the first clef visible
  \override Score.Clef.break-visibility = #'#(#f #f #f)

	%% make only the first time signature visible
  \override Score.KeySignature.break-visibility = #'#(#f #f #f)

	%% allow single-staff system bars
  \override Score.SystemStartBar.collapse-height = #1
}

myChords = \chordmode { e1:m7 a:7 d1:m7 g:7 c:maj7 e2:dim7 a:7 \break }
%% see jazzextras.ily for jazz rests
%% rests = { \repeat unfold 6 { \rs } }
spaces = { \repeat unfold 6 { s1 } }

by_fifths = \score {
	\header { piece = "iii-VI-ii-V-I chord progressions by 5ths" }
	<<
		\new ChordNames {
			\myChords
			\transpose c g \myChords
			\transpose c d \myChords
			\transpose c a \myChords
			\transpose c e \myChords
			\transpose c b \myChords
			\transpose c fis \myChords
			\transpose c des \myChords
			\transpose c aes \myChords
			\transpose c ees \myChords
			\transpose c bes \myChords
			\transpose c f \myChords
		}
		\new Staff {
			\global
			\bar ".|-|"
			%% \repeat unfold 48 \rests
			\repeat unfold 12 \spaces
			\bar "|."
		}
	>>
}


by_fourths = \score {
	\header { piece = "iii-VI-ii-V-I chord progressions by 4ths" }
	<<
		\new ChordNames {
			\myChords
			\transpose c f \myChords
			\transpose c bes \myChords
			\transpose c ees \myChords
			\transpose c aes \myChords
			\transpose c des \myChords
			\transpose c fis \myChords
			\transpose c b \myChords
			\transpose c e \myChords
			\transpose c a \myChords
			\transpose c d \myChords
			\transpose c g \myChords
		}
		\new Staff {
			\global
			\bar ".|-|"
			%% \repeat unfold 48 \rests
			\repeat unfold 12 \spaces
			\bar "|."
		}
	>>
}

by_chromatic = \score {
	\header { piece = "iii-VI-ii-V-I chord progressions - chromatic" }
	<<
		\new ChordNames {
			\myChords
			\transpose c des \myChords
			\transpose c d \myChords
			\transpose c ees \myChords
			\transpose c e \myChords
			\transpose c f \myChords
			\transpose c fis \myChords
			\transpose c g \myChords
			\transpose c aes \myChords
			\transpose c a \myChords
			\transpose c bes \myChords
			\transpose c b \myChords
		}
		\new Staff {
			\global
			\bar ".|-|"
			%% \repeat unfold 48 \rests
			\repeat unfold 12 \spaces
			\bar "|."
		}
	>>
}

\by_fifths
\pageBreak
\by_fourths