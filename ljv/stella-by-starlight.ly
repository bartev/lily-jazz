\version "2.24.0"

#(set-global-staff-size 21)
\include "jazzchords.ily"
\include "lilyjazz.ily"
\include "jazzextras.ily"
\include "roman_numeral_analysis_tool.ily"

title = "Stella By Starlight"
composer = "Victor Young"
arranger = ""
tagline = "Real Book p 408"
meter = "220"
copyright = "copyright string"

realBookTitle = \markup {
  \score {
    {
      \override TextScript.extra-offset = #'(0 . -4.5)
      s4
      s^\markup{
        \fill-line {
          \fontsize #1 \lower #2 \rotate #7 \concat {\note {4} #1 " = " #meter }
          \fontsize #5
          \override #'(offset . 7)
          \override #'(thickness . 6)
          \underline \larger #title
          \fontsize #1 \lower #1 \concat { #composer " " }
        }
      }
      s
    }
    \layout {
      \omit Staff.Clef
      \omit Staff.TimeSignature
      \omit Staff.KeySignature
      ragged-right = ##f
      ragged-bottom = ##t
      last-ragged-bottom = ##t
    }
  }
}


\header {
  title = \realBookTitle
  tagline = ##f
  copyright = \copyright
}

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

  top-margin = 0.5\in
  bottom-margin = 0.5\in
  left-margin = 0.5\in
  right-margin = 0.5\in
  indent = 0\mm

  %% between-system-space = 2.\cm
  %% between-system-padding = #0

  %%set to ##t if your score is less than one page:
  ragged-last-bottom = ##t
  ragged-bottom = ##t
  
  %% markup-system-spacing = #'((basic-distance . 23)
%%                            (minimum-distance . 8)
%%                            (padding . 1))
  oddHeaderMarkup = \markup
  \fill-line {
    \title
    %% \fromproperty #'header:title " "
    \if \should-print-page-number
    \fromproperty #'page:page-number-string
  }
  evenHeaderMarkup = \markup
  \fill-line {
    \if \should-print-page-number
    \fromproperty #'page:page-number-string " "
    %% \fromproperty #'header:title
    \title
  }
}

\layout {
  \context {
    \Lyrics \override LyricText.font-name = #"serif"
  }
  \numericTimeSignature
}

global = {
  \numericTimeSignature
  %% http://lilypond.org/doc/v2.18/Documentation/notation/displaying-rhythms#time-signature
				% %% beam across 4 eighth notes
				% \time #'(4) 2/4

  %% make only the first clef visible
  \override Score.Clef.break-visibility = #'#(#f #f #f)

  %% make only the first time signature visible
  %% \override Score.KeySignature.break-visibility = #'#(#f #f #f)

  %% allow single-staff system bars
  \override Score.SystemStartBar.collapse-height = #1

  \set Score.rehearsalMarkFormatter = #format-mark-box-alphabet

  \override Score.RehearsalMark.self-alignment-X = #LEFT
}


%%%%%%%%%%%%%%%%%%%% Functions

timestop = #(define-music-function
	     (parser location string)
	     (string?)
	     "colored markup (for timestamps)"
	     #{ <>^\markup \large \with-color #red #string #})

markManualBox = #(define-music-function
		  (parser location string)
		  (string?)
		  "manually set a box mark that matches current color/size"
		  #{ <>\mark \markup \with-color #darkred \box \sans \normalsize  #string #})

markBlue = #(define-music-function
	     (parser location string)
	     (string?)
	     "blue markup string"
	     #{ <>\mark \markup \override
	     #'(font-name . "lilyjazz-chord")
		\fontsize #-6
		\with-color #blue #string #})

