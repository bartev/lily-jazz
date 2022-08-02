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

%% https://lilypond.org/doc/v2.23/Documentation/extending/new-markup-command-definition#a-complete-example
%% These are modifiers for `\markup`, and are used as: `\markup \blue-left "some text"`.
%% It can be above or below the staff.
#(define-markup-command (blue-left layout props text) (markup?)
  "Draw left aligned blue markup text"
  (interpret-markup layout props
   #{\markup \override #'(font-name . "lilyjazz-chord") \with-color #blue { \left-align #text }#}))

#(define-markup-command (red-left layout props text) (markup?)
  "Draw left aligned blue markup text"
  (interpret-markup layout props
   #{\markup \override #'(font-name . "lilyjazz-chord") \with-color #red { \left-align #text }#}))


oldmarkBlue = #(define-music-function
             (parser location my-string)
             (string?)
             "blue markup string"
             #{ <>\mark \markup \override
             #'(font-name . "lilyjazz-chord")
                \fontsize #-2
                \with-color #blue \right-align { #my-string } #})


%% These functions can be used like `\markBlue "some text"` to create markup text above the staff
markBlue = #(define-music-function
             (parser location my-string)
             (string?)
             "red markup string"
             #{ <>\mark \markup \blue-left \fontsize #-1 #my-string #})

markRed = #(define-music-function
             (parser location my-string)
             (string?)
             "red markup string"
             #{ <>\mark \markup \red-left \fontsize #-1 #my-string #})


markManualBox = #(define-music-function
                  (parser location string)
                  (string?)
                  "manually set a box mark that matches current color/size"
                  #{ <>\mark \markup \with-color #darkred \box \sans \normalsize  #string #})

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

myChords = \chordmode { e1:m7 a:7 d1:m7 \break
                        g:7 
                        e1:m7 a:7  % d1:m7 g:7
                        \break } 

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
    \markup \scaleDegree { f9 }8
    \markup \scaleDegree { s5 }8
    \markup \scaleDegree { 3 }8
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
  \markup \scaleDegree { f13 }
  \markup \scaleDegree { f9 }
  \markup \scaleDegree { f3 }16
  \markup \scaleDegree { f9 }
  \markup \scaleDegree { f7 }8

  %% m6
  \markup \scaleDegree { 5 }1
  
}

phraseC = \relative c' {
  \markManualBox "C maj"
  r8 fis \tuplet 3/2 { b8 d fis } \markBlue "encl" ees8 e d \markBlue "encl" c
  cis8 c' \tuplet 3/2 { bes8 eis, cis! } \markBlue "Alt triplet b9-#5-3" c8 b ais \markBlue "encl" gis
  a8 ees e g16 \markBlue "embellishment" ges f8 g a c
  e8 ees d des c a f \markBlue "encl" ees
  e8 g d \markBlue "encl" b c f g16 f d8
  e1
  \bar "|." 
  \break
}

phraseF = \relative c' {
  \markManualBox "F maj"
  r8 b \tuplet 3/2 { e g b } aes a g f
  fis8 f' \tuplet 3/2 { ees ais, fis } f' e dis cis
  d8 aes a c16 ces bes8 c d f
  a8 aes g ges f d bes aes
  a8 c g e f bes! c16 bes! g8
  a1
  \bar "|." 
  \break
}

phraseG = \relative c' {
  \markManualBox "G maj"
  r8 cis \tuplet 3/2 { fis a cis } bes b a g
  gis8 g' \tuplet 3/2 { f bis, gis! } g' fis eis dis
  e8 bes b d16 des c8 d e g
  b8 bes a aes g e c bes
  b8 d a fis g c d16 c a8
  b1
  \bar "|." 
  \break
}


phraseD = \relative c'' {
  \markManualBox "D maj"
  r8 gis \tuplet 3/2 { cis e gis } f fis e d
  dis8 d' \tuplet 3/2 { c fis, dis! } d' cis bis ais
  b8 f fis a16 aes g8 a b d
  fis,8 f e ees d b g f
  fis8 a e cis d g a16 g e8
  fis1
  \bar "|." 
  \break
}


phraseA = \relative c' {
  \markManualBox "A maj"
  r8 dis \tuplet 3/2 { gis b dis } c cis b a
  eis8 e' \tuplet 3/2 { g cisis, ais! } a' gis g eis
  fis8 c b e16 ees d8 e fis a
  cis8 c b bes a fis d c
  cis8 e b gis a d e16 d b8
  cis1
  \bar "|." 
  \break
}

global = {
  \key c \major
  \numericTimeSignature
  %% make only the first clef visible
  \override Score.Clef #'break-visibility = #'#(#f #f #f)

  %% allow single-staff system bars
  \override Score.SystemStartBar #'collapse-height = #1

}

\header {
  title = \markup \override #'(font-name . "lilyjazz-chord") "iii-vi-ii-v Harmonic embellishment phrase"
  composer = "JLV lesson 14 May/June 2022"
}


\score {
  <<
    \new ChordNames { \myChords }
    \new Staff { \global \phraseC }
    \scaleDegreesC
  >>
  %% \header { piece = "C" }
}


\score {
  <<
    \transpose c g { \new ChordNames { \myChords } }
    \new Staff { \transpose c g \global \phraseG  }
    \scaleDegreesC
  >>
  %% \header { piece = "F" }
}


\score {
  <<
    \transpose c d { \new ChordNames { \myChords } }
    \new Staff { \transpose c d \global \phraseD  }
    \scaleDegreesC
  >>
  %% \header { piece = "F" }
}


\score {
  <<
    \transpose c a { \new ChordNames { \myChords } }
    \new Staff { \transpose c a \global \phraseA  }
    \scaleDegreesC
  >>
  %% \header { piece = "F" }
}

\pageBreak

\score {
  <<
    \transpose c f { \new ChordNames { \myChords } }
    \new Staff { \transpose c f \global \phraseF }
    \scaleDegreesC
  >>
  %% \header { piece = "F" }
}

\score {
  \new Staff {
    \global
    \repeat unfold 7 {
      \repeat unfold 3 { s1 }
      \break
    } 
  }
}

%% \score { \transpose c des \phraseAllC  \header { piece = "D-flat" } }
%% \score { \transpose c d \phraseAllC  \header { piece = "D" } }
                                % {
                                %   
                                %   
                                %   \transpose c d \phraseAllC
                                %   \pageBreak
                                %   % \transpose c g \phraseAllC
                                %   % \transpose c d \phraseAllC
                                %   % \transpose c a \phraseAllC
                                % }


