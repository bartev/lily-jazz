\version "2.20.0"

#(set-global-staff-size 24)
\include "jazzchords.ily"
\include "lilyjazz.ily"
\include "jazzextras.ily"
\include "roman_numeral_analysis_tool.ily"

\header {
  title = "Confirmation-Brecker phrases, H/W dim scale"
  composer = ""
  arranger = "2022-01-09"
  tagline = #f
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
    \fromproperty #'header:title " "
    \on-the-fly #print-page-number-check-first
    \fromproperty #'page:page-number-string
  }
  evenHeaderMarkup = \markup
  \fill-line {
    \on-the-fly #print-page-number-check-first
    \fromproperty #'page:page-number-string " "
    \fromproperty #'header:title
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
		  #{ <>\mark \markup \box #string #})

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



        %% Measure 1-2
	
	measI_notes = \relative c'' {
	  \key d \major
	  r2 g8 a b cis
	  d4 a2 r4
	  \bar "||"
	}
	
	measI_degrees= \lyrics {
	  2
	  \markup \scaleDegree { f7 }8
	  \markup \scaleDegree { 1 }8 
	  \markup \scaleDegree { 2 }8
	  \markup \scaleDegree { 3 }8

	  \markup \scaleDegree { 1 }4
	  \markup \scaleDegree { 5 }2 
	  4
	}

	measI_chordAnalysis = \new Lyrics \lyricmode {
	  \markup \rN { V 7 }1
	  \markup \rN { I maj 7 }1
	}

	measI_chordNames = \chordmode { a1:7 d:maj7 }

	\score {
          \header { piece = "Measures 1-2" }
	  <<
	    \measI_chordAnalysis
	    \new ChordNames {
              \measI_chordNames
              \transpose d g \measI_chordNames
	      \transpose d c \measI_chordNames
	    }
	    \new Staff \relative c'' {
	      \markManualBox "V7 - Imaj7"
	      \measI_notes
	      \naturalizeMusic \transpose d g \measI_notes
	      \naturalizeMusic \transpose d c \measI_notes
	      \break
	    }
	    \measI_degrees
	  >>
	}
	
	%% Measure 2-3
	
	measII_notes = \relative c'' {
	  \key d \major
	  r2 r4. cis8
	  ais8 fis g a ais cis e a
	  fis4 e8 d8 d4 r4
	  \bar "||"
	  \break
	}
	
	measII_degrees= \lyrics {
	  2 4 8
	  \markup \scaleDegree { 7 }8
	  
	  \markup \scaleDegree { s6 }8 
	  \markup \scaleDegree { 4 }8
	  \markup \scaleDegree { 5 }8
	  \markup \scaleDegree { n6 }8

	  \markup \scaleDegree { 3 }8
	  \markup \scaleDegree { 5 }8
	  \markup \scaleDegree { f7 }8
	  \markup \scaleDegree { f9 }8 

	  \markup \scaleDegree { 5 }4
          \markup \scaleDegree { 4 }8
	  \markup \scaleDegree { f3 }8
	  2
	}

	measII_chordAnalysis = \new Lyrics \lyricmode {
	  \markup \rN { I maj 7 }1
	  \markup \rN { vii h }2 
	  \markup \rN { III 7 f9 }2
	  \markup \rN { vi m 7 }2
	  \markup \rN { II 7 }2 
	}

	measII_chord_names= \chordmode {
	  d1:maj7
	  cis2:m7.5-
	  fis:7.9
	  b:m7
	  e:7
	}

	\score {
	  \header { piece = "Measure 2-3" }
	  <<
	    \measII_chordAnalysis
	    \new ChordNames {
              \measII_chord_names
              \transpose d g \measII_chord_names
	      \transpose d c \measII_chord_names
	    }
	    \new Staff \relative c'' {
	      \markManualBox "minor ii-v-i"
	      \measII_notes
	      \naturalizeMusic \transpose d g \measII_notes
	      \naturalizeMusic \transpose d c \measII_notes
	    }
	    \measII_degrees
	  >>
	}

	%% Measure 12 (Repeating theme)
	
	measXII_notes = \relative c' {
	  \key a \major
          fis8 gis ais cis b cis d e
	  \bar "||"
	}
	
	measXII_degrees= \lyrics {
	  \markup \scaleDegree { 5 }8
	  \markup \scaleDegree { 6 }8
	  \markup \scaleDegree { n7 }8
	  \markup \scaleDegree { 9 }8
	  \markup \scaleDegree { 5 }8
	  \markup \scaleDegree { 6 }8
	  \markup \scaleDegree { f7 }8
	  \markup \scaleDegree { 1 }8 
	}

	measXII_chordAnalysis = \new Lyrics \lyricmode {
	  \markup \rN { ii m 7 }2
	  \markup \rN { V 7 }2 
	}

	measXII_chord_names= \chordmode { b2:m7 e:7 }

	\score {
	  \header { piece = "Measure 12 (repeating theme)" }
	  <<
	    \measXII_chordAnalysis
	    \new ChordNames {
              \measXII_chord_names
              \transpose d g \measXII_chord_names
	      \transpose d c \measXII_chord_names
	    }
	    \new Staff {
	      \markManualBox "ii-v"
	      \measXII_notes
	      \naturalizeMusic \transpose d g \measXII_notes
	      \naturalizeMusic \transpose d c \measXII_notes
	      \break
	    }
	    \measXII_degrees
	  >>
}
	
	%% Measure 21-23
	
	measXXII_notes = \relative c'' {
	  \key bes \major
	  \partial 4. { c8 ees g}
	  a8 bes g ees d c cis a
	  aes g fis e f r8 r4
	  \bar "||"
	  \break
	}
	
	measXXII_degrees= \lyrics {
	  \markup \scaleDegree { 1 }8
	  \markup \scaleDegree { f3 }8
	  \markup \scaleDegree { 5 }8

	  \markup \scaleDegree { 6 }8
	  \markup \scaleDegree { f7 }8
	  \markup \scaleDegree { 5 }8
	  \markup \scaleDegree { f3 }8
	  \markup \scaleDegree { 2 }8
	  \markup \scaleDegree { 1 }8
	  \markup \scaleDegree { s1 }8
	  \markup \scaleDegree { 6 }8

	  \markup \scaleDegree { f3 }8
	  \markup \scaleDegree { 2 }8
	  \markup \scaleDegree { s1 }8
	  \markup \scaleDegree { 7 }8
	  \markup \scaleDegree { n1 }8 
	}

	measXXII_chordAnalysis = \new Lyrics \lyricmode {
	  4.
	  \markup \rN { ii m 7}1
	  \markup \rN { V 7 }1 
	}

	measXXII_chord_names= \chordmode { s4. c1:m7 f:7}

	\score {
	  \header { piece = "Measure 22" }
	  <<
	    \measXXII_chordAnalysis
	    \new ChordNames {
              \measXXII_chord_names
              \transpose d g \measXXII_chord_names
              \transpose d c \measXXII_chord_names
              \transpose d a \measXXII_chord_names
	      \transpose d a \measXXII_chord_names
	    }
	    \new Staff {
	      \markManualBox "ii-v"
	      \measXXII_notes
	      \naturalizeMusic \transpose d g \measXXII_notes
              \naturalizeMusic \transpose d c \measXXII_notes
              \naturalizeMusic \transpose d a \measXXII_notes
	      \naturalizeMusic \transpose d a, \measXXII_notes
	      \break
	    }
	    \measXXII_degrees
	  >>
	  
	}
	
