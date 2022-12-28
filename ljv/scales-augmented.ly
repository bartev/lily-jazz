\version "2.24.0"

%% Augmented scales

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
  ragged-right = ##f
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

markManual = #(define-music-function
               (parser location string)
               (string?)
               "manually set a mark that matches current color/size"
               #{ <>\mark \markup \with-color #darkred \sans \normalsize  #string #})

global = {
  \numericTimeSignature
  \time 4/4
  %% \key c \major

	%% make only the first clef visible
  \override Score.Clef.break-visibility = #'#(#f #f #f)

	%% make only the first time signature visible
  \override Score.KeySignature.break-visibility = #'#(#f #f #f)

	%% allow single-staff system bars
  \override Score.SystemStartBar.collapse-height = #1
}

\header {
  title = \markup \override #'(font-name . "lilyjazz-chord") "Augmented Scales"
  composer = "Bartev - June 2022"
}

scale-degrees =     \lyrics {
      \markup \scaleDegree { 1 }8
      \markup \scaleDegree { f3 }
      \markup \scaleDegree { 3 }
      \markup \scaleDegree { 5 }
      \markup \scaleDegree { s5 }
      \markup \scaleDegree { 7 }
      \markup \scaleDegree { 1 }
      ""
      \markup \scaleDegree { 1 }
      \markup \scaleDegree { 3 }
      \markup \scaleDegree { s5 }
      ""
      \markup \scaleDegree { f3 }
      \markup \scaleDegree { 5 }
      \markup \scaleDegree { 7 }
      ""
    }

\score {
  <<
    \new Staff \relative c' {
      \global
      \markManual "C" c8 ees e g gis b c r
      c,8 ^\markup \blue-left "Aug triad on C" e gis r
      ees ^\markup \blue-left "Aug triad on Eb" g b r 
      \break
    }
    \scale-degrees
  >>
  \layout {
    \context { \Staff \omit TimeSignature }
  }
} 

\score {
  <<
    \new Staff \relative c' {
      \global
      \markManual "Db" des8 fes f aes a c des r
      des,8 ^\markup \blue-left "Aug triad on Db" f a r
      fes ^\markup \blue-left "Aug triad on Fb (E)" aes c r
      \break
    }
    \scale-degrees
  >>
  \layout {
    \context { \Staff \omit TimeSignature }
  }
} 

\score {
  <<
    \new Staff \relative c' {
      \global
      \markManual "D" d8 f fis a ais cis d r
      d,8 ^\markup \blue-left "Aug triad on D" fis ais r
      f ^\markup \blue-left "Aug triad on F" a cis r
      \break
    }
    \scale-degrees
  >>
  \layout {
    \context { \Staff \omit TimeSignature }
  }
} 


\score {
  <<
    \new Staff \relative c' {
      \global
      \markManual "Eb" ees8 ges g bes b d ees r
      ees,8 ^\markup \blue-left "Aug triad on Eb" g b r
      ges ^\markup \blue-left "Aug triad on Gb" bes d r
      \break
    }
    \scale-degrees
  >>
  \layout {
    \context { \Staff \omit TimeSignature }
  }
} 

