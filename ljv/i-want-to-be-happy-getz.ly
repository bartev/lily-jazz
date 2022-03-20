\version "2.20.0"

#(set-global-staff-size 21)
\include "jazzchords.ily"
\include "lilyjazz.ily"
\include "jazzextras.ily"
\include "roman_numeral_analysis_tool.ily"

title = "I Want To Be Happy"
composer = "Vincent Youmans"
arranger = ""
tagline = "Stan Getz and Oscar Peterson Trio"
meter = "256"
copyright = "copyright string"

realBookTitle = \markup {
  \score {
    {
      \override TextScript.extra-offset = #'(0 . -4.5)
      s4
      s^\markup{
        \fill-line {
          \fontsize #1 \lower #2 \rotate #7 \concat {\note #"4" #1 " = " #meter }
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
    \on-the-fly #print-page-number-check-first
    \fromproperty #'page:page-number-string
  }
  evenHeaderMarkup = \markup
  \fill-line {
    \on-the-fly #print-page-number-check-first
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
  \key d \major
				% %% beam across 4 eighth notes
				% \time #'(4) 2/4

  %% make only the first clef visible
  \override Score.Clef #'break-visibility = #'#(#f #f #f)

  %% make only the first time signature visible
  %% \override Score.KeySignature #'break-visibility = #'#(#f #f #f)

  %% allow single-staff system bars
  \override Score.SystemStartBar #'collapse-height = #1

  \set Score.markFormatter = #format-mark-box-alphabet

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

	want_happy_head_eb = \relative c' {
	  \markManualBox "A"
	  \timestop "0:07" 
	  fis4 a2 fis4
	  a4. a8 fis fis a4
	  g4 a2 g4
	  a4. a8 g g a a
	  \break

	  \timestop "0:11"
	  g4 a2 g4
	  fis'4 r fis r8 d~
	  d4 r r r8 fis16 e
	  d8 b a g fis a4.~
	  \break
	  
	  \markManualBox "A"
	  \timestop "0:15"
	  a8 a fis4 a4. a8
	  fis4 a~ a8 a fis4
	  g4 a2 g4
	  a2 g8 g a4
	  \break

          \timestop "0:19"
	  g4 a~ a8 a g4
	  fis'4. a16 g fis8 d b a
	  cis8 d r4 r2
	  r4 r8 d,8 fis a b d
	  \break

	  \markManualBox "B"
          \timestop "0:22"
	  c2 d4 a
	  c4. d8~ d2
	  b2 d4 b8 g~
	  g4 r4 r2
          \break

          \timestop "0:26"
	  r8 fis4. a4 fis
	  a2 b4. e,8~
	  e2 r2
	  r8 a r a gis gis g4
          \break
	  
          \markManualBox "A"
	  \timestop "0:30"
	  fis4 a2 fis4
	  a4. a8 fis fis a4
	  g4 a2 g4
	  a4. a8 fis fis a a
	  \break
          
          \timestop "0:33"
	  g4 a2 g4
	  r2 fis'4 r4
	  d4 r8 fis16 e d8 b a g
	  fis8 a cis fis f a, cis e
	  \pageBreak
	} 

        want_happy_solo_eb =  \relative c'' {
	  \markManualBox "A"
          \timestop "0:37"
	  d4. a8 fis a4.~
	  a2 fis8 fis a4
	  g4. e8 g4 a~
	  a2 r2
	  \break
	  
	  \timestop "0:41"
	  a4 a8 a g g e r
	  a4 r8 a g g e4
	  r8 a r a fis fis dis4
	  g4. g8 e e cis4
	  \break

	  \markManualBox "A"
	  \timestop "0:45"
	  a'4 a8 a fis fis d4
	  fis4. a8 r2
	  r8 a r a g g e4
	  g4. a8 r4 fis'~
	  \break
	  
          \timestop "0:49"
	  fis4 r d8 b~ b g~
	  g4 r fis'4. d8~
	  d2 r2
	  f8 fis ees b d ees r4
	  \break

	  \markManualBox "B"
	  \timestop "0:52"
	  r4 e8 ees d cis c b
	  r4 r8 e,8 f fis b a
	  g8 fis e ees d e g a
	  bes8 c a bes? g e cis bes
	  \break

	  \timestop "0:55"
	  e8 cis d e fis a b a
	  c8 a e c dis c' b a
	  gis e a ais b g e d
	  cis e \tuplet 3/2 { c'8 b bes} a8 f c bes
	  \break

	  \markManualBox "A"
	  \timestop "1:00"
	  a1 
	  d'4. b8~ b4 r
	  r8 d4. b8 g fis f
	  e4. a8~ a4 r
	  \break

	  \timestop "1:03"
	  r8 fis'4. d8 b r a'~
	  a4 aes8 g fis a, b d~
	  d4 r4 r2
	  r2 eis8 fis r4
	  \pageBreak
	  
	  \repeat unfold 4 { s1 } \break
	  \repeat unfold 4 { s1 } \break

	  \repeat unfold 4 { s1 } \break
	  \repeat unfold 4 { s1 } \break

	  \repeat unfold 4 { s1 } \break
	  \repeat unfold 4 { s1 } \break
	  \repeat unfold 4 { s1 } \break
	  \repeat unfold 4 { s1 } \break
	  \repeat unfold 4 { s1 } \break
	  \repeat unfold 4 { s1 } \break
	  \repeat unfold 4 { s1 } \break
	  \repeat unfold 4 { s1 } \break
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

	want_happy_chordNames = \chordmode {
	  %% A
	  d2 g:maj7
	  fis2:m7 b:7.9-
	  e1:m7
	  a1:7

	  e1:m7
	  a1:7
	  d2 b:m7
	  e2:m7 a:7

	  %% A*
	  d2 g:maj7
	  fis2:m7 b:7.9-
	  e1:m7
	  a1:7

	  e1:m7
	  a1:7
          d1
	  d1

	  %% B
          d1:7
	  d1:7
	  g1:6
	  c1:9

	  d1:maj7
	  fis2:m7 b:7
	  e1:9-.5-
	  a1:7.5+
	  
	  %% A
	  d2 g:maj7
	  fis2:m7 b:7.9-
	  e1:m7
	  a1:7

	  e1:m7
	  a1:7
	  d2 b:m7
	  e2:m7 a:7
	}

	%% not sure where I got these from
	bad_want_happy_chordNames = \chordmode {
	  %% A
	  a2:maj7 d:7
	  cis2:m7 fis:7
	  b1:m7
	  e:7

	  b1:m7
	  e1:7
	  a2:6 fis:m7
	  b2:m7 e:7

	  %% A
	  a2:maj7 d:7
	  cis2:m7 fis:7
	  b1:m7
	  e:7

	  b1:m7
	  e1:7
          a1:6
	  a1:6

	  %% B
	  e1:m7
	  a1:7
	  d1:maj7
	  g1:7
	  
	  cis1:m7
	  fis:7
	  b1:7
	  e1:7

	  %% A
	  a2:maj7 d:7
	  cis2:m7 fis:7
	  b1:m7
	  e:7

	  b1:m7
	  e1:7
	  a2:6 fis:m7
	  b2:m7 e:7
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
	    %% \stella_chordAnalysis
            \new ChordNames {
              \want_happy_chordNames
	      \repeat unfold 2 {\want_happy_chordNames \pageBreak}
	    }
	    \new Staff {
	      \global
	      \want_happy_head_eb
	      \want_happy_solo_eb
	      %% \pageBreak
	    }
	    %% \dimScaleDegrees
	  >>
	}
	\pageBreak
	\blankStaves
	
