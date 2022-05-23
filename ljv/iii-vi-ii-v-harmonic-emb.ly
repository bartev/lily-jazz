\version "2.20.0"

#(set-global-staff-size 16)
\include "jazzextras.ily"
\include "jazzchords.ily"
\include "lilyjazz.ily"
\include "roman_numeral_analysis_tool.ily"

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
  \override Score.Clef #'break-visibility = #'#(#f #f #f)

	%% make only the first time signature visible
  \override Score.KeySignature #'break-visibility = #'#(#f #f #f)

	%% allow single-staff system bars
  \override Score.SystemStartBar #'collapse-height = #1
}

myChords = \chordmode { e1:m7 a:7 d1:m7 g:7 
                        e1:m7 a:7 d1:m7 g:7 }

phraseC = \relative c' {
  r8 fis \tuplet 3/2 { b8 d fis } ees8 e d c
  cis8 c' \tuplet 3/2 { bes8 f des } c8 b ais gis
  \break
  a8 ees e g16 ges f8 g a c
  e8 ees d des c a f ees
  \break
  e8 g d b c f g16 f d8
  e1
  s1
  s1
  \break
}

scaleDegreesC = \lyrics {
  "" 8
  \markup \scaleDegree { 9 }8
  \tuplet 3/2 {
  \markup \scaleDegree { 5 }8
  \markup \scaleDegree { f7 }8
  \markup \scaleDegree { 9 }8
}
  \markup \scaleDegree { f1 }8
  \markup \scaleDegree { 1 }8
  \markup \scaleDegree { f7 }8
  \markup \scaleDegree { f6 }8

  %% m2
  \markup \scaleDegree { 3 }8
  \markup \scaleDegree { f3 }8
  \tuplet 3/2 {
  \markup \scaleDegree { f2 }8
  \markup \scaleDegree { f6 }8
  \markup \scaleDegree { f2 }8
}
  \markup \scaleDegree { f3 }8
  \markup \scaleDegree { 2 }8
  \markup \scaleDegree { s1 }8
  \markup \scaleDegree { 7 }8

  %% m3
  \markup \scaleDegree { 5 }8
  \markup \scaleDegree { f2 }
  \markup \scaleDegree { 2 }
  \markup \scaleDegree { 4 }16
  \markup \scaleDegree { f4 }
  \markup \scaleDegree { f3 }8
  \markup \scaleDegree { 4 }
  \markup \scaleDegree { 5 }
  \markup \scaleDegree { f7 }

  %% m4
  \markup \scaleDegree { 6 }8
  \markup \scaleDegree { f6 }
  \markup \scaleDegree { 5 }
  \markup \scaleDegree { f5 }
  \markup \scaleDegree { 4 }
  \markup \scaleDegree { 2 }
  \markup \scaleDegree { f7 }
  \markup \scaleDegree { f6 }

  %% m5 
  \markup \scaleDegree { 1 }8
  \markup \scaleDegree { f3 }
  \markup \scaleDegree { f7 }
  \markup \scaleDegree { 5 }
  \markup \scaleDegree { 6 }
  \markup \scaleDegree { f2 }
  \markup \scaleDegree { f3 }16
  \markup \scaleDegree { f2 }
  \markup \scaleDegree { f7 }8

  %% m6
  \markup \scaleDegree { 5 }1
  
}


phraseAllC = {
  <<
    \new ChordNames { \myChords }
    \new Staff { \bar ".|" \phraseC \bar "|." }
    \scaleDegreesC
    >>
}

\score { \phraseAllC \header { piece = "C" } }
\score { \transpose c des \phraseAllC  \header { piece = "D-flat" } }
\score { \transpose c d \phraseAllC  \header { piece = "D" } }
% {
%   
%   
%   \transpose c d \phraseAllC
%   \pageBreak
%   % \transpose c g \phraseAllC
%   % \transpose c d \phraseAllC
%   % \transpose c a \phraseAllC
% }


