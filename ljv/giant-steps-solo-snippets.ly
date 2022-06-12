\version "2.20.0"

%% snippets from Giant Steps to use in improv practice

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

global = {
  \numericTimeSignature
  \time 4/4
  %% \key c \major

	%% make only the first clef visible
  \override Score.Clef #'break-visibility = #'#(#f #f #f)

	%% make only the first time signature visible
  \override Score.KeySignature #'break-visibility = #'#(#f #f #f)

	%% allow single-staff system bars
  \override Score.SystemStartBar #'collapse-height = #1
}

\header {
  title = \markup \override #'(font-name . "lilyjazz-chord") "Snippets from Giant Steps to use in improv practice"
  composer = "Bartev - June 2022"
}

phrase-forty-five =  <<
  \new ChordNames { \chordmode { aes1:maj7 } }
  \new Staff \relative c'' {
    \markManualBox "m45"
    \global
    \key aes \major
    aes8 bes c ees g fis f e
    s1 \break
  }
  \lyrics {
          %% m45
          \markup \scaleDegree { 1 }8
          \markup \scaleDegree { 2 }8
          \markup \scaleDegree { 3 }8
          \markup \scaleDegree { 5 }8 
          \markup \scaleDegree { 7 }8
          \markup \scaleDegree { s6 }8
          \markup \scaleDegree { 6 }8
          \markup \scaleDegree { s5 }8 
  }
>>
\score { \phrase-forty-five }
\score { \transpose aes g \phrase-forty-five }

phrase-fifty-six =  <<
  \new ChordNames { \chordmode { d2:m7 g:7 c1:maj7 } }
  \new Staff \relative c'' {
    \markManualBox "m56"
    \global
    \key c \major
          a8 b c a e' d b a
          g4 r8 f' e c r4
    s1 \break
  }
  \lyrics {
          %% m56
          \markup \scaleDegree { 5 }8
          \markup \scaleDegree { 6 }
          \markup \scaleDegree { f7 }
          \markup \scaleDegree { 5 }
          \markup \scaleDegree { 6 }
          \markup \scaleDegree { 5 }
          \markup \scaleDegree { 3 }
          \markup \scaleDegree { 2 }

          %% m57
          \markup \scaleDegree { 5 }4
  }
>>
\score { \phrase-fifty-six }
\score { \transpose c g, \phrase-fifty-six }


phrase-eighty-eight =  <<
  \new ChordNames {
    \chordmode {
      d2:m7 g:7 c1:maj7
    }
  }
  \new Staff \relative c''' {
    \markManualBox "m88-89"
    \global
    \key c \major
    g8 fis f e d c b a
    g8 f' e b d c b d
    s1 s1 \break
  }
  \lyrics {
    \markup \scaleDegree { 4 }8
    \markup \scaleDegree { 3 }
    \markup \scaleDegree { f3 }
    \markup \scaleDegree { 2 }
    \markup \scaleDegree { 5 }
    \markup \scaleDegree { 4 }
    \markup \scaleDegree { 3 }
    \markup \scaleDegree { 2 }
%% m89
    \markup \scaleDegree { 5 }8
    \markup \scaleDegree { 4 }
    \markup \scaleDegree { 3 }
    \markup \scaleDegree { 7 }
    \markup \scaleDegree { 9 }
    \markup \scaleDegree { 1 }
    \markup \scaleDegree { 7 }
    \markup \scaleDegree { 9 }
  }
>>
\score { \phrase-eighty-eight }
\score { \transpose c g, \phrase-eighty-eight }


phrase-one-fifty-four =  <<
  \new ChordNames {
    \chordmode {
      fis2:m7 b:7 e1:maj7
    }
  }
  \new Staff \relative c'' {
    \markManualBox "m154"
    \global
    \key e \major
    r2 e8 cis dis fis
    e8 b gis e b'4 r
    s1 s1 \break
  }
  \lyrics {
    %% m154
    ""2
    \markup \scaleDegree { 4 }8
    \markup \scaleDegree { 2 }
    \markup \scaleDegree { 3 }
    \markup \scaleDegree { 5 }
    %% m155
    \markup \scaleDegree { 1 }8
    \markup \scaleDegree { 5 }
    \markup \scaleDegree { 3 }
    \markup \scaleDegree { 1 }
    \markup \scaleDegree { 5 }4
    ""
  }
>>
\score { \phrase-one-fifty-four }
\score { \transpose e d \phrase-one-fifty-four }



\score {
  \new Staff {
    \global
    \repeat unfold 7 {
      \repeat unfold 3 { s1 }
      \break
    } 
  }
}

