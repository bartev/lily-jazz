\version "2.20.0"

#(set-global-staff-size 20)
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
          \bar "||"
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
	  \bar "||"
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
	  \bar "||"          
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
	  d4 r8 fis16 e dis8 c b a
	  gis8 b d fis f a, cis e
	  \bar "||"
	  \pageBreak
	} 

        want_happy_solo_eb =  \relative c'' {
          %% 1st chorus 
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
	  \bar "||"
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
	  f8 fis ees b d e r4
	  \bar "||"
	  \break

	  \markManualBox "B"
	  \timestop "0:52"
	  r4 e8 ees d cis c b
	  r4 r8 e,8 f fis b a
	  g8 fis e ees d e g a
	  bes8 c a bes? g e des bes
	  \break

	  \timestop "0:55"
	  e8 cis d e fis a b a
	  c8 a e c dis c' b a
	  gis e a bes b g e d
	  cis e \tuplet 3/2 { c'8 b bes} a8 eis c bes
	  \bar "||"
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
	  \bar "||"
	  \pageBreak

          %% 2nd chorus
	  \markManualBox "A"
          \timestop "1:07"
	  f8 fis d b dis e cis a
	  cis8 d cis b a fis dis fis
	  e8 dis e fis g a b cis
	  fis dis e a g e dis? fis
	  \break

	  \timestop "1:11"
	  e8 a, b cis d cis b bes
	  a8 g dis e fis g fis e
	  fis4. e8~ e b'16 bes a8 gis
	  gis4 r4 r8 fis'4.~
	  \bar "||"
	  \break

	  \markManualBox "A"
          \timestop "1:14"
	  fis4 r8 e d a eis fis
	  a8 d cis e d b gis f
	  e8 fis g4 a8 a4.
	  r1
	  \break

	  \timestop "1:18"
	  e8 fis g4 a2
	  r8 fis'4. e8 d cis e
	  d8 bes a g fis a b d~
	  d4 r4 r2
	  \bar "||"
	  \break

	  \markManualBox "B"
	  \timestop "1:21"
	  b8 r d d c c d4
	  fis4. d8 c c d4~
	  d8 b r b d d b4
	  f'4. e8 d b g4~
	  \break

          \timestop "1:25"
	  g4 r fis'8 g fis e
	  dis8 fis, a b \tuplet 3/2 {c8 d c} b8 a
	  gis8 b d fis cis d16 dis e8 cis
	  d8 b gis e c' b bes a~
          \bar "||"
	  \break
	  
	  \markManualBox "A"
	  \timestop "1:29"
	  a4. d8~ d4 r4
	  r8 f4( d8 ) e d r4
	  r8 g, r4 d' r4
	  r8 aes'4 f8 g f? r4
	  \break

          \timestop "1:33"
	  r2 r8 b4 bes8
	  \markBlue "Ab?"
	  a8 g f d c a g gis
          a8 d, g gis a8 d, g gis
	  a8 d, g gis a8 d, g gis
	  \bar "||"
	  \pageBreak

	  %% 3rd chorus 
          \markManualBox "A"
          \timestop "1:36"
	  a4 d,8 e fis a b a
	  d8 cis e d cis e d cis
	  d8 b g fis e fis g gis
	  a8 a4. r8 dis, \tuplet 3/2 { e8 g b }
	  \break

	  \timestop "1:40"
	  d8 fis, \tuplet 3/2 { g b d } fis a, \tuplet 3/2 { b d fis }
	  a4 r4 r8 c r b
	  a8 g fis e dis c b a
	  gis b d fis \tuplet 3/2 {f d a} \tuplet 3/2 {bis cis e}
	  \bar "||"
          \break
	  
	  \markManualBox "A"
	  \timestop "1:44"
	  d2 b'4. a8~
	  a4 r4 r2
	  r8 d, r4 \tuplet 3/2 {b4 b' a~}
	  a4 r4 r4 b8 bes
	  \break

	  \timestop "1:47"
	  a8 fis f e b bes a g
	  f8 d \markBlue "Too Low" s4 s2
	  b8 e eis fis a ais b e
	  eis fis a ais b4 b8 bes
	  \bar "||"
	  \break
          
	  \markManualBox "B"
          \timestop "1:50"
	  a8 fis f e~ e4 r4
	  r8 fis4 a8 fis e d cis
	  e8 d cis d~ d4 r4
	  e8 f d bes g4 r4
	  \break

	  \timestop "1:54"
	  dis'8 e cis a fis a cis e
	  dis4 fis,8 a b c b a
	  ais e a bes b e ees d
	  cis b a aes g a b cis
	  \bar "||"
	  \break
          
          \markManualBox "A"
          \timestop "1:58"
	  d8 cis b bes a d, e eis
	  fis8 a b d~ d4 r4
	  r8 d4.~ d4. b8
	  d4. b8 d4 r4
	  \break

          \timestop "2:01"
	  r1
	  r8 d4 b8 d8 b g d
	  d'2 d
	  d2 d
	  \bar "||"
          \pageBreak

          \markManualBox "A"
          \timestop "2:05"
	  d4 d d d
	  d4 d8 d fis e d4~
	  d8 d4. d2
	  d4 d8 d b g fis e
	  \break

	  \timestop "2:08"
	  a8 a4. r2
          \repeat unfold 11 { s1 \break }

	}

	i_want_head_scale_degrees = \lyrics { \repeat unfold 32 { ""1 } }
	i_want_solo_scale_degrees = \lyrics {
	  
          \repeat unfold 15 { ""1 }

	  %% m48
	  \markup \scaleDegree { f3 }8
	  \markup \scaleDegree { 3 }8
	  \markup \scaleDegree { f2 }8
	  \markup \scaleDegree { 6 }8
	  \markup \scaleDegree { 1 }8
	  \markup \scaleDegree { 2 }8
	  ""4
	  
	  %% 0:52
	  %% m49
	  ""4
	  \markup \scaleDegree { 2 }8
	  \markup \scaleDegree { f2 }8
	  \markup \scaleDegree { 1 }8
	  \markup \scaleDegree { 7 }8
	  \markup \scaleDegree { f7 }8
	  \markup \scaleDegree { 6 }8 

	  %% m50
	  ""4.
	  \markup \scaleDegree { 2 }8
	  \markup \scaleDegree { f3 }8
	  \markup \scaleDegree { n3 }8
	  \markup \scaleDegree { 6 }8
	  \markup \scaleDegree { 5 }8

	  %% m51
	  \markup \scaleDegree { 1 }8
	  \markup \scaleDegree { 7 }8
	  \markup \scaleDegree { 6 }8
	  \markup \scaleDegree { f6 }8
	  \markup \scaleDegree { 5 }8
	  \markup \scaleDegree { n6 }8
	  \markup \scaleDegree { 1 }8
	  \markup \scaleDegree { 2 }8

	  %% m52
	  \markup \scaleDegree { f7 }8
	  \markup \scaleDegree { 1 }8
	  \markup \scaleDegree { 6 }8
	  \markup \scaleDegree { f7 }8
	  \markup \scaleDegree { 5 }8
	  \markup \scaleDegree { 3 }8
	  \markup \scaleDegree { f9 }8
	  \markup \scaleDegree { b7 }8

	  %% m53
	  \markup \scaleDegree { 2 }8
	  \markup \scaleDegree { 7 }8
	  \markup \scaleDegree { 1 }8
	  \markup \scaleDegree { 2 }8
	  \markup \scaleDegree { 3 }8
	  \markup \scaleDegree { 5 }8
	  \markup \scaleDegree { 6 }8
	  \markup \scaleDegree { 5 }8

	  %% m54
	  \markup \scaleDegree { f5 }8
	  \markup \scaleDegree { f3 }8
	  \markup \scaleDegree { f7 }8
	  \markup \scaleDegree { f5 }8
	  
	  \markup \scaleDegree { 3 }8
	  \markup \scaleDegree { 2 }8
	  \markup \scaleDegree { 1 }8
	  \markup \scaleDegree { f7 }8

	  %% m55
	  \markup \scaleDegree { 3 }8
	  \markup \scaleDegree { 1 }8
	  \markup \scaleDegree { 4 }8
	  \markup \scaleDegree { f5 }8
	  \markup \scaleDegree { n5 }8
	  \markup \scaleDegree { f3 }8
	  \markup \scaleDegree { 1 }8
	  \markup \scaleDegree { f7 }8

	  %% m56
	  \markup \scaleDegree { 3 }8
	  \markup \scaleDegree { 5 }8
	  %% triplet
	  \tuplet 3/2 {
	   
	    \markup \scaleDegree { f3 }8
	    \markup \scaleDegree { 2 }
	    \markup \scaleDegree { f2 }
	  }
	  
	  \markup \scaleDegree { 1 }8
	  \markup \scaleDegree { s5 }8
	  \markup \scaleDegree { f3 }8
	  \markup \scaleDegree { f2 }8 

	  %% m57
	  \markup \scaleDegree { 5 }1

	  %% m58
	  \markup \scaleDegree { 6 }4.
          \markup \scaleDegree { 1 }8
	  \markup \scaleDegree { 1 }4
	  ""4

	  %% m59
	  ""8
	  \markup \scaleDegree { f7 }4.
	  \markup \scaleDegree { 5 }8
	  \markup \scaleDegree { f3 }8
          \markup \scaleDegree { 2 }8
	  \markup \scaleDegree { f2 }8

	  %% m60
	  \markup \scaleDegree { 5 }4.
	  \markup \scaleDegree { 1 }4.
	  ""4

	  %% m61
	  ""8
	  \markup \scaleDegree { 2 }4.
	  \markup \scaleDegree { f7 }8
	  \markup \scaleDegree { 5 }8
	  ""8
	  \markup \scaleDegree { 4 }8

	  %% m62
	  \markup \scaleDegree { 1 }4
	  \markup \scaleDegree { f1 }8
	  \markup \scaleDegree { f7 }8
	  \markup \scaleDegree { 6 }8
	  \markup \scaleDegree { 1 }8
	  \markup \scaleDegree { 2 }8
	  \markup \scaleDegree { 4 }8

	  %% m63
	  \markup \scaleDegree { 1 }4
	  ""2.

	  %% m64
	  ""2
	  \markup \scaleDegree { s5 }8
	  \markup \scaleDegree { 6 }8
	  ""4
	  
				% \repeat unfold 4 { ""1 }

	  %% 2nd chorus
	  %% m65
	  \markup \scaleDegree { f3 }8
	  \markup \scaleDegree { n3 }8
	  \markup \scaleDegree { 1 }8
	  \markup \scaleDegree { 6 }8

	  \markup \scaleDegree { s5 }8
	  \markup \scaleDegree { 6 }8
	  \markup \scaleDegree { 4 }8
	  \markup \scaleDegree { 2 }8

	  %% m66
	  \markup \scaleDegree { 5 }8
	  \markup \scaleDegree { f6 }8
	  \markup \scaleDegree { 5 }8
	  \markup \scaleDegree { 4 }8
	  \markup \scaleDegree { f7 }8
	  \markup \scaleDegree { 5 }8
	  \markup \scaleDegree { 3 }8
	  \markup \scaleDegree { 5 }8

	  %% m67
	  \markup \scaleDegree { 1 }8
	  \markup \scaleDegree { n7 }8
	  \markup \scaleDegree { 1 }8
	  \markup \scaleDegree { 2 }8
	  
	  \markup \scaleDegree { f3 }8
	  \markup \scaleDegree { 4 }8
	  \markup \scaleDegree { 5 }8
	  \markup \scaleDegree { 6 }8

	  %% m68
	  \markup \scaleDegree { 6 }8
	  \markup \scaleDegree { s4 }8
	  \markup \scaleDegree { 5 }8
	  \markup \scaleDegree { 1 }8
	  \markup \scaleDegree { f7 }8
	  \markup \scaleDegree { 5 }8
	  \markup \scaleDegree { s4 }8
	  \markup \scaleDegree { 6 }8

	  %% m69
	  \markup \scaleDegree { 1 }8
	  \markup \scaleDegree { 4 }8
	  \markup \scaleDegree { 5 }8
	  \markup \scaleDegree { 6 }8

	  \markup \scaleDegree { f7 }8
	  \markup \scaleDegree { 6 }8
	  \markup \scaleDegree { 5 }8
	  \markup \scaleDegree { f5 }8

	  %% m70
	  \markup \scaleDegree { 1 }8
	  \markup \scaleDegree { f7 }8
	  \markup \scaleDegree { s4 }8
	  \markup \scaleDegree { 5 }8
	  
	  \markup \scaleDegree { 6 }8
	  \markup \scaleDegree { f7 }8
	  \markup \scaleDegree { 6 }8
	  \markup \scaleDegree { 5 }8

	  %% m71
	  \markup \scaleDegree { 3 }4.
          ""8
	  \markup \scaleDegree { 4 }8
	  \markup \scaleDegree { 1 }16
	  \markup \scaleDegree { f1 }16
	  \markup \scaleDegree { f7 }8
	  \markup \scaleDegree { 6 }8

	  %% m72
	  \markup \scaleDegree { 3 }4
	  ""4.
	  \markup \scaleDegree { 6 }4.

	  %% m73
	  \markup \scaleDegree { 3 }4
	  ""8
	  \markup \scaleDegree { 6 }8
	  \markup \scaleDegree { 5 }8
	  \markup \scaleDegree { 2 }8
	  \markup \scaleDegree { s6 }8
	  \markup \scaleDegree { 7 }8

	  %% m74
	  \markup \scaleDegree { f3 }8
	  \markup \scaleDegree { f6 }8
	  \markup \scaleDegree { 5 }8
	  \markup \scaleDegree { f7 }8

	  \markup \scaleDegree { f3 }8
	  \markup \scaleDegree { 1 }8
	  \markup \scaleDegree { 6 }8
	  \markup \scaleDegree { f5 }8

	  %% m75
	  \markup \scaleDegree { 1 }8
	  \markup \scaleDegree { 2 }8
	  \markup \scaleDegree { f3 }4
	  \markup \scaleDegree { 5 }8
	  \markup \scaleDegree { 5 }4.

	  %% m76
	  ""1
	  
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
	      \repeat unfold 4 {\want_happy_chordNames \pageBreak}
	    }
	    \new Staff {
	      \global
	      \want_happy_head_eb
	      \want_happy_solo_eb
	      %% \pageBreak
	    }
	    {
	      \i_want_head_scale_degrees
	      \i_want_solo_scale_degrees
	    }
	    %% \dimScaleDegrees
	  >>
	}
	\pageBreak
	\blankStaves
	