#(define (naturalize-pitch p)
  (let ((o (ly:pitch-octave p))
	(a (* 4 (ly:pitch-alteration p)))
	;; alteration, a, in quarter tone steps,
	;; for historical reasons
	(n (ly:pitch-notename p)))
   (cond
    ((and (> a 1) (or (eqv? n 6) (eqv? n 2)))
     (set! a (- a 2))
     (set! n (+ n 1)))
    ((and (< a -1) (or (eqv? n 0) (eqv? n 3)))
     (set! a (+ a 2))
     (set! n (- n 1))))
   (cond
    ((> a 2) (set! a (- a 4)) (set! n (+ n 1)))
    ((< a -2) (set! a (+ a 4)) (set! n (- n 1))))
   (if (< n 0) (begin (set! o (- o 1)) (set! n (+ n 7))))
   (if (> n 6) (begin (set! o (+ o 1)) (set! n (- n 7))))
   (ly:make-pitch o n (/ a 4))))

	#(define (naturalize music)
	  (let ((es (ly:music-property music 'elements))
		(e (ly:music-property music 'element))
		(p (ly:music-property music 'pitch)))
	   (if (pair? es)
	    (ly:music-set-property!
	     music 'elements
	     (map naturalize es)))
	   (if (ly:music? e)
	    (ly:music-set-property!
	     music 'element
	     (naturalize e)))
	   (if (ly:pitch? p)
	    (begin
	     (set! p (naturalize-pitch p))
	     (ly:music-set-property! music 'pitch p)))
	   music))

	naturalizeMusic =
	#(define-music-function (m)
	  (ly:music?)
	  (naturalize m))

	%% Start with blank staves
	blankStaves= \score {
	  {
	    \repeat unfold 11 { s1 \break }
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

	%% \blankStaves
	%% \pageBreak


	%% Head

	stella_head_eb = \relative c''' {
	  \key g \major
	  \partial 4 {g4}
	  \bar "||"
	  \markManualBox "A"
	  fis1~
	  fis4 e fis g
	  d1~
	  d2. d4
          \break
	  e1~
	  e4 d d e
	  g,1~
	  g2. a4
	  \bar "||"
	  \break
	  c4 b a g
	  b2. cis4
	  e4. d8 d2~
	  d2. e4
	  \break
	  g4 fis e d
	  e2 fis4 g
	  b4. a8 a2~
	  a2 b
	  \bar "||"
	  \break
	  \markManualBox "B"
	  c1~
	  c4 c c b
	  d1~
	  d4 c \tuplet 3/2 {b4 a g}
	  \break
	  b2 b~
	  b4 a g fis
	  a1~
	  a2. g4
	  \break
	  \bar "||"
	  \markManualBox "C"
	  fis1~
	  fis4 e fis g
	  d1~
	  d4 d d c
	  \break
	  ees1~
	  ees4 ees ees d
	  d1~
	  d1
	  \bar "||"
	}
        
	dimScaleDegrees = \lyrics {
	  \markup \scaleDegree { 1 }8
	  \markup \scaleDegree { f2 }8
	  \markup \scaleDegree { f3 }8
	  \markup \scaleDegree { f4 }8
	  \markup \scaleDegree { f5 }8
	  \markup \scaleDegree { n5 }8
	  \markup \scaleDegree { 6 }8
	  \markup \scaleDegree { f7 }8

	  \markup \scaleDegree { 1 }8
	  \markup \scaleDegree { s1 }8
	  \markup \scaleDegree { s2 }8
	  \markup \scaleDegree { 3 }8
	  \markup \scaleDegree { s4 }8
	  \markup \scaleDegree { 5 }8
	  \markup \scaleDegree { 6 }8
	  \markup \scaleDegree { s6 }8
	}

	stella_head_chordNames = \chordmode {
	  \partial 4 {s4}
	  cis1:m7.5-
	  fis:7.9-
	  a:m7
	  d:7

	  d:m7
	  g:7
	  c:maj7
	  f:7

	  g:maj7
          cis2:m7.5- fis:7.9-
	  b1:m7
	  g2:m7 c:7

	  %% iRealPro has slightly different changes here
	  d1:maj7
	  %% cis2:m7.5- fis:7 % Real Book
	  cis1:m7.5- % iRealPro
	  %% fis1:m7.5- % Real Book
	  c1:maj7.11+ % iRealPro (C lyd?)
	  b:7.9-

          %% Real Book has E+7
	  %% e1:7.13-
	  %% e1:7.13-
          e1:aug7 
	  e1:aug7
          a1:m7
	  a1:m7
	  
          f1:7.11+
	  f1:7.11+
          g1:maj7
	  g1:maj7
	  
	  %% C
	  e1:m7.5-
	  a1:7.9-
	  d1:m7.5-
	  g1:7.9-

	  a1:m7.5-
	  d1:7.9-
          g1:maj7
	  g1:maj7
	}

	stella_chordAnalysis= \new Lyrics \lyricmode {
	  \partial 4 {""4}

	  \markup \rN { vii h 7/ V }1
	  \markup \rN { III 7(f9) / V }1
	  \markup \rN { v -7 / V }1
	  \markup \rN { I 7 / V }1

	  \markup \rN { ii - 7 / IV }1
	  \markup \rN { V 7 / IV }1
	  \markup \rN { I / IV }1
	  \markup \rN { fVII 7 }1

	  \markup \rN { I maj 7 }1
	  \markup \rN { vii h 7/ V }2 \markup \rN { III 7(f9) / V }2
	  \markup \rN { iii - 7 }1
	  \markup \rN { i - 7 }2 \markup \rN { IV 7 }2.

	  \markup \rN { V maj 7 }1
	  \markup \rN { siv - 7f5 }1
	  \markup \rN { IV maj 7(s11) }1
	  \markup \rN { III 7f9 }1 
	  
	}
	
	\score {
	  %% \header { piece = "H/W dim scale (play on V7b9 after half-dim)"}
	  <<
	    \stella_chordAnalysis
            \new ChordNames {
	      \stella_head_chordNames
	    }
	    \new Staff {
	      \global
	      \stella_head_eb
	      
	      %% \pageBreak
	    }
	    %% \dimScaleDegrees
	  >>
	}

	\blankStaves
	
