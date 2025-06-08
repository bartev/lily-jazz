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

myChords = \chordmode {
	d2 g:maj7
	fis:m7 b:7.9
	e1:m7
	a1:7
	e1:m7
	a1:7
	d2 b:m7
	e2:m7 a:7
	\break }
%% see jazzextras.ily for jazz rests
rests = { \repeat unfold 8 { \rs \rs \rs \rs } }
spaces = { \repeat unfold 8 { s1 } }

\score {
	\header { piece = "I Want to be Happy Sec A chord progressions by 5ths" }
	<<
		\new ChordNames {
			%% \myChords
			\transpose d d \myChords \bar "||"
			\transpose d a \myChords \bar "||"
			\transpose d e \myChords \bar "||"
			\transpose d b \myChords \bar "||"
			\transpose d fis \myChords \bar "||"
			\transpose d des \myChords \bar "||"
			\transpose d aes \myChords \bar "||"
			\transpose d ees \myChords \bar "||"
			\transpose d bes \myChords \bar "||"
			\transpose d f \myChords \bar "||"
			\transpose d g \myChords \bar "||"
		}
		\new Staff {
			\global
			\bar ".|-|"
			%% \repeat unfold 11 \rests
			\repeat unfold 11 \spaces
			\bar "|."
		}
	>>
}

%% \pageBreak

%% \score {
%% 	\header { piece = "ii-V-I chord progressions by 4ths" }
%% 	<<
%% 		\new ChordNames {
%% 			\myChords
%% 			\transpose c f \myChords
%% 			\transpose c bes \myChords
%% 			\transpose c ees \myChords
%% 			\transpose c aes \myChords
%% 			\transpose c des \myChords
%% 			\transpose c fis \myChords
%% 			\transpose c b \myChords
%% 			\transpose c e \myChords
%% 			\transpose c a \myChords
%% 			\transpose c d \myChords
%% 			\transpose c g \myChords
%% 		}
%% 		\new Staff {
%% 			\global
%% 			\bar ".|-|"
%% 			%% \repeat unfold 48 \rests
%% 			\repeat unfold 12 \spaces
%% 			\bar "|."
%% 		}
%% 	>>
%% }

%% \pageBreak

%% \score {
%% 	\header { piece = "ii-V-I chord progressions - chromatic" }
%% 	<<
%% 		\new ChordNames {
%% 			\myChords
%% 			\transpose c des \myChords
%% 			\transpose c d \myChords
%% 			\transpose c ees \myChords
%% 			\transpose c e \myChords
%% 			\transpose c f \myChords
%% 			\transpose c fis \myChords
%% 			\transpose c g \myChords
%% 			\transpose c aes \myChords
%% 			\transpose c a \myChords
%% 			\transpose c bes \myChords
%% 			\transpose c b \myChords
%% 		}
%% 		\new Staff {
%% 			\global
%% 			\bar ".|-|"
%% 			%% \repeat unfold 48 \rests
%% 			\repeat unfold 12 \spaces
%% 			\bar "|."
%% 		}
%% 	>>
%% }